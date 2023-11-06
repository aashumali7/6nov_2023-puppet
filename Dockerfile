FROM ubuntu:latest

# Update package lists and install required dependencies
RUN apt-get update && apt-get install -y wget

# Download Puppet agent .deb package
RUN wget https://apt.puppet.com/puppet7-release-jammy.deb && \
    dpkg -i puppet7-release-jammy.deb && \
    apt-get update

# Install Puppet agent
RUN apt-get install -y puppet-agent

# Set environment variables for Puppet
ENV PATH="/opt/puppetlabs/bin:$PATH"

# Your additional Dockerfile configurations...

# Start your application or perform additional configurations
# Set the Puppet agent command with the hosts file modification as the entry point
CMD sh -c "echo '172.20.0.2 puppet' | tee -a /etc/hosts > /dev/null && /opt/puppetlabs/bin/puppet agent --no-daemonize --verbose"