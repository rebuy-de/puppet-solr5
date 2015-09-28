require 'spec_helper'

describe 'solr5', :type => 'class' do
    
    let :facts do
        {
            :concat_basedir => 'blubber',
        }
    end
    it{
        should contain_class('solr5')
    }

end
