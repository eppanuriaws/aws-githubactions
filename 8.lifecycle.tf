resource "aws_s3_bucket" "devsecopsb42-life-cycle2" {
  bucket = "devsecopsb42-life-cycle2"
  acl    = "private"
  tags = {
    Name        = "devsecopsb42-life-cycle2"
    Environment = var.environment
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}