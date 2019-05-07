# solr5

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with solr5](#setup)
    * [What solr5 affects](#what-solr5-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with solr5](#beginning-with-solr5)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This puppet module installs Solr version 5.x from a given URL pointing to a package.
Allowing you to add aditional configuration and setting up the service, so Solr is started in the background.
The module is currently tested on CentOS 6.6 and 6.7.

## Module Description

This module installs Solr 5.x and a current Java Version as prerequisite to run Solr.
It allows to automatically setting up a Solr installation with your provided configuration based on the configuration delivered with Solr.


## Setup

### What solr5 affects

* It downloads the archive to /tmp or a provided directory using the archive module
* It will create the installation directory under /opt
* It will create the data directory defaulting to /var/solr
* It creates a service, might be disabled, which runs Solr.

### Setup Requirements **OPTIONAL**

You need to create the user and group for the solr user in advance, also make sure that java is installed as prerequisite of this module.

### Beginning with solr5

If you can live with the defaults from [params.pp](manifests/params.pp) and already installed a recent Java version all you need is to include `class { 'solr5': }`. Feel free to alter the parameters, if it suits you better.

## Usage

Currently the only resource needed to configure the system is [init.pp](manifests/init.pp), you find a description of the parameters there.

## Reference

#### Public Classes
*[`solr5`](#solr5): Orchestrating and configuring the installation

### Private Classes
* [`solr5::config`]: extracting the base configuration and merge it with the optionally provided configuration
* [`solr5::extract_file`]: a define to extract a specific file from a .tar.gz archive
* [`solr5::install.pp`]: downloads the archive, extracts and execute the installation script      
* [`solr5::params`]: sane defaults
* [`solr5::service`]: installs the solr service

### `solr5`
#### Parameters
##### package_url
  Download url from the solr archive you'd like to install. Default: https://archive.apache.org/dist/lucene/solr//5.2.1/solr-5.2.1.tgz

##### package_version
This paramter has to match the package version you'd like to install. Default: 5.2.1

##### package_target_dir
Directory in the local filesystem where puppet stores the downloaded archive. Default /tmp

##### solr_install_dir
Directory where the solr server files are installed to. Solr will create a directory $solr_install_dir/solr-$version and a symlink $solr_install_dir/solr which points to the created directory. Default: /opt

##### solr_data_dir
Directory where the solr will stores it's index files. Default: /var/solr

##### solr_port
Solr will listen on this port for incoming connections. Default: 8983

##### solr_name
Solr will register itself as a service with this name. Default: solr

##### solr_user
Solr will be run as this user. Default: solr

##### manage_service
Should puppet manage the solr service? If set to true, puppet will make sure the service is installed and solr is running. Default: true

##### init_config
List of additional startup values passed to solr. Take a look at https://svn.apache.org/repos/asf/lucene/dev/branches/branch_5x/solr/bin/solr.in.sh to get a list of available options. Default values will be overriden by the values provided. Default: []

## Limitations

The module is tested against Pupet Version 3.8 on CentOS 6.6 and 6.7. Other configurations might work but are currently not tested.

## Development

Feel free to fork and create pull requests, your code should adhere the to the best practices described at [https://docs.puppetlabs.com/puppet/3.8/reference/modules_fundamentals.html](https://docs.puppetlabs.com/puppet/3.8/reference/modules_fundamentals.html).
Please test additional implemented functionality.

For developing you will currently need:
* Ruby version `1.9.3p551`
* Bundler in version `1.10.5`

### Prepare development environment
* Install rbenv [rbenv](https://github.com/sstephenson/rbenv)
* Install the required version of ruby using `rbenv install 1.9.3p551`.
* run `rbenv rehash`
* update gem `gem update --system`
* install bundler: `gem install bundler -v 1.10.5
* run `rbenv rehash`
* change into cloned archive
* run `bundle install`
* Install Vagrant from [https://www.vagrantup.com/](https://www.vagrantup.com/)
* Install Virtualbox [https://www.virtualbox.org/](https://www.virtualbox.org/)

### Run tests
All tests can be run using `bundle exec rake`.
