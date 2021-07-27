echo "Adding Kubernetes Repo..."

echo "[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" | sudo tee -a /etc/yum.repos.d/kubernetes.repo

echo "Install Kubeadm and Docker..."

sudo yum install kubeadm docker -y 

echo "Enabling Kubelet Service..."

sudo systemctl enable kubelet

echo "Starting Kubelet Service..."

sudo systemctl start kubelet

echo "Enabling Docker Service..."

sudo systemctl enable docker

echo "Starting Kubelet Service..."

sudo systemctl start docker

echo "Disabling Swap..."

sudo swapoff -a

echo "Intitalizing Kubeadm..."

sudo kubeadm init

echo "Creating Directory for kube..."

mkdir -p $HOME/.kube

echo "Copying Kubeadm Configurations in kube directory..."

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

echo "Permissions for User for kube directory..."

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Deploying Calico for Pods Network..."

kubectl apply -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml

echo "Untainting Master Nodes to make sure pods are scheduled on master node..."

kubectl taint nodes --all node-role.kubernetes.io/master- 

kubectl get nodes

echo "Cluster is Ready with Master as Single Node..."
