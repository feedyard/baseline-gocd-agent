# frozen_string_literal: true
#
# inspec controls designed to run exec against docker://$ID target

title 'Container Images and Build File'

control 'cis-docker-benchmark-4.1' do
  impact 1.0
  title 'Create a user for the container'
  desc 'Create a non-root user for the container in the Dockerfile for the container image.'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      skip 'ephemeral build container - USER intentionally not defined'
      # its(%w(Config User)) { should_not eq nil }
    end
  end
end

control 'cis-docker-benchmark-4.2' do
  impact 1.0
  title 'Use trusted base images for containers'
  desc 'Ensure that the container image is written either from scratch or is based on another established and trusted base image downloaded over a secure channel.'

  describe 'trusted base image test' do
    skip 'configuration controls validate base os family as alpine'
  end
end

control 'cis-docker-benchmark-4.3' do
  impact 1.0
  title 'Do not install unnecessary packages in the container'
  desc 'Containers tend to be minimal and slim down versions of the Operating System. Do not install anything that does not justify the purpose of container.'

  ref url: 'https://alpinelinux.org'
  describe 'minimal base image test' do
    skip 'configuration controls validate base os family as alpine to prevent unintended package presence'
  end
end

control 'cis-docker-benchmark-4.4' do
  impact 1.0
  title 'Rebuild the images to include security patches'
  desc 'Instead of patching your containers and images, rebuild the images from scratch and instantiate new containers from it.'

  ref url: 'https://alpinelinux.org'
  describe 'rebuild not patch' do
    skip 'configuration controls validate base os family as alpine'
  end
end

control 'cis-docker-benchmark-4.5' do
  impact 1.0
  title 'Enable Content trust for Docker'
  desc 'Content trust provides the ability to use digital signatures for data sent to and received from remote Docker registries. These signatures allow client-side verification of the integrity and publisher of specific image tags. This ensures provenance of container images. Content trust is disabled by default. You should enable it.'

  describe os_env('DOCKER_CONTENT_TRUST') do
    skip 'content trust is intentionally disabled'
    # its('content') { should eq '1' }
  end
end

control 'cis-docker-benchmark-4.6' do
  impact 0.0
  title 'Add HEALTHCHECK instruction to the container image'
  desc 'Adding HEALTHCHECK instruction to your container image ensures that the docker engine periodically checks the running container instances against that instruction to ensure that the instances are still working.'

  # healthcheck currently set to NONE in Dockerfile
  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(Config Healthcheck)) { should_not eq nil }
    end
  end
end

control 'cis-docker-benchmark-4.7' do
  impact 0.0
  title 'Do not use update instructions alone in the Dockerfile'
  desc 'Adding the update instructions in a single line on the Dockerfile will cache the update layer. Alternatively, you could use --no-cache flag during docker build process to avoid using cached layers.'

  # org requirement to include --no-cache option to apk add
  docker.images.ids.each do |id|
    puts id
    describe command("docker history #{id}| grep -e '/add(?! --no-cache)/g'") do
      its('stdout') { should eq '' }
    end
  end
end

control 'cis-docker-benchmark-4.8' do
  impact 0.0
  title 'Remove setuid and setgid permissions in the images'
  desc 'setuid and setgid permissions could be used for elevating privileges. Allow setuid and setgid permissions only on executables which need them. '

  ref url: 'http://man7.org/linux/man-pages/man2/setuid.2.html'
  ref url: 'http://man7.org/linux/man-pages/man2/setgid.2.html'
  describe 'setuid and setgid permissions' do
    skip 'configuration controls validate base os family as alpine'
  end
end

control 'cis-docker-benchmark-4.9' do
  impact 0.3
  title 'Use COPY instead of ADD in Dockerfile'
  desc 'COPY instruction just copies the files from the local host machine to the container file system. ADD instruction potentially could retrieve files from remote URLs and perform operations such as unpacking.'

  docker.images.ids.each do |id|
    describe command("docker history #{id}| grep '/ADD(?! file:)/g'") do
      its('stdout') { should eq '' }
    end
  end
end

control 'cis-docker-benchmark-4.10' do
  impact 0.0
  title 'Do not store secrets in Dockerfiles'
  desc 'Dockerfiles could be backtracked easily by using native Docker commands.'

  describe 'Dockerfile test' do
    skip 'Manually verify that you have not used secrets in images'
  end
end

control 'cis-docker-benchmark-4.11' do
  impact 0.0
  title 'Do not store secrets in Dockerfiles'
  desc 'Verifying authenticity of the packages is essential for building a secure container image.'

  describe 'Verify packages' do
    skip 'Use GPG keys for downloading and verifying packages or any other secure package distribution mechanism of your choice.'
  end
end