# -*- coding: utf-8 -*-

describe package 'conky' do
  it { should be_installed }
end

describe file '/home/h4x0r/.conky.d' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/conky.d' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.conky.d/var' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.conky.d/scripts' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.conky.d/scripts/battery-notify.sh' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
