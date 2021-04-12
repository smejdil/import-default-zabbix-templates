## Import default Zabbix templates

Easy shell script for make ansible tasks.yml and import Zabbix template
using Ansible

* Tested on CentOS Stream with Zabbix 5.0 LTS

### Packages CentOS

- Package - python3-pip		9.0.3-19.el8
- Package - ansible		2.9.18-2.el8	

### How it works

Ansible use collections https://galaxy.ansible.com/community/zabbix and by
Zabbix API import default template to Zabbix monitoring system.

- Python package - zabbix-api 0.5.4

### Install CentOS
```console
dnf install ansible

pip3 install zabbix-api
```

### Install ansible collection zabbix

```console
ansible-galaxy collection install -r requirements.yml
Process install dependency map
Starting collection install process
Installing 'community.zabbix:1.3.0' to '/root/.ansible/collections/ansible_collections/community/zabbix'
```

### Make and run playbook
```console
export ZABBIX_USER=zabbix_admin_user
export ZABBIX_PASSWORD=*******************
export ZABBIX_VERISON="5.0.10"

cd /tmp
git clone --branch ${ZABBIX_VERISON} https://git.zabbix.com/scm/zbx/zabbix.git
tar cvzf zabbix-templates-${ZABBIX_VERISON}.tar.gz zabbix/templates/

cd ~/import-default-zabbix-templates

./import-zabbix-templates.sh
```

### To do

- Import Media
- Test on other Linux distribution
- Test Zabbix 5.2