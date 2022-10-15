# create a role 
resource "aws_iam_role" "jenkins-ecr" {
  name = "jenkins-ecr"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "jenkins-ecer"
  }
}

# create a policy

resource "aws_iam_policy" "jenkins-policy" {
  name        = "jenkins_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




resource "aws_iam_role_policy_attachment" "jenkins-role" {
  role       = aws_iam_role.jenkins-ecr.name
  policy_arn = aws_iam_policy.jenkins-policy.arn
}

resource "aws_iam_instance_profile" "jenkins-iam" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins-ecr.name
}