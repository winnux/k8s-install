cat <<EOF | tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": ["https://1sy0wkzx.mirror.aliyuncs.com"]
}
EOF

systemctl enable docker
systemctl daemon-reload
systemctl restart docker
