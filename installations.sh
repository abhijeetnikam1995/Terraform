#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt-get install zip -y
unzip awscliv2.zip
sudo ./aws/install
snap install terraform --classic
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
aws configure set aws_access_key_id "AKIAQMI4XMFF665LTVXR" --profile user2 && aws configure set aws_secret_access_key "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" --profile user2 && aws configure set region "us-east-1" --profile user2 && aws configure set output "text" --profile user2
