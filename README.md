## Import default Zabbix templates

Easy shell script for make ansible tasks.yml and import Zabbix template
using Ansible

* Tested on CentOS Stream with Zabbix 5.0 LTS
* Tested on Ubuntu 20.04.3 LTS with Zabbix 6.0.0beta3

### Packages CentOS

- Package - python3-pip		9.0.3-19.el8
- Package - ansible		2.9.18-2.el8	

### Packages Ubuntu Server

- Package - python3-pip		20.0.2-5ubuntu1.6
- Package - ansible		2.9.6+dfsg-1

### How it works

Ansible use collections https://galaxy.ansible.com/community/zabbix and by
Zabbix API import default template to Zabbix monitoring system.

- Python package - zabbix-api 0.5.4

### Install CentOS
```console
dnf install ansible

pip3 install zabbix-api
```

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
export ZABBIX_VERISON="6.0.0beta3"

cd /tmp
git clone --branch ${ZABBIX_VERISON} https://git.zabbix.com/scm/zbx/zabbix.git --depth 1
cd zabbix
git fetch --unshallow
cd ../

tar cvzf zabbix-templates-${ZABBIX_VERISON}.tar.gz zabbix/templates/
mv zabbix-templates-${ZABBIX_VERISON}.tar.gz ~/import-default-zabbix-templates

cd ~/import-default-zabbix-templates

./import-zabbix-templates.sh
```

### To do

- Import Media
- Test on other Linux distribution
