# -*- coding: utf-8 -*-

describe package 'compton' do
  it { should be_installed }
end

describe file '/home/h4x0r/.config/compton.conf' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/usr/bin/compton' do
  it { should be_file }
  it { should be_executable }
end
