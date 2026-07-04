############################
# IAM Role + Instance Profile
############################

resource "aws_iam_role" "this" {
  name = "${var.name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# SSM Access (no SSH needed)
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# RDS Access (if needed)
resource "aws_iam_role_policy_attachment" "rds" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# S3 Access (if needed)
resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-instance-profile"
  role = aws_iam_role.this.name
}

############################
# Security Group
############################

resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "EC2 security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port = ingress.value.port
      to_port   = ingress.value.port
      protocol  = "tcp"

      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      description     = lookup(ingress.value, "description", null)
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

############################
# Launch Template
############################

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt"
  image_id      = var.ami
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = base64encode(var.user_data)

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.common_tags, {
      Name = "${var.name}-ec2"
    })
  }
}

############################
# Auto Scaling Group
############################

resource "aws_autoscaling_group" "this" {
  name                      = "${var.name}-asg"
  vpc_zone_identifier       = var.subnets
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = var.target_group_arns

  depends_on = [aws_launch_template.this]

  mixed_instances_policy {

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.this.id
        version            = "$Latest"
      }

      dynamic "override" {
        for_each = length(var.instance_types) > 0 ? var.instance_types : [var.instance_type]

        content {
          instance_type = override.value
        }
      }
    }

    # instances_distribution {
    #   on_demand_base_capacity                  = var.on_demand_base_capacity
    #   on_demand_percentage_above_base_capacity = var.on_demand_percentage
    #   spot_allocation_strategy                 = "capacity-optimized"
    # }

  }

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"

  }

  # Tags propagated to EC2
  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.name
    propagate_at_launch = true
  }
}

############################
# CPU Auto Scaling Policy
############################

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "${var.name}-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.cpu_target_value
  }
}