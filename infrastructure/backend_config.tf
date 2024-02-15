terraform {
    backend "s3" {
        bucket         = "bxian-acit-4640-a03-tf-state-2023-11"
        key            = "terraform.tfstate"
        dynamodb_table = "bxian-acit-4640-a03-tf-state-lock-2023-11"
        region         =  "us-west-2" 
        encrypt        = true
    }
}
