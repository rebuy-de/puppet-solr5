require 'spec_helper'

describe 'solr5::extract_file', :type => 'define' do

  let(:title) {'my_file'}
  let :params do
    {
       :path_to_archive => '/my_tmp',
       :file_to_extract => 'my_file',
       :archive_filename => 'solr-5.2.2-el6.tar.gz',
     }
  end

  it{
      should contain_exec('my_file').with(
        {
          'command' => "tar --extract --file /my_tmp/solr-5.2.2-el6.tar.gz --wildcards --no-anchored 'my_file' -O > /my_tmp/my_file ",
          'cwd' => '/my_tmp',
          'path' => '/bin/',
          'creates' => '/my_tmp/my_file'
        }
      )
  }
end
