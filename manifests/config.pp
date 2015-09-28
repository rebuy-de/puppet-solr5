class solr5::config inherits solr5 {
  $config_file = "${solr_data_dir}/solr.in.sh"

  solr5::extract_file { 'solr.in.sh':
     path_to_archive  => $solr5::package_target_dir,
     archive_filename => $solr5::solr_archive_file_name,
     file_to_extract  =>'solr.in.sh'
  }  

  concat { $config_file:
    ensure => present,
    owner  => $solr_user,
    group  => $solr_user
  } 

  concat::fragment { 'solr_config_base':
    target  => $config_file,
    source  => "${solr5::package_target_dir}/solr.in.sh",
    order   => '01',
    require => Solr5::Extract_file ['solr.in.sh']
  } 

  $settings = concat($init_config, [
    "SOLR_PID_DIR=${solr_data_dir}",
    "SOLR_HOME=${solr_data_dir}/data",
    "LOG4J_PROPS=${solr_data_dir}/log4j.properties",
    "SOLR_LOGS_DIR=${solr_data_dir}/logs",
    "SOLR_PORT=${solr_port}"
  ]) 

  concat::fragment { 'solr_config_ext':
    target  => $config_file,
    content => template('solr5/solr.in.sh.erb'),
    order   => '02'
  }

  
}
