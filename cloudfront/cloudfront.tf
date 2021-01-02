resource "aws_s3_bucket" "s3_bucket" {
  bucket = "testbucket0220200101"
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
    bucket = aws_s3_bucket.s3_bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
    depends_on = [ aws_s3_bucket.s3_bucket ]
}

resource "aws_s3_bucket_object" "folder1" {
    bucket = "${aws_s3_bucket.s3_bucket.id}"
    acl    = "private"
    key    = "hex/"
    source = "/dev/null"
    depends_on = [ aws_s3_bucket.s3_bucket ]
}

locals {
 s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = ""
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_path = "/hex"
#   origin_id   = "<< EOT S3-aws_s3_bucket.s3_bucket.name/aws_s3_bucket.s3_bucket.key EOT"
    origin_id = "${local.s3_origin_id}"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  http_version     = "http2"
# trusted_signers     = "self"          ###   You want to allow to create signed URLs for private content.
  default_root_object = "index.html"   ###  Default root object
  aliases             = ["bbb.riteshsingh85.com"]
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
#   target_origin_id = "<< EOT S3-aws_s3_bucket.s3_bucket.name/aws_s3_bucket.s3_bucket.key EOT" 
    smooth_streaming = false
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = false
    
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  
  price_class = "PriceClass_All"
# retain_on_delete = true  ##Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards.
  
  tags = {
    Environment = "Dev"
  }

  viewer_certificate {
    acm_certificate_arn    = "arn:aws:acm:us-east-1:562086155953:certificate/82141513-c4dc-4ab5-b7da-13c5b1b9c536"   ## Used in case of using ACM Certificate.
    ssl_support_method     = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2019"
#   cloudfront_default_certificate = true     ###  Used this option when to use the default certificate of cloudfront.
  }
  depends_on = [ aws_s3_bucket_object.folder1 ]
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
  depends_on = [ aws_s3_bucket.s3_bucket, aws_cloudfront_distribution.s3_distribution ]
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
  depends_on = [ aws_s3_bucket.s3_bucket, aws_cloudfront_distribution.s3_distribution ]
}

resource "aws_route53_record" "route53_record_set" {
  allow_overwrite = true
  name            = "bbb.riteshsingh85.com"
  type            = "A"
  zone_id         = "Z09449912E49T9OBK0YGM"

  alias {
    name = aws_cloudfront_distribution.s3_distribution.domain_name   ## DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.
    zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [ aws_s3_bucket.s3_bucket, aws_cloudfront_distribution.s3_distribution ]
}
