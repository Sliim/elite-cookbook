# -*- coding: utf-8 -*-

describe file('/home/h4x0r/pics') do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/pics' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file('/root/pics') do
  it { should_not be_directory }
end

describe file('/home/h4x0r/pics/scrot') do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file('/home/h4x0r/pics/thc.jpg') do
  it { should be_file }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file('/home/h4x0r/pics/defcon-green.jpg') do
  it { should be_file }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
