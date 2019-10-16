control 'sshd-service' do
  title 'Check SSHD Service'
  desc  'Tests for SSHD Service'
  describe package('openssh-server') do
    it { should be_installed }
  end
  describe service('sshd') do
    it { should be_running }
    it { should be_enabled }
  end
  describe port('22') do
    it { should be_listening }
  end
  describe sshd_config('/etc/ssh/sshd_config') do
    its('Protocol')         { should cmp 2 }
    its('Port')             { should cmp 22 }
    its('Ciphers')          { should cmp('aes128-ctr,aes192-ctr,aes256-ctr') }
    its('Macs')             { should cmp('hmac-sha1,umac-64@openssh.com,hmac-ripemd160') }
    its('PermitRootLogin')  { should cmp 'no' }
    its('UseDNS')           { should cmp 'no' }
  end
end
