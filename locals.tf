## Variables locales
locals {
  resource_group_name="TEST-TERRAFORM"
  location="East Us2"
  location2="Central Us"
  virtual_network = {
    address_space = "10.78.0.0/22"
    subnetAadress_space = "10.78.0.0/24"
  }
  /*
  address_space = {
    staging = "10.78.0.0/23"
    test = "10.78.2.0/23"
  }*/

  secret = "LF78Q~8_xmee-CLqLeJqTVEi6wLyLRYi.rklyaZa"

}

