require 'spec_helper'

describe 'solr5::service', :type => 'class' do

  context 'with manage_service => false' do
    let(:pre_condition) { '  solr5::extract_file { "install_solr_service.sh":
    name             => "install_solr_service.sh",
    path_to_archive  => $package_target_dir,
    archive_filename => $solr_archive_file_name,
    file_to_extract  => "install_solr_service.sh"
  }' }
    let(:facts) { {:service_provider => 'init.d'} }
    let :params do
      {
        :manage_service => false,
        :solr_name => 'my_fancy_solr_name'
      }
    end
    it{
      should compile.with_all_deps
      should contain_class('solr5::service')
      should_not contain_service('my_fancy_solr_name')
      is_expected.not_to contain_exec('reload service definitions to allow solr to start')
    }
  end

  context 'with manage_service => true on CentOS' do
    let(:pre_condition) { '  solr5::extract_file { "install_solr_service.sh":
    name             => "install_solr_service.sh",
    path_to_archive  => $package_target_dir,
    archive_filename => $solr_archive_file_name,
    file_to_extract  => "install_solr_service.sh"
  }' }
    let(:facts) { {:service_provider => 'systemd'} }
    let :params do
      {
        :manage_service => true,
        :solr_name => 'my_fancy_solr_name'
      }
    end
    it{
      should compile.with_all_deps
      should contain_class('solr5::service')
      should contain_exec('reload service definitions to allow solr to start')
        .with_command('/bin/systemctl daemon-reload')
        .with_refreshonly(true)

      should contain_service('my_fancy_solr_name').with(
        {
          'ensure' => 'running',
          'enable' => 'true',
          'hasstatus' => 'false',

        })
    }
  end

  context 'with manage_service => true' do
    let(:pre_condition) { '  solr5::extract_file { "install_solr_service.sh":
    name             => "install_solr_service.sh",
    path_to_archive  => $package_target_dir,
    archive_filename => $solr_archive_file_name,
    file_to_extract  => "install_solr_service.sh"
  }' }
    let(:facts) { {:service_provider => 'init.d'} }
    let :params do
      {
        :manage_service => true,
        :solr_name => 'my_fancy_solr_name'
      }
    end
    it{
      should compile.with_all_deps
      should contain_class('solr5::service')
      is_expected.not_to contain_exec('reload service definitions to allow solr to start')
      should contain_service('my_fancy_solr_name').with(
        {
          'ensure' => 'running',
          'enable' => 'true',
          'hasstatus' => 'false',

        })
    }
  end

end
