class solr5::service inherits solr5 {
  if $manage_service {
    service { $solr_name:
      ensure => running,
      enable => true,
      hasstatus => false
    }
  }
}
