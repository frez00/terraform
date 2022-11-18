terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version= "~> 4.16"
        }
    }

    required_version= ">=1.2.0"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "tahascats" {
    bucket = "tahas-cat-marley1"

    tags = {
        Name = "tahas-cat-marley1"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_object" "object" {
    bucket = aws_s3_bucket.tahascats.id
    key = "kittykat"
    acl = "public-read"
    source = "../../Downloads/20210729_150630.jpg"
    etag = filemd5("../../Downloads/20210729_150630.jpg")
}