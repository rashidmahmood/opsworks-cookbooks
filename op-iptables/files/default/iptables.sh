iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -A INPUT -s 172.22.0.0/16 -j ACCEPT
iptables -A INPUT -s 10.0.0.0/16 -j ACCEPT
#Enable ICMP
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
#Accept loopback addresses
iptables -A INPUT -i lo -j ACCEPT
# Accept packets belonging to established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Set default policies for INPUT, FORWARD and OUTPUT chains
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
# Save settings
/sbin/service iptables save
# List rules
iptables -L -v