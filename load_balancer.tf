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
        #Required
        protocol = "HTTP"

        #Optional
        interval_ms = 10000
        port = 80
        return_code = 200
        timeout_in_millis = 3000
        url_path = "/"
    }
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = "backend_set_terra"
    policy = "LEAST_CONNECTIONS"

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
