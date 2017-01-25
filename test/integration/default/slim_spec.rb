# -*- coding: utf-8 -*-

describe file '/etc/slim.conf' do
  it { should be_file }
  it { should be_mode 0644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/usr/share/slim' do
  it { should be_directory }
  it { should be_mode 0755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
