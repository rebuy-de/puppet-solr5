class solr5::install inherits solr5 {
  $filename = inline_template('<%= File.basename(@package_url) %>')
  $shortname = regsubst($filename, '.tgz', '', 'G')

  archive { $shortname:
    ensure => present,
    url => $package_url,
    target => $sources,
    src_target => $package_target_dir,
    strip_components => 1,
    checksum => false,
    extension => 'tgz'
  } ->

  exec { 'install-solr':
    command => "${sources}/bin/install_solr_service.sh ${package_target_dir}/${filename} \
      -u ${solr_user} \
      -d ${solr_data_dir} \
      -i ${solr_install_dir} \
      -p ${solr_port} \
      -s ${solr_name}",
    creates => '/etc/init.d/solr',
  }
}
