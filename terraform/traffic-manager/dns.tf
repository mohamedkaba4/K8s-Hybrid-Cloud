resource "aws_route53_record" "aks" {
  zone_id = "Z0991765E7YY0D01LGNQ"
  name    = "aks.arc.mavencrest.site"
  type    = "A"
  ttl     = 60

  records = ["172.191.123.174"]
}
