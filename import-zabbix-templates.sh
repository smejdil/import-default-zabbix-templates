#!/bin/sh

mkdir xml
mkdir tasks

rm -rf ./xml/*.xml
rm -rf ./tasks/*.yml
rm -rf import-templates.yml

tar xzf /tmp/zabbix-templates-${ZABBIX_VERISON}.tar.gz

for f in `find zabbix/templates/ -name '*.xml' | grep -v media`; do
cp $f ./xml/
done

for t in `ls -1 ./xml/`; do 
echo "Create task for $t"
cat << xYMLx >> tasks/$t.yml
---
- name: Import $t
  zabbix_template:
    server_url: "{{ server_url }}"
    login_user: "{{ lookup('env','ZABBIX_USER') }}"
    login_password: "{{ lookup('env','ZABBIX_PASSWORD') }}"
    template_xml: "{{ lookup('file', 'xml/$t') }}"
    state: present
xYMLx
done

# Failed import :-(
rm tasks/template_db_mongodb_cluster.xml.yml

echo "Create anslibe playbook for import templates"
cat << xYMLx >> import-templates.yml
---
- name: Using Zabbix collection
  hosts: localhost
  collections:
    - community.zabbix

  vars_files:
    - vars/vars.yml

  tasks:
xYMLx

for y in `ls -1 ./tasks/`; do 
echo "    - include_tasks: tasks/$y" >> import-templates.yml
done

ansible-playbook import-templates.yml

# EOF