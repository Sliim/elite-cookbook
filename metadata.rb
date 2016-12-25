# -*- coding: utf-8 -*-

name 'elite'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'The Elite Cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'elite::default', ''

supports 'debian', '> 8.0'

source_url 'https://github.com/sliim-cookbooks/elite' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/elite/issues' if
    respond_to?(:issues_url)
