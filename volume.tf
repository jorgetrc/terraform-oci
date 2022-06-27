resource "oci_core_volume" "volume_terra" {
  #Required
  compartment_id      = var.compartment_ocid
  availability_domain = "JNid:SA-SAOPAULO-1-AD-1"
  size_in_gbs         = 50
  display_name        = "BV_TERRA"
}

resource "oci_core_volume_attachment" "volume_attachment_terra" {
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.instance_server[0].id
  volume_id       = oci_core_volume.volume_terra.id
}
