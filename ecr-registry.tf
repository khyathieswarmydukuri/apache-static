resource "aws_ecr_repository" "docker-reg" {
  name                 = "helm-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}