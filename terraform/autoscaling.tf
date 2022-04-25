resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = data.aws_ami.ecs.id
  security_groups      = [aws_security_group.ecs_sg.id]
  instance_type        = "t2.micro"
  key_name             = "rearckeypair"
  user_data = <<EOF
  #!/bin/bash
  echo ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config
  echo ECS_INSTANCE_ATTRIBUTES={\"purchase-option\":\"ondemand\"} >> /etc/ecs/ecs.config
  EOF
  iam_instance_profile = aws_iam_instance_profile.ec2_iam_instance_profile.arn
  
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name                 = "asg"
  vpc_zone_identifier  = [aws_subnet.public[0].id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name
  target_group_arns    = [aws_alb_target_group.app.arn]

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
