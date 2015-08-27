#!/bin/bash
source $HOME/levenv/bin/activate
export DJANGO_SETTINGS_MODULE=linkedevents.settings
DM="python manage.py"

cd $HOME/linkedevents/

$DM collectstatic --noinput
$DM syncdb --noinput
$DM migrate
$DM compilemessages
