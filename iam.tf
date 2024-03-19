# IAM role/Instance profile /Policies


resource "aws_iam_role" "ec2_role" {

 name = "ey-ec2-role"
 assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "iam_profile" {
    name = "ey-ec2-instance-profile"
    role = aws_iam_role.ec2_role.id
}


# s3 policy

resource "aws_iam_role_policy" "s3_policy" {
  name = "ey-s3-policy"
  role = aws_iam_role.ec2_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


# ECR policy
resource "aws_iam_role_policy" "ecr_policy" {
    name = "ey-ecr-policy"
    role = aws_iam_role.ec2_role.id
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "replication.ecr.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
}

# resource "aws_iam_policy" "acm_certificate_policy" {
#   name   = "acm-certificate-policy"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": {
#         "Effect": "Allow",
#         "Action": [
#             "acm:RequestCertificate",
#             "acm:DescribeCertificate",
#             "acm:ListCertificates",
#             "acm:GetCertificate",
#             "acm:ListTagsForCertificate",
#             "acm:GetAccountConfiguration"
#         ],
#         "Resource": "*"
#     }
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "acm_policy_attachment" {
#     policy_arn = aws_iam_policy.acm_certificate_policy.arn
#     role = aws_iam_role.ec2_role.name
  
# }

