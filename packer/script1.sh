#!/bin/bash
# Update, upgrade, and reboot the system to update the kernel before running the script
sudo apt update
sudo apt upgrade -y

# Detect the Linux distribution
OS_NAME=$(grep -w NAME /etc/*release | awk -F'"' '{print $2}')

function yum_os {
  echo "This is $OS_NAME OS"
  sleep 5
  yum update -y
}

function apt_os {
  echo "This is $OS_NAME OS"
  sleep 5
  # List of packages to install
  packages=(
    curl
    wget
    vim
    git
    make
    ansible
    python3-pip
    openssl
    rsync
    jq
    postgresql-client
    mariadb-client
    mysql-client
    unzip
    tree
    openjdk-17-jdk
    maven
    fontconfig
  )

  # Update package list
  sudo apt update -y
  sudo apt upgrade -y

  # Install packages
  for package in "${packages[@]}"; do
    echo "Installing $package. Please wait..."
    sleep 3
    sudo apt install -y "$package"
  done

  echo "Package installation completed."
}

function apt_software {
  # Clean up existing sources list for Docker to avoid duplicates
  sudo rm -f /etc/apt/sources.list.d/docker.list

  # Install AWS CLI
  if ! command -v aws &>/dev/null; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip aws
  else
    echo "AWS CLI is already installed."
  fi

  # Install Terraform
  TERRAFORM_VERSION="1.0.0"
  wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  terraform --version

  # Install Grype
  GRYPE_VERSION="0.66.0"
  wget https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz
  tar -xzf grype_${GRYPE_VERSION}_linux_amd64.tar.gz
  sudo mv grype /usr/local/bin/
  grype version

  # Install Gradle
  GRADLE_VERSION="7.2"
  wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
  unzip gradle-${GRADLE_VERSION}-bin.zip
  sudo mv gradle-${GRADLE_VERSION} /opt/
  rm -rf gradle-${GRADLE_VERSION}-bin.zip
  /opt/gradle-${GRADLE_VERSION}/bin/gradle --version

  # Install kubectl
  sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
  sudo chmod +x ./kubectl
  sudo mv kubectl /usr/local/bin/

  # Install kubectx and kubens
  sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O /usr/local/bin/kubectx
  sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O /usr/local/bin/kubens
  sudo chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens

  # Install Helm 3
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  sudo ./get_helm.sh
  rm get_helm.sh

  # Install Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version

  # Install Terragrunt
  TERRAGRUNT_VERSION="v0.38.0"
  sudo wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt
  sudo chmod +x /usr/local/bin/terragrunt
  terragrunt --version

  # Install Packer
  sudo wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip -P /tmp
  sudo unzip /tmp/packer_1.7.4_linux_amd64.zip -d /usr/local/bin
  sudo chmod +x /usr/local/bin/packer
  packer --version

  # Install Trivy
  sudo apt-get update
  sudo apt-get install wget apt-transport-https gnupg lsb-release -y
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
  echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list
  sudo apt-get update
  sudo apt-get install trivy -y

  # Install ArgoCD CLI
  wget https://github.com/argoproj/argo-cd/releases/download/v2.8.5/argocd-linux-amd64
  chmod +x argocd-linux-amd64
  sudo mv argocd-linux-amd64 /usr/local/bin/argocd
  argocd version

  # Install Docker
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker jenkins
  sudo systemctl restart jenkins
  sudo systemctl restart docker
}

function user_setup {
  # Define users
  cat <<EOF > /usr/users.txt
jenkins
ansible
Automation
EOF

  # Read users from file
  usernames=$(cat /usr/users.txt)

  # Create group if not exists
  GROUP_NAME="tools"
  if ! grep -q "^$GROUP_NAME:" /etc/group; then
    sudo groupadd "$GROUP_NAME"
    echo "Group '$GROUP_NAME' created."
  else
    echo "Group '$GROUP_NAME' already exists."
  fi

  # Add group to sudoers
  if ! sudo grep -q "^%$GROUP_NAME" /etc/sudoers; then
    echo "%$GROUP_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "Group '$GROUP_NAME' added to sudoers with NOPASSWD: ALL."
  else
    echo "Group '$GROUP_NAME' is already in sudoers."
  fi

  # Create users, set passwords, and assign to groups
  for user in $usernames; do
    sudo useradd -m -s /bin/bash "$user"
    echo -e "$user\n$user" | sudo passwd "$user"
    sudo usermod -aG "$GROUP_NAME" "$user"
    if [ "$user" == "jenkins" ]; then
      sudo usermod -aG docker "$user"  # Add jenkins to docker group
    fi
    sudo chown -R "$user:$user" /home/"$user"
  done

  # Set vim as default editor
  sudo update-alternatives --set editor /usr/bin/vim.basic
  sudo update-alternatives --set vi /usr/bin/vim.basic
}

function enable_password_authentication {
  # Check if password authentication is already enabled
  if ! grep -q "PasswordAuthentication yes" /etc/ssh/sshd_config; then
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    echo "Password authentication enabled."
  else
    echo "Password authentication is already enabled."
  fi
}

if [[ $OS_NAME == "CentOS Linux" ]] || [[ $OS_NAME == "Amazon Linux" ]]; then
  yum_os
elif [[ $OS_NAME == "Ubuntu" ]]; then
  apt_os
  apt_software
  user_setup
  enable_password_authentication
else
  echo "Unsupported OS: $OS_NAME"
  exit 1
fi
