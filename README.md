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

Then boot up vagrant, cd to this directory and run:

```
vagrant up
ssh-copy-id vagrant@127.0.0.1 -p 2279  # password is vagrant
ansible-playbook -vvvv -i vagrant.inventory site.yml
```

If you want to install elasticsearch aswell, run command:

```
ansible-playbook -vvvv -i vagrant.inventory elasticsearch.yml
```

Use SSH to login without `vagrant ssh` command and start
the Django development server:

```
ssh vagrant@127.0.0.1 -p 2279
sudo -s -u linkedevents
/home/linkedevents/levenv/bin/python manage.py runserver 0.0.0.0:8000
```

