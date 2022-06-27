variable "region" {
	default = ""
}
variable "compartment_ocid" {
    default = ""
}
variable "tenancy_ocid" {
    default = ""  
}
variable "user_ocid" {
    default = ""
}
variable "fingerprint" {
    default = ""
}
variable "" {
    default = ""
}
variable "ssh_authorized_keys" {
    default = ""
    sensitive = true
}
variable "path_local_public_key" {
  default = ""
  sensitive = true
}
