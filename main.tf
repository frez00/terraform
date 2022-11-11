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
    region = "us-west-2"
}

resource "aws_s3_bucket" "tahascats" {
    bucket = "tahas-cat-marley"

    tags = {
        Name = "tahas-cat-marley"
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