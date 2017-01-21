# -*- coding: utf-8 -*-

describe file('/home/h4x0r/stuff') do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
