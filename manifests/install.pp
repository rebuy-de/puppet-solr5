class solr5::install(
  $package_url,
  $package_target_dir,
  $package_version,
  $solr_archive_file_name,
  $solr_user,
  $solr_data_dir,
  $solr_install_dir,
  $solr_port,
  $solr_name
){
  archive { "${package_target_dir}/${solr_archive_file_name}":
    source      => $package_url,
  } ->

  solr5::extract_file { 'install_solr_service.sh':
    path_to_archive  => $package_target_dir,
    archive_filename => $solr_archive_file_name,
    file_to_extract  =>'install_solr_service.sh'
  } ->

  file { "${package_target_dir}/install_solr_service.sh":
    ensure => file,
    mode   => '0700'
  } ->

  exec { 'install-solr':
    command => "${package_target_dir}/install_solr_service.sh ${package_target_dir}/${solr_archive_file_name} \
    -u ${solr_user} \
    -d ${solr_data_dir} \
    -i ${solr_install_dir} \
    -p ${solr_port} \
    -s ${solr_name} \
    -f",
    creates => "${solr_install_dir}/solr-${package_version}",
  }
}
