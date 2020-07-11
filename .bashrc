# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Disable systemd auto paging
export SYSTEMD_PAGER=

# Don't store duplicate lines or lines starting with space
HISTCONTROL=ignoreboth

# We want some serious history
HISTSIZE=100000
HISTFILESIZE=200000

# git alias
alias ga="git add"
alias gap="git add --patch"
alias gc="git commit"
alias gp="git push"
alias gs="git status"
alias gl="git log"
alias gf="git fetch"
alias gd="git diff"
alias gdc="git diff --cached"
alias glo="git log --oneline"
alias gb="git branch --all"
alias stash="git stash"
alias pop="git stash pop"
alias amend="git commit --amend"
alias amendno="git commit --amend --no-edit"
alias prune="git remote prune"
alias branch="git branch"
alias new-branch="git checkout -b"
alias reset-last="echo 'git reset --hard HEAD~1'"
function gcm {
	git commit -m "$*"
}

# Python
alias py-venv="py -3 -m venv .venv"
alias py-pip-up="python -m pip install --upgrade pip"
alias py-ut="python -m unittest discover ."

# dot file handling
alias dot="/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME $@"
source /usr/share/bash-completion/completions/git
__git_complete dot _git
alias da="dot add"
alias dap="dot add --patch"
alias dc="dot commit"
alias dp="dot push"
alias ds="dot status"
function dcm  {
	dot commit -m "$*"
}

# Fix ssh auth in tmux attach
fixssh() {
    eval $(tmux show-env    \
        |sed --silent 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')
}

# Repeat ssh connection
reach() {
	while true; do
		date
		ssh $1 && echo "SSH reach done"; break
		sleep 10
	done
}

# uuid to stdout and clipboard
alias uuid="uuidgen --random | tee /dev/tty | xclip"

# string to lower
lower() {
	echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Get external IP via opendns

# Fancy hightlighted cat
# only one file cause who knows what else might happen
function hcat {
	highlight --out-format ansi "$1"
}
alias hc="hcat"

# Fancy highlighted less
# ansi escapes = colors
function hless {
	hcat "$1" | less --RAW-CONTROL-CHARS --jump-target 0 --LINE-NUMBERS
}
alias hl="hless"

# Weather me timbers


# Ansible
alias aman="ansible-doc"
alias agrep="ansible-doc --list | grep -i"
alias ag="ansible-galaxy"
# doc list without modules I rarely use
# this is very easy to read
alias alist='ansible-doc --list | grep -viE "docker|ec2|aws|xenserver|a[vc]i|azure|aix|bigi[pq]|bitbucket|c[eps]_|clc|cloud|checkpoint|ocean|fmgr|git[lab|hub]|elb_|icx|ios|iam|[e|nx|jun|cn|forti|vy]os|manageiq|mso_|na_|net[app|box|scaler]|one[view|andone]|onyx|win_|vultr|vmware|webfaction|tower|vcenter|vertica|zabbix|sf_|scaleway|sensu|udm|s3_|vexata|route53|rhsm|redhat|redfish|rds_|rabbitmq|puref|proxysql|postgres|proxmox|profitbricks|pn_|ovirt|os_|one_|nso_|meraki|sql|rhn|ipa_|influx|online_|kube|k8s|ibm|mongodb|homebrew|jenkins|ironware|ipadm|keycloak|infini|elastic|dellos|hetzner|ftd|dladm|gluster|cyberark|consul|asa_|utm|vdirect|intersight|idrac|memset|ldap|edgeswitch|cpm|atomic|zypper|pacman|skydive|java|redshift|ovh|ipmi|katelli|hpilo|icinga|heroku|flow|vca_|logicmonitor|logentries|logstash|gcpub|gcspanner|datadot|bms|bigmon|bigpanda|a10|newrelic|jabber|jira|jboss|aruba|freebsd|datadog|django|dms_|efs|emc|ruby|ig_|katello|macports|maven|nexmo|openbsd|pagerduty|puppet|podman|pubnub|pushbullet|rax|redis|rocktchat|slack|slurp|snow|solaris|sorcery|ss_|statusio|typetalk|npm|yarn|terraform|svn|subversion|amazon|rundeck|pushover|windows|openvswitch|openssl|omapi|ohai|nuage|nginx|mqtt|mattermost|matrix|lldp|linode|librato|gentoo|kinesis|irc|imc_|iap|hwc_|hpconfig|honey|hipchat|mercurial|gunicorn|grove|gconf|google|gce|gcdns|gc_|frr|dynamodb|dnsmadeeasy|dnsimple|dimensiondata|cv_server|perl|cobbler|cisco|circo|catapult|campfire|beary|bcf_|awall|airbrake|acme" | less'

# Remmina
alias rw10="pushd /tmp && nohup remmina --connect $HOME/.config/remmina/w10.remmina & popd"

# systemctl

# Mount cifs/samba, map to current user
mountcifs () {
	target="$1"
	mountpoint="$2"
	username=${3:-$(whoami)}
	sudo mount -t cifs "$target" "$mountpoint" -o username="$username" -o uid=$(id -u) -o gid=$(id -g)
}


# fancy ls
alias la="ls --almost-all --human-readable -l"

# always months
alias cal="cal --months"

# cörl the weather
function weather {
	curl wttr.in/$1
}
alias wttr="weather"

# .config/feh/themes
alias f="feh --theme f"
alias feh=f

# user systemd, mostly for redshift
alias usystemctl="systemctl --user"
alias usys="usystemctl"

# seriously fast ext ip thing I totally came up with on my own cause I'm clever like that yes oh yes
alias external-ip="dig +short myip.opendns.com @resolver1.opendns.com"
