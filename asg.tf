resource "aws_launch_template" "instances" {
  name_prefix   = "nginx-"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg.id]
  }
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = aws_subnet.public.*.id
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2

  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.instances.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_schedule" "down" {
  scheduled_action_name  = "scale-down"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  time_zone              = "Europe/Rome"
  recurrence             = "0 18 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "up" {
  scheduled_action_name  = "scale-up"
  min_size               = 2
  max_size               = 2
  desired_capacity       = 2
  time_zone              = "Europe/Rome"
  recurrence             = "0 08 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}