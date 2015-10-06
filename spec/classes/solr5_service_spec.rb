require 'spec_helper'

describe 'solr5::service', :type => 'class' do

  context 'with manage_service => true' do
    let :params do
      {
        :manage_service => true,
        :solr_name => 'my_fancy_solr_name'
      }
    end
    it{
      should contain_class('solr5::service')
      should contain_service('my_fancy_solr_name').with(
        {
          'ensure' => 'running',
          'enable' => 'true',
          'hasstatus' => 'false',

        })
    }
  end
  context 'with manage_service => false' do
    let :params do
      {
        :manage_service => false,
        :solr_name => 'my_fancy_solr_name'
      }
    end
    it{
      should contain_class('solr5::service')
      should_not contain_service('my_fancy_solr_name')
    }
  end
end
