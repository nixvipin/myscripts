#!/bin/bash

read -p "remove package(yes/no?) " ans

if [ $ans = yes ];
then
# kubectl delete node --all
 docker stop $(docker ps -q)
 docker rm $(docker ps -a -q) -f
 docker rmi $(docker images -q) -f
 for service in kube-apiserver kube-controller-manager kubectl kubelet kube-proxy kube-scheduler; do
      systemctl stop $service
  done
 kubeadm reset -f
 yum remove kubeadm kubectl kubelet kubernetes-cni kube* -y
 yum autoremove -y
 rm -rf ~/.kube
 rm -rf /etc/kubernetes/
 rm -f /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
 systemctl daemon-reload
fi

echo -e "\n"
read -p "install package(yes/no?) " ans1

if [ $ans1 = yes ]
then
read -p "setup master or worker node (master/worker) ? " env

if [ $env = master ]
then
yum update -y
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
echo """
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
""" > /etc/yum.repos.d/kubernetes.repo
yum install kubeadm kubectl kubelet kubernetes-cni kube* -y
systemctl enable kubelet
systemctl start kubelet

echo "Environment="cgroup-driver=systemd/cgroup-driver=cgroupfs"" >> /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet
kubeadm init --apiserver-advertise-address=0.0.0.0 --pod-network-cidr=$1  --v=2
echo -e "\n\nCopy the 'kubeadm join ... ... ...' command to your text editor. The command will be used to register new nodes to the kubernetes cluster.
\n\n"
mkdir -p $HOME/.kube
cp -a /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get nodes
kubectl get pods
fi

if [ $env = worker ]
then
yum update -y
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
echo """
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
""" > /etc/yum.repos.d/kubernetes.repo
yum install kubeadm kubectl kubelet kubernetes-cni kube* -y
systemctl enable kubelet
systemctl start kubelet

echo "Environment="cgroup-driver=systemd/cgroup-driver=cgroupfs"" >> /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet
echo -e "\nExecute join 'kubeadm join ... ... ...' command manually which is copied from master\n"
fi

fi
