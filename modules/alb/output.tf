############ External Application Load balancer ##########

output "web_alb_dns_name" {
  description = "The DNS name of the WEB-ALB"
  value       = aws_lb.web_alb.dns_name
}

output "web_alb_tg_name" {
    description = "The name of the WEB-ALB Target Group"
    value       = aws_lb_target_group.web_tg.name
}

output "web_alb_tg_arn" {
  description = "The ARN of the WEB-ALB Target Group"
  value       = aws_lb_target_group.web_tg.arn
}



############## Internal Application Load balancer ##########


output "app_alb_dns_name" {
  description = "The DNS name of the APP-ALB"
  value       = aws_lb.app_alb.dns_name
}

output "app_alb_tg_name" {
    description = "The name of the APP-ALB Target Group"
    value       = aws_lb_target_group.app_tg.name
}

output "app_alb_tg_arn" {
  description = "The ARN of the APP-ALB Target Group"
  value       = aws_lb_target_group.app_tg.arn
}
