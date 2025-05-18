# modules/ecr/main.tf
resource "aws_ecr_repository" "this" {
  name = "uber-clone"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}
