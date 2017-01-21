# -*- coding: utf-8 -*-

describe package('git') do
  it { should be_installed }
end

describe file('/home/h4x0r/.gitconfig') do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/gitconfig' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.gitconfig' do
  it { should_not be_file }
end

describe file('/home/h4x0r/.gitignore') do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/gitignore' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.gitignore' do
  it { should_not be_file }
end
