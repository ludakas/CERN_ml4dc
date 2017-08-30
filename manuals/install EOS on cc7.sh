# adapted from
#   https://eos.readthedocs.io/en/latest/quickstart/setup_repo.html
#   https://eos.readthedocs.io/en/latest/quickstart/install.html
#   https://twiki.cern.ch/twiki/bin/view/EOS/EosClientInstall
#   https://cern.service-now.com/service-portal/article.do?n=KB0003846
#
# info about pamd from Giovanni

sudo rpm -i https://dss-ci-repo.web.cern.ch/dss-ci-repo/eos/citrine/tag/el-7/x86_64/eos-repo-el7-generic-1.noarch.rpm
sudo yum -y install eos-client eos-fuse

# configure eosd
sudo tee /etc/sysconfig/eos > /dev/null /etc/sysconfig/eos<< @EOF
# EOS FUSE mount config
# see http://eos.readthedocs.io/en/latest/configuration/fuse.html#eosd-shared-mount
export EOS_FUSE_MOUNTS='cms user'
export EOS_FUSE_BIGWRITES=1
export EOS_FUSE_CACHE_PAGE_SIZE=32768
export EOS_FUSE_CACHE_SIZE=268435456
export EOS_FUSE_DEBUG=0
export EOS_FUSE_LOGLEVEL=4
export EOS_FUSE_NEG_ENTRY_CACHE_TIME=1.0e-09
export EOS_FUSE_NOPIO=1
export EOS_FUSE_PIDMAP=1
export EOS_FUSE_RDAHEAD=1
export EOS_FUSE_RDAHEAD_WINDOW=1048576
export EOS_FUSE_RMLVL_PROTECT=2
export EOS_FUSE_SHOW_EOS_ATTRIBUTES=1
export EOS_FUSE_SHOW_SPECIAL_FILES=0
export EOS_FUSE_USER_KRB5CC=1
export EOS_LOG_SYSLOG=0
export XRD_APPNAME=eos-fuse
export XRD_CONNECTIONRETRY=4096
export XRD_CONNECTIONWINDOW=10
export XRD_DATASERVERTTL=300
export XRD_LOADBALANCERTTL=1800
export XRD_LOGLEVEL=Info
export XRD_REDIRECTLIMIT=5
export XRD_REQUESTTIMEOUT=60
export XRD_STREAMERRORWINDOW=60
export XRD_STREAMTIMEOUT=60
export XRD_TIMEOUTRESOLUTION=1
export XRD_WORKERTHREADS=16

test -e /usr/lib64/libjemalloc.so.1 && export LD_PRELOAD=/usr/lib64/libjemalloc.so.1
@EOF

sudo tee /etc/sysconfig/eos.cms > /dev/null << @EOF
# see /etc/sysconfig/eos
# mount eoscms.cern.ch on /eos/cms/
export EOS_FUSE_MGM_ALIAS=eoscms.cern.ch
export EOS_FUSE_MOUNTDIR=/eos/cms/
@EOF

sudo tee /etc/sysconfig/eos.user > /dev/null << @EOF
# see /etc/sysconfig/eos
# mount eosuser.cern.ch on /eos/user/
export EOS_FUSE_MGM_ALIAS=eosuser.cern.ch
export EOS_FUSE_MOUNTDIR=/eos/user/
@EOF

# configure autofs for EOS
sudo mkdir /eos
sudo chmod 755 /eos
sudo sed -i -e's/^browse_mode *=.*/browse_mode = yes/' /etc/autofs.conf

sudo tee -a /etc/auto.master > /dev/null << @EOF
/eos /etc/auto.eos
@EOF

# configure mountpoints for /eos/cms and /eos/user
sudo tee /etc/auto.eos > /dev/null << @EOF
cms -fstype=eos  :cms
user -fstype=eos  :user
@EOF


# configure EOS for user permissions in SSH sessions
# this should add the line 
#
#   session    optional     pam_exec.so  debug seteuid /usr/bin/eosfusebind --pam
#
# after all the "session required" lines
LINE=`grep -n 'session\s\+required' /etc/pam.d/sshd | tail -n1 | cut -d: -f1`
sudo sed -e"${LINE}a\session    optional     pam_exec.so  debug seteuid /usr/bin/eosfusebind --pam" -i /etc/pam.d/sshd


# (re)start autofs and eosd
sudo systemctl restart autofs
sudo systemctl start eosd

# added by Lukas
# if accessing user and cms directories return permission denied a possible solution is to renew kerberos ticket:
# kinit
