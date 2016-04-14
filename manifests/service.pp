class solr5::service(
  $manage_service,
  $solr_name
){
  if $manage_service {

    if $::service_provider == 'systemd' {
      exec {'reload service definitions to allow solr to start':
        command     => '/bin/systemctl daemon-reload',
        subscribe   => Solr5::Extract_file['install_solr_service.sh'],
        refreshonly => true,
      }
    }
    service { $solr_name:
      ensure    => running,
      enable    => true,
      hasstatus => false
    }
  }
}
