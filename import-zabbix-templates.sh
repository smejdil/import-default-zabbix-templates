#!/bin/bash
#
# Create tasks*.yml for import Zabbix template by Ansible
#
# Lukas Maly <Iam@LukasMaly.NET> 13.4.2021
#

# Check dir xml
if [[ -d xml ]]
then
    echo "Directory xml exists on your filesystem."
    rm -rf ./xml/*.xml
else
    mkdir xml
fi

# Check dir tasks
if [[ -d tasks ]]
then
    echo "Directory tasks exists on your filesystem."
    rm -rf ./tasks/*.yml
else
    mkdir tasks
fi

# Check generated file
if [[ -f "import-templates.yml" ]]
then
    echo "File import-templates.yml exists on your filesystem."
    rm -rf import-templates.yml
fi

# Check dir tasks
if [[ -d zabbix ]]
then
    echo "Directory zabbix exists on your filesystem."
    rm -rf ./zabbix/
else
    # Extract templates
    tar xzf /tmp/zabbix-templates-${ZABBIX_VERISON}.tar.gz    
fi

# Copy all xml files to xml directory for easy processing
for f in `find zabbix/templates/ -name '*.xml' | grep -v media`; do
cp $f ./xml/
done

# Create yml task files for templates
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
if [[ -f "tasks/template_db_mongodb_cluster.xml.yml" ]]
then
    echo "File template_db_mongodb_cluster.xml.yml exists on your filesystem. Template template_db_mongodb_cluster.xml can't import :-("
    rm tasks/template_db_mongodb_cluster.xml.yml
fi

# Create new ansible playbook with included tasks
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

# Add included tasks to end of file
for y in `ls -1 ./tasks/`; do 
echo "    - include_tasks: tasks/$y" >> import-templates.yml
done

# Run ansible playbook for import all zabbix templates
ansible-playbook import-templates.yml

# EOF