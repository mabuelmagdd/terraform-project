terraform {
 backend "s3" {
   bucket                  = "ab-tf-statelck"
   key                     = "terraform.tfstate"
   region                  = "us-east-1"
   dynamodb_table          = "tf-state-db"
  }
}
