require 'spec_helper'

describe 'solr5::install', :type => 'class' do

  let :params do
    {
       :package_url => 'http://anywhere.in/the/net',
       :package_target_dir => '/put/package/here',
       :package_version => '5.2.2',
       :solr_archive_file_name => 'solr-5.2.2-el6.tar.gz',
       :solr_user => 'my_solr_user',
       :solr_data_dir => '/my/stuff',
       :solr_install_dir => '/install/solr/here',
       :solr_port => '1234',
       :solr_name => 'nice_name_for_solr'
     }
  end

  it{
      should contain_class('solr5::install')
      should contain_archive('/put/package/here/solr-5.2.2-el6.tar.gz').with(
        {
          'source' => 'http://anywhere.in/the/net'
        })
      should contain_solr5__extract_file('install_solr_service.sh').with(
        {
          'path_to_archive' => '/put/package/here',
          'archive_filename' => 'solr-5.2.2-el6.tar.gz',
          'file_to_extract' => 'install_solr_service.sh'
        })
      should contain_file('/put/package/here/install_solr_service.sh').with(
        {
          'ensure' => 'file',
          'mode' => '0700'
        })
      should contain_exec('install-solr').with(
        {
          'command' =>"/put/package/here/install_solr_service.sh /put/package/here/solr-5.2.2-el6.tar.gz \
    -u my_solr_user \
    -d /my/stuff \
    -i /install/solr/here \
    -p 1234 \
    -s nice_name_for_solr \
    -f",
    'creates' => '/install/solr/here/solr-5.2.2'
        }
      )
  }
end
