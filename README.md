## Import default Zabbix templates

Easy shell script for make ansible tasks.yml and import Zabbix template
using Ansible

* Tested on Ubuntu 20.04.3 with Zabbix 5.0 LTS

### Packages Ubuntu Server

- Package - python3-pip		20.0.2-5ubuntu1.6
- Package - ansible		2.9.6+dfsg-1

### How it works

Ansible use collections https://galaxy.ansible.com/community/zabbix and by
Zabbix API import default template to Zabbix monitoring system.

- Python package - zabbix-api 0.5.4

### Install Ubuntu server
```console
apt install ansible

pip3 install zabbix-api
```

### Install ansible collection zabbix

```console
ansible-galaxy collection install -r requirements.yml
Process install dependency map
Starting collection install process
Installing 'community.zabbix:1.5.1' to '/root/.ansible/collections/ansible_collections/community/zabbix'
```

### Make and run playbook
```console
export ZABBIX_USER=zabbix_admin_user
export ZABBIX_PASSWORD=*******************
export ZABBIX_VERISON="5.0.20"

cd /tmp
git clone --branch ${ZABBIX_VERISON} https://git.zabbix.com/scm/zbx/zabbix.git --depth 1
cd zabbix
git fetch --unshallow
cd ../

tar cvzf zabbix-templates-${ZABBIX_VERISON}.tar.gz zabbix/templates/

cd ~/import-default-zabbix-templates

./import-zabbix-templates.sh
```

### Problems
- The error was: zabbix_api.ZabbixAPIException: urllib2.URLError - Internal Server Error - PHP memory_limit
- The error was: zabbix_api.APITimeout: HTTP read timeout - max_execution_time

### To do

- Import Media
- Test on other Linux distribution
- Test Zabbix 6.0.0beta3 - Import Zabbix 5.4 - 6.0 Template format YAML #618
- https://github.com/ansible-collections/community.zabbix/issues/618
