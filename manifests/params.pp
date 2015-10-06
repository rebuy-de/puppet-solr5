class solr5::params {
    $package_url = 'http://ftp.halifax.rwth-aachen.de/apache/lucene/solr/5.2.1/solr-5.2.1.tgz'
    $package_version = '5.2.1'
    $package_target_dir = '/tmp'
    $solr_install_dir = '/opt'
    $solr_data_dir = '/var/solr'
    $solr_port = 8983
    $solr_name = 'solr'
    $solr_user = 'solr'
    $manage_service = true
    $init_config = []
}
