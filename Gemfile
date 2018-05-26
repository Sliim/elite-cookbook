# -*- coding: utf-8 -*-
source 'https://rubygems.org'

gem 'chef', "~> #{ENV['CHEF_VERSION'] || 13}"
gem 'berkshelf'
gem 'rake'

group :lint do
  gem 'cookstyle'
  gem 'foodcritic'
end

group :unit do
  gem 'chefspec'
  gem 'docker-api', '= 1.34.0'
end

group :kitchen do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker', '=2.1.0'
  gem 'kitchen-inspec'
end

group :development do
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-rubocop'
  gem 'guard-rspec'
end
