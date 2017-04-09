#! /bin/bash

db_name='db_name'
db_host='0.0.0.0'
db_port='5432'
db_user='db_user'
db_password='**pass**'
db_save_path="/path/for/save/backup/"
db_save_name="backup_db_$(date '+%m_%d_%Y_%H_%M').backup"

sudo -u root bash << EOF

if [ -f ~/.pgpass ];
then
	echo 'Ya existe el archivo'
else
	echo $db_host:$db_port:$db_name:$db_user:$db_password > ~/.pgpass
        chmod 0600 ~/.pgpass
fi
EOF

sudo -u postgres bash << EOF

if [ -f /var/lib/postgresql/.pgpass ];
then
        echo 'ya existe el archivo pgpass'
else
        echo $db_host:$db_port:$db_name:$db_user:$db_password > /var/lib/postgresql/.pgpass
        chmod 0600 /var/lib/postgresql/.pgpass
fi

pg_dump -f /var/lib/postgresql/$db_save_name -Fc -E utf8 -d $db_name -p $db_port -h $db_host -U $db_user

EOF

sudo -u root bash << EOF

cp /var/lib/postgresql/$db_save_name $db_save_path$db_save_name
chmod +777 $db_save_path$db_save_name
rm /var/lib/postgresql/$db_save_name

EOF

# CHANGE "defaul_user" FOR YOUR SYSTEM USER
sudo -u default_user bash << EOF
EOF
