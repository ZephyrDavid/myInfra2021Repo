terraform {
  backend "s3" {
    bucket = "my-own-dev-tf-state-bucket"
    key = "myJenkinsKey"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb-table"
  }
}
