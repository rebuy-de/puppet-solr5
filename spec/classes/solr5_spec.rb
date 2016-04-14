require 'spec_helper'

describe 'solr5', :type => 'class' do

  # You need this, because otherwise puppetlabs-concat fails
  let :facts do
    {
       :concat_basedir => '/your/temporary/concatenation/folder',
       :service_provider => 'systemd'
     }
  end

  it{
      should compile.with_all_deps
      should contain_class('solr5')
      should contain_class('solr5::install')
      should contain_class('solr5::config')
      should contain_class('solr5::service')
  }
end
