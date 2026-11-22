terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "59b3a0c1-d71e-452f-9950-e28743627a30"
}

provider "aws" {
  region = "us-east-1"
}
