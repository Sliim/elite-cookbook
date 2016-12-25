# -*- coding: utf-8 -*-

describe group 'elite' do
  it { should exist }
end

describe user 'h4x0r' do
  it { should exist }
  its('groups') { should eq %w(h4x0r elite) }
  its('home') { should eq '/home/h4x0r' }
  its('shell') { should eq '/bin/sh' }
end
