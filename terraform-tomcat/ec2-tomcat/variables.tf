variable "provide_ami" {

}
variable "instance_type" {

}
variable "security_group" {

}
variable "subnet_id" {

}
variable "instance_name" {

}
variable "environment" {

}

variable "application_loadbalancer_name" {
}
variable "internal" {
}
variable "load_balancer_type" {
}
variable "subnets" {
}
variable "enable_deletion_protection" {
}
variable "idle_timeout" {
}
variable "target_group_name" {
}
variable "instance_port" {    #### Don't apply when target_type is lambda
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
}
variable "target_type_alb" {
}
variable "vpc_id" {
}
variable "load_balancing_algorithm_type" {
}
variable "healthy_threshold" {
}
variable "unhealthy_threshold" {
}
variable "timeout" {
}
variable "interval" {
}
variable "target_port_path" {
}
variable "ssl_policy" {
}
variable "certificate_arn" {
}
variable "type" {
}
