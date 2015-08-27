Ansible playbooks for install Linked events
=============================================================
This repository contains Ansible-playbooks for automatically installing
Linked events test environment into a Ubuntu 14.04 virtual machine. 

A Vagrantfile is included for testing in a local virtual machine.

Edit file `config/linkedevents.yml` and change at least the password there.

Testing with vagrant
--------------------

```
vagrant up
ssh-copy-id vagrant@127.0.0.1 -p 2279  # salasana vagrant
ansible-playbook -vvvv -i vagrant.inventory site.yml
```

Use SSH to login without `vagrant ssh` command:

```
ssh vagrant@127.0.0.1 -p 2279
```
