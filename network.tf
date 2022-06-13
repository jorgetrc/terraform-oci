resource "oci_core_vcn" "vcn_terra" {
    #Required
    compartment_id = var.compartment_ocid
    cidr_blocks = ["10.0.0.0/16", "172.16.0.0/16"]
    display_name = "vcn_terra"
}

resource "oci_core_subnet" "subnet_terra" {
    #Required
    cidr_block = "10.0.1.0/24"
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_terra.id
    display_name = "subnet_terra"
    security_list_ids = [oci_core_security_list.security_list_terra.id]
}

resource "oci_core_internet_gateway" "terra_internet_gateway" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_terra.id
    display_name = "igw_terra"
}

resource "oci_core_route_table" "terra_route_table" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_terra.id

    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.terra_internet_gateway.id
        destination = "0.0.0.0/0"
    }
}
