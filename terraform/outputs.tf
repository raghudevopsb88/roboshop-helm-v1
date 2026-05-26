output "parameter_count" {
  value = length(aws_ssm_parameter.config)
}

output "parameter_names" {
  value = [for p in aws_ssm_parameter.config : p.name]
}
