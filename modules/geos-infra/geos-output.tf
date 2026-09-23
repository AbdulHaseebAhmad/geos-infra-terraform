output "acm_validation_records" {
  description = "CNAME records to add manually at your DNS provider"
  value = [
    for dvo in aws_acm_certificate.geos_cert.domain_validation_options : {
      domain = dvo.domain_name
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  ]
}

output "acm_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.geos_cert_validation.certificate_arn
}