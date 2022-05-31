# ------------ Create the actual S3 read & copy files policy ----
resource "aws_iam_policy" "copy-policy" {
  name        = "S3_read_premissions"
  description = "IAM policy to allow copy files from S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],

      "Resource": "*"
    }
  ]
}
EOF
}

# ------------------ create assume role -----------------
resource "aws_iam_role" "assume-role" {
  name               = "assume-role"
  description        = "IAM policy that allows assume role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {"Service": "ec2.amazonaws.com"},
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}
# ------------ attach the role to the policy ----------------
resource "aws_iam_role_policy_attachment" "assign-copy-policy" {
  role       = aws_iam_role.assume-role.name
  policy_arn = aws_iam_policy.copy-policy.arn
  depends_on = [aws_iam_policy.copy-policy]
}

# ------------ create a profile to be used by EC2 instance ----
resource "aws_iam_instance_profile" "assume_role_profile" {
  name = "assume_role_profile"
  role = aws_iam_role.assume-role.name
}