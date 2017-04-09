#! /bin/bash

db_name='some_db_name'
db_host='0.0.0.0'
db_port='5432'
db_user='some_db_user'
db_password='**some_pass**'
db_save_path="/path/for/any/backup/"
db_save_name="any_backup.backup"

sudo -u postgres bash << EOF

if [ -f /var/lib/postgresql/.pgpass ];
then
        echo 'the file pgpass already exists'
else
        echo $db_host:$db_port:$db_name:$db_user:$db_password > /var/lib/postgresql/.pgpass
        chmod 0600 /var/lib/postgresql/.pgpass
fi

pg_restore -i -h $db_host -p 5432 -U $db_user -d $db_name -v $db_save_path$db_save_name

EOF
# CHANGE "defaul_user" FOR YOUR SYSTEM USER
sudo -u default_user bash << EOF
EOF
