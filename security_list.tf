resource "oci_core_security_list" "security_list_terra" {
	compartment_id = var.compartment_ocid
	vcn_id = oci_core_vcn.vcn_terra.id
	display_name = "SL_terra"

	egress_security_rules {
		destination = "0.0.0.0/0"
		protocol = "all"
		}


	ingress_security_rules {
		protocol = "6"
		source = "0.0.0.0/0"
		tcp_options {
			min = "22"
			max = "22"
		}
	}

		ingress_security_rules {
                protocol = "6"
                source = "0.0.0.0/0"
                tcp_options {
                        min = "80"
                        max = "80"
		}

}	
}