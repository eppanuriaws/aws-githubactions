resource "aws_s3_bucket" "devsecopsb38tfstate" {
  force_destroy = true
  tags = {
    Environment = "dev"
    Name        = "devsecopsb38tfstate"
  }
}
resource "aws_s3_bucket" "devsecopsb39tfstate" {
  force_destroy = true
  tags = {
    Environment = "dev"
    Name        = "devsecopsb39tfstate"
  }
}
resource "aws_s3_bucket" "awsb56data" {
  force_destroy = true
  tags = {
    Data = "Files"
    Env  = "Prod"
  }
}
