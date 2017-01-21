# -*- coding: utf-8 -*-

describe file '/root/.bashrc' do
  it { should be_file }
  # FIXME: it { should be_mode 640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
