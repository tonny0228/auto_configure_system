#!/bin/bash 

/usr/bin/gksu "/sbin/iptables -F" 
/usr/bin/gksu "/sbin/iptables -A OUTPUT -d 127.0.0.1 -m owner --gid-owner socksgrp -j ACCEPT" 
/usr/bin/gksu "/sbin/iptables -A OUTPUT ! -d 127.0.0.1 -m owner --gid-owner socksgrp -j REJECT" 

sg socksgrp skype 
