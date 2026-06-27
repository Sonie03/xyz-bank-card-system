FROM jenkins/jenkins:lts-jdk21

USER root

# Update packages
RUN apt-get update && \
    apt-get install -y \
        git \
        maven \
        curl \
        wget \
        unzip \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg && \
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
> /etc/apt/sources.list.d/docker.list && \
apt-get update && \
apt-get install -y docker-ce-cli

USER jenkins