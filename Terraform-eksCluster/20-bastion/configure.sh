#!/bin/bash

# Expanding the /var partition
growpart /dev/nvme0n1 4

# Extending the logical volume
lvextend -L +30G /dev/mapper/RootVG-homeVol

# Resizing the filesystem
xfs_growfs /home


sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc

sudo dnf -y install dnf-plugins-core 
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable docker  
sudo usermod -aG docker ec2-user  
sudo systemctl start docker          

#kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH 

#eksctl
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

#helm
 curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
 chmod 700 get_helm.sh
 ./get_helm.sh

#awscli
sudo yum install awscli -y

cd /home/ec2-user

mkdir Roboshop

# Installing Git
sudo yum install git -y

cd Roboshop

# Cloning the Roboshop-dev-kubernetes repository
if [ ! -d Kubernetes ]; then
  git clone https://github.com/kar5113/Kubernetes.git
fi  





# # Cloning the Ansible_Roboshop repository
# if [ ! -d Ansible_Roboshop ]; then
#     git clone https://github.com/kar5113/Roboshop-Ansible.git
# fi




