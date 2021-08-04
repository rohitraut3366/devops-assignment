variable "log_bucket_name" {
  description = "bucket name for alb logs"
  type        = string
  default     = "wordpress-alb-logs-932"
}

variable "bucket_acl" {
  description = "Bucket access control level"
  type        = string
  default     = "private"
}

variable "target_group_name" {
  description = "ALB target group name"
  type        = string
  default     = "wordpress-target-group"
}

variable "service_port" {
  description = "target group service port"
  type        = number
  default     = 80
}

variable "target_group_sticky" {
  type    = bool
  default = false
}

variable "health_check_path" {
  description = "health check path"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "health check port"
  type        = number
  default     = 80
}

variable "target_group_server_port" {
  description = "target group server port"
  type        = number
  default     = 80
}

variable "alb_name" {
  description = "application load balancer name"
  type        = string
  default     = "alb"
}

variable "load_balancer_type" {
  description = "load balancer type"
  type        = string
  default     = "application"
}

variable "alb_internal" {
  description = "use of load balancer internal or not"
  type        = bool
  default     = false
}

variable "vpc_id" {
  type = string
}

variable "force_destroy" { 
  description = "s3 bucket force destroy"
  type = bool
  default = false
}

variable "deletion_protection"{
    description = "Enabled Deletion Protection"
    type = bool
    default = true
}

variable "logs_prefix"{
    description = "ALB Log Prefix"
    type = string
    default = "log"
}

variable "lb_listener_port"{
    description = "Load Balancer Listener Port"
    type = string
    default = "80"
}

variable "lb_listener_protocol"{
    description = "Load Balancer Listener Protocol"
    type = string
    default = "HTTP"
}
