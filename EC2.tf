data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name  = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    iam_instance_profile = aws_iam_instance_profile.tahasinstanceforroleinterreform.name
    tags = {
        Name = "TahasWorld"
    }
}

resource "aws_iam_role" "taharoleinterraform" {
    name = "tahas-new-role-in-terraform-1118"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "tahasnewpolicyforrole" {
    name = "tahas-new-iam-policy-in-terraform-for-role"

    policy = <<POLICY
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
POLICY
}

resource "aws_iam_role_policy_attachment" "tahaspolicyattachforrole" {
    role = aws_iam_role.taharoleinterraform.name
    policy_arn = aws_iam_policy.tahasnewpolicyforrole.arn
}

resource "aws_iam_instance_profile" "tahasinstanceforroleinterreform" {
    name = "tahas-instance-for-role-in-terraform"
    role = aws_iam_role.taharoleinterraform.name
}