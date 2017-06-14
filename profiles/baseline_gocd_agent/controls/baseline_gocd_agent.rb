control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk info') do
    its('stdout') { should include ('git') }
    its('stdout') { should include ('openssh') }
    its('stdout') { should include ('bash') }
    its('stdout') { should include ('bash-doc') }
    its('stdout') { should include ('bash-completion') }
    its('stdout') { should include ('python3') }
    its('stdout') { should include ('ruby') }
    its('stdout') { should include ('ruby-dev') }
    its('stdout') { should include ('g++') }
    its('stdout') { should include ('libffi-dev') }
    its('stdout') { should include ('musl-dev') }
    its('stdout') { should include ('make') }
  end
end

control 'python3 version' do
  impact 1.0
  title 'confirm python3 version installed'
  desc 'confirm version reported by python3 matches the desired version'
  describe command('python3 -V') do
    its('stdout') { should include ('3.5.2') }
  end
end

control 'pip version' do
  impact 1.0
  title 'confirm pip version installed'
  desc 'confirm version reported by pip3 matches the desired version'
  describe command('pip -V') do
    its('stdout') { should include ('9.0.1') }
  end
end

control 'g++ version' do
  impact 1.0
  title 'confirm g++ version installed'
  desc 'confirm version reported by g++ matches the desired version'
  describe command('g++ --version') do
    its('stdout') { should include ('6.2.1') }
  end
end

control 'make version' do
  impact 1.0
  title 'confirm make version installed'
  desc 'confirm version reported by make matches the desired version'
  describe command('make -v') do
    its('stdout') { should include ('4.2.1') }
  end
end

control 'ruby version' do
  impact 1.0
  title 'confirm ruby version installed'
  desc 'confirm version reported by ruby matches the desired version'
  describe command('ruby -v') do
    its('stdout') { should include ('2.3.3') }
  end
end

control 'inspec version' do
  impact 1.0
  title 'confirm inspec version installed'
  desc 'confirm version reported by inspec matches the desired version'
  describe command('inspec version') do
    its('stdout') { should include ('1.27.0') }
  end
end

control 'awspec version' do
  impact 1.0
  title 'confirm awspec version installed'
  desc 'confirm version reported by awspec matches the desired version'
  describe command('awspec -v') do
    its('stdout') { should include ('0.77.1') }
  end
end

control 'terraform version' do
  impact 1.0
  title 'confirm terraform version installed'
  desc 'confirm version reported by terraform matches the desired version'
  describe command('terraform -v') do
    its('stdout') { should include ('0.9.8') }
  end
end
