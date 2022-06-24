resource "oci_load_balancer_load_balancer" "load_balancer" {
    #Required
    compartment_id = var.compartment_ocid
    display_name = "LB_terra"
    shape = "flexible"
    subnet_ids = [oci_core_subnet.subnet_terra.id]

    shape_details {
        #Required
        maximum_bandwidth_in_mbps = 10 
        minimum_bandwidth_in_mbps = 10
    }
}

resource "oci_load_balancer_backend_set" "backend_set_terra" {
    #Required
    health_checker {
        protocol = "HTTP"
        interval_ms = 10000
        port = 80
        return_code = 200
        timeout_in_millis = 3000
        url_path = "/"
        retries             = "3"
    }
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = "backend_set_terra"
    policy = "ROUND_ROBIN"

	/*
    #Optional
    lb_cookie_session_persistence_configuration {

        #Optional
        cookie_name = var.backend_set_lb_cookie_session_persistence_configuration_cookie_name
        disable_fallback = var.backend_set_lb_cookie_session_persistence_configuration_disable_fallback
        domain = var.backend_set_lb_cookie_session_persistence_configuration_domain
        is_http_only = var.backend_set_lb_cookie_session_persistence_configuration_is_http_only
        is_secure = var.backend_set_lb_cookie_session_persistence_configuration_is_secure
        max_age_in_seconds = var.backend_set_lb_cookie_session_persistence_configuration_max_age_in_seconds
        path = var.backend_set_lb_cookie_session_persistence_configuration_path
    }
    */
    session_persistence_configuration {
        #Required
        cookie_name = "*"

        #Optional
        disable_fallback = false
    }

    /*

    ssl_configuration {
        #Optional
        certificate_ids = var.backend_set_ssl_configuration_certificate_ids
        certificate_name = oci_load_balancer_certificate.test_certificate.name
        cipher_suite_name = var.backend_set_ssl_configuration_cipher_suite_name
        protocols = var.backend_set_ssl_configuration_protocols
        server_order_preference = var.backend_set_ssl_configuration_server_order_preference
        trusted_certificate_authority_ids = var.backend_set_ssl_configuration_trusted_certificate_authority_ids
        verify_depth = var.backend_set_ssl_configuration_verify_depth
        verify_peer_certificate = var.backend_set_ssl_configuration_verify_peer_certificate
    }
    */
}

resource "oci_load_balancer_listener" "lb-listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set_terra.name
  #hostname_names           = [oci_load_balancer_hostname.test_hostname1.name, oci_load_balancer_hostname.test_hostname2.name]
  port                     = 80
  protocol                 = "HTTP"
  #rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]

  connection_configuration {
    idle_timeout_in_seconds = "60"
  }
}

resource "oci_load_balancer_backend" "lbb_server1" {
  depends_on = [oci_core_instance.instance_server[0]]
  backendset_name  = oci_load_balancer_backend_set.backend_set_terra.id
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  ip_address       = oci_core_instance.instance_server[0].private_ip
  offline          = false
  port             = 80
  weight           = 1
}

resource "oci_load_balancer_backend" "lbb_server2" {
  depends_on = [oci_core_instance.instance_server[1]]
  backendset_name  = oci_load_balancer_backend_set.backend_set_terra.id
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  ip_address       = oci_core_instance.instance_server[1].private_ip
  offline          = false
  port             = 80
  weight           = 1
}