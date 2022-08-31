resource "aws_ecr_repository" "mobileye-repository" {
  name                 = "mobileye-images"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "mobileye-repo-policy" {
  repository = aws_ecr_repository.mobileye-repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the mobileye repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}
