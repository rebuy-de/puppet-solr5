require 'spec_helper'

describe 'solr5::config', :type => 'class' do

  # You need this, because otherwise puppetlabs-concat fails
  let :facts do
    {
       :concat_basedir => '/anywhere/you/can/concat/files'
    }
  end
  let :params do
    {
       :solr_data_dir => '/my/stuff',
       :package_target_dir => '/my_tmp',
       :solr_archive_file_name => 'solr-5.2.2-el6.tar.gz',
       :init_config => [],
       :solr_user => 'my_solr_user',
       :solr_port => '1234',
       :gc_log_file_count => 5,
       :gc_log_file_size => '25M'
     }
  end

  it{
#      should contain_class('solr5::config')
      should contain_concat__fragment('solr_config_base').with(
        {
          'target' => '/my/stuff/solr.in.sh',
          'source' => '/my_tmp/solr.in.sh',
          'order' => '01',

        }).that_requires('Solr5::Extract_file[solr.in.sh]')
      should contain_concat('/my/stuff/solr.in.sh').with(
        {
          'ensure' => 'present',
          'owner' => 'my_solr_user',
          'group' => 'my_solr_user'
        })
  }
end
