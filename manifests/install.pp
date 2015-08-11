class solr5::install inherits solr5 {
  download_uncompress { $package_url:
    distribution_name => $package_url,
    dest_folder => $package_target_dir,
    creates => $sources,
    uncompress => 'tar.gz'
  } ->

  exec { 'install-solr':
    command => "${sources}/bin/install_solr_service.sh ${sources}.tgz \
      -u ${solr_user} \
      -d ${solr_data_dir} \
      -i ${solr_install_dir} \
      -p ${solr_port} \
      -s ${solr_name}",
    creates => '/etc/init.d/solr',
  }
}
