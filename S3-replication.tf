provider "aws" {
    alias  = "central"
    region = "eu-central-1"
}

resource "aws_s3_bucket" "tahasourcebucket" {
    bucket = "tahassourcebucketinterraform1116"
    versioning {
        enabled = true
    }    
}

resource "aws_s3_bucket" "tahadestinationbucket" {
    bucket = "tahasdestinationbucketinterraform1116"
    provider = aws.central
    versioning {
        enabled = true
    }
}

resource "aws_iam_role" "tahasreplication" {
    name = "tahas-replication-role-in-terraform-1116"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "tahasiampolicy" {
    name = "tahas-iam-policy-in-terraform"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.tahasourcebucket.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
         "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.tahasourcebucket.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.tahadestinationbucket.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tahasiamrolepolicyattachment" {
    role = aws_iam_role.tahasreplication.name
    policy_arn = aws_iam_policy.tahasiampolicy.arn
}

resource "aws_s3_bucket_replication_configuration" "tahasrepconfig" {
    role = aws_iam_role.tahasreplication.arn
    bucket = aws_s3_bucket.tahasourcebucket.id

    rule {
        id = "tahasrepliationruleinterraform"
    
        status = "Enabled"

        destination {
            bucket = aws_s3_bucket.tahadestinationbucket.arn
        }
    }
}