resource "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
  comment = "Public"
  tags = {
    Environment = "dev"
  }
}
## For an IP Address
resource "aws_route53_record" "route53_record_set" {
  allow_overwrite = true
  name            = "www.riteshsingh85.com"
  ttl             = 300
  type            = "A"
  zone_id         = aws_route53_zone.hosted_zone.zone_id

  records = ["13.58.26.242"]
}

## For a load balancer, s3 bucket or cloudFront distribution using Alias records
resource "aws_route53_record" "aws_route53_record_set" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "xyz.riteshsingh85.com"
  type    = "A"

  alias {
    name                   = "ggfdgfgd-1758896473.us-east-2.elb.amazonaws.com"   ## DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.
    zone_id                = "Z3AADJGX6KTTL2"
    evaluate_target_health = false
  }
}
