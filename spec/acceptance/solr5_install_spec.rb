require 'spec_helper_acceptance'

describe 'solr5 class' do

    describe 'running puppet code' do

        it 'should work with no errors' do
        pp = <<-EOS
            class { 'java': } ->
            class { 'solr5': }
        EOS
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
        end
    end
end
