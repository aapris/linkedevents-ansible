Ansible playbooks for install Linked events
=============================================================
This repository contains Ansible-playbooks for automatically installing
Linked events test environment into a Ubuntu 14.04 virtual machine. 

A Vagrantfile is included for testing in a local virtual machine.

Edit file `config/linkedevents.yml` and change at least the password there.

Testing with vagrant
--------------------

Set up python virtualenv and install ansible. If you use virtualenv-wrapper, 
these commands may work:

```
mkvirtualenv ansible
pip install ansible
```

Then boot up vagrant, cd to the directory where this file is located and run:

```
vagrant up
ssh-copy-id vagrant@127.0.0.1 -p 2279  # password is vagrant
ansible-playbook -vvvv -i vagrant.inventory site.yml
```

Don't panic if `vagrant up` ends with error:

```
The executable 'ansible-playbook' Vagrant is trying to run was not
found in the PATH variable. This is an error. Please verify
this software is installed and on the path.
```
Latter `ansible-playbook...` will do all things needed.
(If you fix this, please send me a patch.)

If you want to install elasticsearch aswell, run command:

```
ansible-playbook -vvvv -i vagrant.inventory elasticsearch.yml
```

Use SSH to login without `vagrant ssh` command and start
the Django development server:

```
ssh vagrant@127.0.0.1 -p 2279
sudo -s -u linkedevents
cd /home/linkedevents/linkedevents
/home/linkedevents/levenv/bin/python manage.py runserver 0.0.0.0:8000
```

At this stage the database is not initialized and you have two choices:

1) Initialize an empty database. (REST API with no data is dull.)

2) Download City of Helsinki's Linked events database dump and load
it!

First create vagrant PostgreSQL superuser:

```
sudo su - postgres
createuser -s vagrant
exit
```

Then, as vagrant user, drop current database, re-create it and load 
database dump into it.

```
dropdb linkedevents
createdb linkedevents && curl http://api.hel.fi/linkedevents/static/linkedevents.dump.gz | gunzip - | psql -q linkedevents
```

Then point your browser to URL 
http://127.0.0.1:8079/v0.1/event/

Note: if you get `ProgrammingError at /v0.1/event/` and it is related to 
helevents or something similar, nuke helevents/helusers related stuff 
from `settings.py`:

```
perl -i.bak -pe "s/(^AUTH_USER_MODEL|^ {4}'hel)/### \$1/g" /home/linkedevents/linkedevents/linkedevents/settings.py
```

