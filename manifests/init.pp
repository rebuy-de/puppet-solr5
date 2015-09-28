# == Class: solr5
#
# This manifest takes care of installing solr as a service. It does support
# managing cores or any config files but the startup script.
#
# === Parameters
#
# [*package_url*]
#   download url from the solr archive you'd like to install.
#   default: http://ftp.halifax.rwth-aachen.de/apache/lucene/solr/5.2.1/solr-5.2.1.tgz
#
# [*package_version*]
#   this paramter has to match the package version you'd like to install
#   default: 5.2.1
#
# [*package_target_dir*]
#   directory in the local filesystem where puppet stores the downloaded archive
#   default: /usr/local/src
#
# [*solr_install_dir*]
#   directory where the solr server files are installed to. Solr will create a directory
#   $solr_install_dir/solr-$version and a symlink $solr_install_dir/solr which points to the
#   created directory.
#   default: /opt
#
# [*solr_data_dir*]
#   directory where the solr will stores it's index files
#   default: /var/solr
#
# [*solr_port*]
#   solr will listen on this port for incoming connections
#   default: 8983
#
# [*solr_name*]
#   solr will register itself as a service with this name
#   default: solr
#
# [*solr_user*]
#   solr will be run as this user
#   default: solr
#
# [*manage_service*]
#   should puppet manage the solr service? If set to true, puppet will make sure
#   the service is installed and solr is running.
#   default: true
#
# [*init_config*]
#   list of additional startup values passed to solr. Take a look at https://svn.apache.org/repos/asf/lucene/dev/branches/branch_5x/solr/bin/solr.in.sh
#   to get a list of available options. Default values will be overriden by the values provided.
#   default: []
#
# === Examples
#
# Simply install solr with its default values
#
#   class { 'solr5': }
#
# Install solr version 5.2.0
#
#   class { 'solr5':
#       package_url => 'http://ftp.halifax.rwth-aachen.de/apache/lucene/solr/5.2.0/solr-5.2.0.tgz',
#       package_version => '5.2.0'
#   }
#
# Install solr and change some default values
#
#   class { 'solr5':
#       solr_install_dir => '/usr/local' # install solr to /usr/local/solr
#       solr_port => 8080 # listen on tcp port 8080
#       manage_service => false # prevent puppet from managing the solr service
#       init_config => [
#           "SOLR_HEAP = 6g" # let solr use up to 6g heap memory
#           "ZK_HOST = 127.0.0.1" # connect to zookeeper on localhost
#       ]
#   }
#
# === Authors
#
# Daniel Freudenberger <df@rebuy.de>
#

class solr5 (
    $package_url           = $solr5::params::package_url,
    $package_version       = $solr5::params::package_version,
    $package_target_dir    = $solr5::params::package_target_dir,
    $solr_install_dir      = $solr5::params::solr_install_dir,
    $solr_data_dir         = $solr5::params::solr_data_dir,
    $solr_port             = $solr5::params::solr_port,
    $solr_name             = $solr5::params::solr_name,
    $solr_user             = $solr5::params::solr_user,
    $manage_service        = $solr5::params::manage_service,
    $init_config           = $solr5::params::init_config
  ) inherits solr5::params {

  $sources = "${package_target_dir}/solr-${package_version}"
  $solr_archive_file_name = "solr-${package_version}.tgz"

  anchor { 'solr5::begin': } ->
  class { '::solr5::install': } ->
  class { '::solr5::config': } ~>
  class { '::solr5::service': } ->
  anchor { 'solr5::end': }
}
