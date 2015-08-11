require 'spec_helper'
describe 'solr5' do

  context 'with defaults for all parameters' do
    it { should contain_class('solr5') }
  end
end
