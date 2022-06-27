output "Public_IP_Load_Balancer" {
  value = [oci_load_balancer.load_balancer.ip_addresses]
}
output "Public_IP_server1" {
  value = [oci_core_instance.instance_server[0].public_ip]
}
output "Public_IP_server2" {
  value = [oci_core_instance.instance_server[1].public_ip]
} 