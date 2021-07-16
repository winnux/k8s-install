#!/bin/bash
echo "system upgrading..."
dnf -y upgrade
echo "Disable SELinux enforcement"
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
echo "Enable transparent masquerading "
cat <<EOF > /etc/modules-load.d/k8s.conf
br_netfilter
EOF
echo "disabled firewall"

systemctl stop firewalld && systemctl disable firewalld​
echo "Set bridged packets to traverse iptables rules"
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
echo "Disable all memory swaps"
swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "add /etc/hosts"
sed -i '$a\172.17.96.1 k8s-master'  /etc/hosts
sed -i '$a\172.17.96.2 k8s-node1' /etc/hosts
sed -i '$a\172.17.96.3 k8s-node2' /etc/hosts

echo "iptables setting"
iptables -P FORWARD ACCEPT


echo "install docker"

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y

echo "start docker"
systemctl start docker
systemctl enable docker

echo "aliyun docker mirror"
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://1sy0wkzx.mirror.aliyuncs.com"]
}
EOF
