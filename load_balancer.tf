resource "oci_load_balancer" "load_balancer" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "LB_terra"
  shape          = "flexible"
  subnet_ids     = [oci_core_subnet.subnet_terra.id]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "backend_set_terra" {
  #Required
  health_checker {
    protocol            = "HTTP"
    response_body_regex = ""
    interval_ms         = 10000
    port                = 80
    return_code         = 200
    timeout_in_millis   = 3000
    url_path            = "/"
    retries             = "3"
  }
  load_balancer_id = oci_load_balancer.load_balancer.id
  name             = "backend_set_terra"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_listener" "lb-listener" {
  load_balancer_id         = oci_load_balancer.load_balancer.id
  name                     = "lb-listener"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set_terra.name
  hostname_names           = []
  port                     = 80
  protocol                 = "HTTP"
  rule_set_names           = []
}

resource "oci_load_balancer_backend" "backend_server1" {
  depends_on       = [oci_core_instance.instance_server[0]]
  backendset_name  = oci_load_balancer_backend_set.backend_set_terra.name
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer.load_balancer.id
  ip_address       = oci_core_instance.instance_server[0].private_ip
  offline          = false
  port             = 80
  weight           = 1
}

resource "oci_load_balancer_backend" "backend_server2" {
  depends_on       = [oci_core_instance.instance_server[1]]
  backendset_name  = oci_load_balancer_backend_set.backend_set_terra.name
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer.load_balancer.id
  ip_address       = oci_core_instance.instance_server[1].private_ip
  offline          = false
  port             = 80
  weight           = 1
}