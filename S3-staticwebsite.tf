resource "aws_s3_bucket" "tahastaticwebsite1122" {
    bucket = "tahasstaticwebsiteinterraform11221"
    versioning {
        enabled = true
    }
    lifecycle_rule {
        id      = "lifecycleruletahas2"
        enabled = true
    
    transition {
        days          = 30
        storage_class = "STANDARD_IA"
    }
    transition {
        days          = 60
        storage_class = "GLACIER"
    }
    }
}

resource "aws_s3_bucket_object" "index" {
    bucket = aws_s3_bucket.tahastaticwebsite1122.id
    key    = "index.html"
    acl    = "public-read"
    source = "./index.html"
    content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
    bucket = aws_s3_bucket.tahastaticwebsite1122.id
    key    = "error.html"
    acl    = "public-read"
    source = "./error.html"
    content_type = "text/html"
}
resource "aws_s3_bucket_website_configuration" "tahawebconfig" {
    bucket = aws_s3_bucket.tahastaticwebsite1122.bucket

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}