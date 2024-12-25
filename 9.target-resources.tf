resource "aws_s3_bucket" "devsecopsb42-demo-1" {
  bucket = "devsecopsb42-demo-1"
  acl    = "private"
  tags = {
    Name        = "devsecopsb42-demo-1"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "devsecopsb42-demo-2" {
  bucket = "devsecopsb42-demo-2"
  acl    = "private"
  tags = {
    Name        = "devsecopsb42-demo-2"
    Environment = var.environment
  }
  depends_on = [
    aws_s3_bucket.devsecopsb42-demo-1
  ]
}

resource "aws_s3_bucket" "devsecopsb42-demo-3" {
  bucket = "devsecopsb42-demo-3"
  acl    = "private"
  tags = {
    Name        = "devsecopsb42-demo-3"
    Environment = var.environment
  }
  depends_on = [
    aws_s3_bucket.devsecopsb42-demo-2
  ]
}
