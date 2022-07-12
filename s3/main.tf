resource "aws_s3_bucket" "ganesh" {
   bucket = "ganesh"
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "ganesh"
     Environment = "dev"
   }
}