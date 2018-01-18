# -*- coding: utf-8 -*-

def bundle_exec(command)
  sh "bundle exec #{command}"
end

task :install do
  sh 'bundle install --path=vendor/bundle'
end

task :vendor do
  rm_rf 'cookbooks'
  bundle_exec 'berks vendor vendor/cookbooks'
end

namespace :test do
  desc 'Tests suites runner'

  task :checkstyle do
    Rake::Task['test:foodcritic'].invoke
    Rake::Task['test:cookstyle'].invoke
  end

  task :specs do
    Rake::Task['test:chefspec'].invoke
  end

  task :foodcritic do
    bundle_exec 'foodcritic -t ~FC023 -f any .'
  end

  task :cookstyle do
    bundle_exec :cookstyle
  end

  task :chefspec do
    bundle_exec 'rspec spec --color --format documentation'
  end

  task :kitchen do
    bundle_exec 'kitchen test'
  end
end

task default: ['test:checkstyle', 'test:specs']
