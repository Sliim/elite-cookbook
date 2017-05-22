# -*- coding: utf-8 -*-

describe group 'elite' do
  it { should exist }
end

describe user 'h4x0r' do
  it { should exist }
  its('groups') { should include 'h4x0r' }
  its('groups') { should include 'elite' }
  its('home') { should eq '/home/h4x0r' }
  its('shell') { should eq '/bin/zsh' }
end
