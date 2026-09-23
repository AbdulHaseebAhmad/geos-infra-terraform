data "aws_route53_zone" "geos_zone" {
  name = var.geos_hosted_zone_name
}

resource "aws_acm_certificate" "geos_cert" {
  domain_name               = var.geos_domain_name
  subject_alternative_names = ["www.${var.geos_domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-cert"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.geos_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.geos_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "geos_cert_validation" {
  certificate_arn         = aws_acm_certificate.geos_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]

  timeouts {
    create = "10m"
  }
}

resource "aws_route53_record" "geos_alias" {
  zone_id = data.aws_route53_zone.geos_zone.zone_id
  name    = var.geos_domain_name
  type    = "A"

  alias {
    name                   = aws_lb.geos_alb.dns_name
    zone_id                = aws_lb.geos_alb.zone_id
    evaluate_target_health = true
  }
}