FROM jenkins/jenkins:lts

USER root

# Cập nhật và cài đặt công cụ cần thiết
RUN apt-get update && apt-get install -y \
    git \
    vim \
    maven \
    curl \
    unzip \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Cài đặt kubectl (phiên bản ổn định)
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Thiết lập quyền sử dụng docker bên trong Jenkins (kết nối docker.sock nếu cần)
RUN usermod -aG docker jenkins

USER jenkins

