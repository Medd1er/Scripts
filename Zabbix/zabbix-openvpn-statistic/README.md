# zabbix-openvpn-statistic
A shell script to grab statistic of OpenVPN connections
# How to Use:
   `git clone https://github.com/PressXtoWin/zabbix-openvpn-statistic`
   >0. Place script wherever in accessible directory
      for Zabbix user(i.e. in root directory '/scripts')
      on the remote OpenVPN server with working zabbix agent
   >1. Configure paths for variables
      (by default script ueses default directory for openvpn logs)
   >2. Grant access for Zabbix user to openvpn logfile
   >3. Grant access for Zabbix user to script directory
      and script itself (without quotes)
      'chown root:zabbix /scripts/openvpn-statistic.sh'
      'chmod 550 -R /scripts'
   >4. On Zabbix server via web console add 2 new items with keys below
      for your OpenVPN Template if it exists otherwise create a new template.
      *I. openvpn[numofcon]* - this key is for number of connections
      *II. openvpn[logs]* - for logs output. Use type of information: Log
   >5. Add UserParameter in zabbix_agent.conf (without quotes)
     'UserParameter=openvpn[*],/scripts/openvpn_statistic.sh $1'
      (you can place it as well after "UnsafeUserParameters")
   >6. Restart the Zabbix agent 'systemctl restart zabbix-agent'
      (according to your installation)
   >7. Create graph for number of connections
   >8. Go to 'Screens' and create a new one for VPN connections with 2 colums and 1 row
   >9. Add Resource: Plain text, item: Your Template logging statistic and       
      set it as 'Dynamic item' and set to display 1 item
   >10. Add graph of vpn connections and set it as 'Dynamic item'
   >11. Enjoy!
                                                                                
**AUTHOR='Nikita Anisimov'                                                     
VERSION="1.0"**                          
