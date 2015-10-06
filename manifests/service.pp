class solr5::service(
  $manage_service,
  $solr_name
){
  if $manage_service {
    service { $solr_name:
      ensure    => running,
      enable    => true,
      hasstatus => false
    }
  }
}
