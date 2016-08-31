#Syslog

##Syslog installation
First, let 's install some dependecy
```
sudo apt-get install syslog-ng-core

```
Then,install it syslog-ng:
```python 
sudo apt-get install syslog-ng
```
##Recommended architecture
We have two types of architectures:

1. Client syslog ------> Server syslog -----> Database MongoDb

2. Client Syslog ------> Database MongoDB

The first is the one that is recommended because Mongo DB may fail from time to time resulting in data loss. 
As we rely on MongoDB, only for easier search and the actual logs are still stored on hard disk, 
`this is not an issue at all`.

##Syslog client configuration
```
@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"

# Syslog-ng configuration file, compatible with default Debian syslogd
# installation.

# First, set some global options.
options { chain_hostnames(off); flush_lines(0); use_dns(no); use_fqdn(no);
	  owner("root"); group("adm"); perm(0640); stats_freq(0);
	  bad_hostname("^gconfd$");
	  sync(0); log_fifo_size(1000); long_hostnames(off);
	  create_dirs (yes); time_reopen (10);

};
#If it is a client
source s_src {
       system();
       internal();
};

# If it is a server
#source s_net { tcp(ip(127.0.0.1) port(1000)); };

###################################
# Destinations ( Local and network)
#####################################

## 1 SEND IN THE NETWORK 
destination d_net { tcp("127.0.0.1" port(512) log_fifo_size(1000) ); };

## 2 SAVE LOCALLY 

# If is a client
destination d_local {  file("/var/log/net-daily/$YEAR/$MONTH/$DAY.log"); };
# If is a server : precise the IP 
#destination d_local {  file("/var/log/net-daily/$YEAR/$MONTH/$DAY/$HOST.log"); };


########################
# Filters
########################
# Here's come the filter options. With this rules, we can set which 
# message go where.

filter f_dbg { level(debug); };
filter f_info { level(info); };
filter f_notice { level(notice); };
filter f_warn { level(warn); };
filter f_err { level(err); };
filter f_crit { level(crit .. emerg); };

filter f_debug { level(debug) and not facility(auth, authpriv, news, mail); };
filter f_error { level(err .. emerg) ; };
filter f_messages { level(info,notice,warn) and 
                    not facility(auth,authpriv,cron,daemon,mail,news); };

filter f_auth { facility(auth, authpriv) and not filter(f_debug); };
filter f_cron { facility(cron) and not filter(f_debug); };
filter f_daemon { facility(daemon) and not filter(f_debug); };
filter f_kern { facility(kern) and not filter(f_debug); };
filter f_lpr { facility(lpr) and not filter(f_debug); };
filter f_local { facility(local0, local1, local3, local4, local5,
                        local6, local7) and not filter(f_debug); };
filter f_mail { facility(mail) and not filter(f_debug); };
filter f_news { facility(news) and not filter(f_debug); };
filter f_syslog3 { not facility(auth, authpriv, mail) and not filter(f_debug); };
filter f_user { facility(user) and not filter(f_debug); };
filter f_uucp { facility(uucp) and not filter(f_debug); };

filter f_cnews { level(notice, err, crit) and facility(news); };
filter f_cother { level(debug, info, notice, warn) or facility(daemon, mail); };

filter f_ppp { facility(local2) and not filter(f_debug); };
filter f_console { level(warn .. emerg); };

######################################################
# Save all logs locally and send them in the network
#######################################################
log { source(s_src); filter(f_auth); destination(d_local);  destination(d_net);  };
log { source(s_src); filter(f_cron); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_daemon); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_kern); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_lpr); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_syslog3); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_user); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_uucp); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_mail); destination(d_local);  destination(d_net); };
log { source(s_src); filter(f_mail); filter(f_info); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_mail); filter(f_warn); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_mail); filter(f_err); destination(d_local);  destination(d_net);};

log { source(s_src); filter(f_news); filter(f_crit); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_news); filter(f_err); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_news); filter(f_notice); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_cnews); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_cother); destination(d_local);  destination(d_net);};

log { source(s_src); filter(f_ppp); destination(d_local);  destination(d_net);};

log { source(s_src); filter(f_debug); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_error); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_messages); destination(d_local);  destination(d_net);};

log { source(s_src); filter(f_console); destination(d_local);  destination(d_net);};
log { source(s_src); filter(f_crit); destination(d_local);  destination(d_net);};


###
# Include all config files in /etc/syslog-ng/conf.d/
###
@include "/etc/syslog-ng/conf.d/*.conf"

```
##Syslog server configuration (Central loghost)
