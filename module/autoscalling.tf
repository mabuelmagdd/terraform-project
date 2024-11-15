# Launch Template for Proxy Instances
resource "aws_launch_template" "proxy_lt" {
  name          = "proxy-template"
  instance_type = var.instance_type
  image_id = var.ami_id
  vpc_security_group_ids = [aws_security_group.az1_proxy_sg.id,
  aws_security_group.az2_proxy_sg.id]
}

# ASG for Proxy Instances
resource "aws_autoscaling_group" "proxy_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  launch_template      {id= aws_launch_template.proxy_lt.id}
  vpc_zone_identifier  = [aws_subnet.AZ1_pub_subnet.id, aws_subnet.AZ2_pub_subnet.id]
  target_group_arns    = [aws_lb_target_group.lb1_tg.arn]
}

# Launch Template for Backend Webserver Instances
resource "aws_launch_template" "ws_lt" {
  name          = "ws-template"
  instance_type = var.instance_type
  image_id = var.ami_id
  vpc_security_group_ids =[aws_security_group.az1_ws_sg.id,
  aws_security_group.az2_ws_sg.id]
}

# ASG for Backend Instances
resource "aws_autoscaling_group" "ws_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  launch_template      {id= aws_launch_template.ws_lt.id}
  vpc_zone_identifier  = [aws_subnet.AZ1_priv_subnet.id, 
  aws_subnet.AZ2_priv_subnet.id]
  target_group_arns    = [aws_lb_target_group.lb2_tg.arn]
}
