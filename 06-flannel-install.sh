#!/bin/bash

#cat >> /etc/hosts << EOF
#151.101.76.133  raw.githubusercontent.com
#EOF

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
