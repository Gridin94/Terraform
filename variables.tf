#This file contains all the variables:

variable "prefix" {
    default = "weight-app"
}

variable "admin_username" {
    default = "user"
}

variable "admin_password" {
    default = "1111111"
}

variable "num" {
    default = 2
}

variable "storage_account_name" {
    default = "terraform1daniel"
}

variable "os_type" {
    default = "Linux"
}

variable "okta_secret" {
    default = "7EUvOmrvAiq_1won3dFSZ7Pph-5v8koocvh_zF_a"
}

variable "okta_client_id" {
    default = ""
}

variable "okta_org_url" {
    default = ""
}

variable "okta_key" {
    default = ""
}

variable "pg_user" {
    default = "postgres"
}

variable "pg_pass" {
    default = "pass"
}