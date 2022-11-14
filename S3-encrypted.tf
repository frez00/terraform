resource "aws_s3_bucket" "tahasencryption1114" {
    bucket = "tahasencryption"

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
} 