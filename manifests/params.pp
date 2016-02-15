class solr5::params {
    $package_mirror = 'http://ftp.halifax.rwth-aachen.de/apache'
    $package_version = '5.2.1'
    $package_target_dir = '/tmp'
    $solr_install_dir = '/opt'
    $solr_data_dir = '/var/solr'
    $solr_port = 8983
    $solr_name = 'solr'
    $solr_user = 'solr'
    $manage_service = true
    $init_config = []
    $gc_log_file_count = 5
    $gc_log_file_size = '25M'
}
