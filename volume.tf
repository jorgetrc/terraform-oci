resource "oci_core_volume" "volume_terra" {
    #Required
    compartment_id = var.compartment_ocid
    availability_domain = "JNid:SA-SAOPAULO-1-AD-1"
    size_in_gbs = 20
    display_name = "BV_TERRA"   
}
