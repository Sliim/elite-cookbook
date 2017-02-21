# -*- coding: utf-8 -*-

describe file '/etc/locale.gen' do
  its('content') { should match(/^fr_FR.UTF-8 UTF-8$/) }
end
