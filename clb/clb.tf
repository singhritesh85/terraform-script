resource "aws_elb" "classic_loadbalancer" {
  name               = var.classic_loadbalancer_name
  availability_zones = ["${var.Availabilty_Zone[0]}", "${var.Availabilty_Zone[1]}", "${var.Availabilty_Zone[2]}"]
#  subnets = ["subnet-5d85d427", "subnet-e116afad", "subnet-ea2f3482"]

  access_logs {
    bucket        = var.bucket
    bucket_prefix = var.bucket_folder
    interval      = var.access_log_interval
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = var.ssl_certificate_id
  }

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = var.target_port_path
    interval            = var.interval
  }

#  instances                   = ["i-0f43e2c6429a7f395", "i-0fba7ed248b02684c"]
  instances                   = ["${var.instances[0]}", "${var.instances[1]}"]
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  tags = {
    Environment = "Dev"
  }
}
