######## Load Balancer1 #######
resource "aws_lb" "lb_1" {
  name               = "lb-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb1_sg.id]
  subnets            = [aws_subnet.AZ1_pub_subnet.id, aws_subnet.AZ2_pub_subnet.id]
}

resource "aws_lb_target_group" "lb1_tg" {
  name     = "lb1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "lb1_tg_proxy1_attachment" {
  target_group_arn = aws_lb_target_group.lb1_tg.arn
  target_id        = aws_instance.az1_proxy.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "lb1_tg_proxy2_attachment" {
  target_group_arn = aws_lb_target_group.lb1_tg.arn
  target_id        = aws_instance.az2_proxy.id
  port             = 80
}


resource "aws_lb_listener" "lb1_listener" {
  load_balancer_arn = aws_lb.lb_1.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb1_tg.arn
  }
}

######## Load Balancer2 #######
resource "aws_lb" "lb_2" {
  name               = "lb-2"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb2_sg.id]
  subnets            = [aws_subnet.AZ1_priv_subnet.id, aws_subnet.AZ2_priv_subnet.id]
}

resource "aws_lb_target_group" "lb2_tg" {
  name     = "lb2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "lb2_tg_ws1_attachment" {
  target_group_arn = aws_lb_target_group.lb2_tg.arn
  target_id        = aws_instance.az1_ws.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "lb2_tg_ws2_attachment" {
  target_group_arn = aws_lb_target_group.lb2_tg.arn
  target_id        = aws_instance.az2_ws.id
  port             = 80
}

resource "aws_lb_listener" "lb2_listener" {
  load_balancer_arn = aws_lb.lb_2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb2_tg.arn
  }
}
