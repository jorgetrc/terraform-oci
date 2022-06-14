resource "oci_core_instance" "instance_server" {
	count = 2
	availability_domain = "JNid:SA-SAOPAULO-1-AD-1"
	compartment_id = var.compartment_ocid
	shape = "VM.Standard.E2.1.Micro"
	display_name = "server ${count.index +1}"

	source_details {
	  source_id = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaazgdqu6qyebkor2yhmzpk6kirqoxrpavmefklvuvmng3wj3f6v3a" 
	  source_type = "image"
	}

	create_vnic_details {
	  subnet_id = oci_core_subnet.subnet_terra.id
	}
	metadata = {
		ssh_authorized_keys = var.ssh_authorized_keys
	}
}
