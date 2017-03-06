# zabbix-mysql-statistic
A shell script to grab statistic of Remote MySQL server statistic
# How to Use:

   0. Place script wherever in accessible directory
      for Zabbix user(i.e. **'/etc/zabbix/scripts'**)
      on the local Zabbix server with working zabbix agent
   1. **NOTE ->** Ensure that interface for monitored host set to zabbix agent on
   the **localhost(127.0.0.1:10050)**. Port could be different depending on your
   configuration.
   2. Grant access for Zabbix user to script directory
      and script itself
      
      > chown root:zabbix /etc/zabbix/scripts/remote_mysql_statistic.sh
      
      > chmod 550 -R /etc/zqbbix/scripts
   
   3. Uncomment and set UnsafeUserParameters=1 to allow special symbols in passwords
   4. Add UserParameter in zabbix_agent.conf (you can place it as well after "UnsafeUserParameters")
   
      > UserParameter=mysql-stats[*],/etc/zabbix/scripts/remote_mysql_statistic.sh "none" "$1" "$2" "$3" "$4"
      
   5. Restart the Zabbix agent (according to your installation)
  
      > systemctl restart zabbix-agent
   6. Import **template-remote-mysql.xml**
   7. Import **screen-remote-mysql.xml**
   8. Enjoy!
