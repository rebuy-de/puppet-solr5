source 'https://rubygems.org'

ruby '1.9.3', :patchlevel => '551'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']

gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppet-lint', '>= 1.0.0'
gem 'puppetlabs_spec_helper', '0.10.3'
gem 'rspec-puppet', '~> 2.2.0'
gem 'facter', '>= 1.7.0'
gem 'beaker', '2.24.0'
gem 'puppet-syntax', :require => false
gem 'beaker-rspec', :require => false
gem 'simplecov', :require => false
gem 'pry', '0.10.2'
gem 'serverspec', :require => false
gem 'fog-google', '0.1.0'
gem 'rake','0.9.2.2'
gem 'bundler', '1.10.5'
if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
end
