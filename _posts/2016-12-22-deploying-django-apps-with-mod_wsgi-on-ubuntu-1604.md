---
layout: post
title: "Deploying Django Apps with mod_wsgi on Ubuntu 16.04"
tagline: "Deploying Django Apps with mod_wsgi on Ubuntu 16.04"
description: ""
category: 
tags: [ Python, Django, Apache ]
---
{% include JB/setup %}

The purpose of this documnent is to deploy Django apps with mod_wsgi on Ubuntu 16.04.

## Install python packages


### Install basic packages

    sudo apt-get install python-pip python-dev
    sudo apt-get install build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev
    sudo apt-get install libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev
    sudo pip install scrapy

### Install Django

We need the Django package.

    sudo pip install Django

If you want to install a specific version of the package, you can specify it in the command as shown below:

    sudo pip install Django==1.10.4

### Install and Freeze Other Requirements (Optional)

The file named  requirements.txt in the source directory of your project, which contains the packages required to run the project:

    sudo pip install -r requirements.txt

If you're working on a Django application and you want to create or update the requirements file, you could just run the following:

    pip freeze > requirements.txt

pip freeze prints a list of installed Python packages in your current environment, and the > stores the output of the command pip freeze into the file requirements.txt.

##  Install mod_wsgi

The mod_wsgi module for Apache can be installed on Ubuntu 16.04 using apt-get:

    sudo apt-get install libapache2-mod-wsgi

If you're using Python 3 instead of Python 2, run the following:

    sudo apt-get install libapache2-mod-wsgi-py3

## setup Apache

### App directories

To serve the Django application through mod_wsgi, we need to write a WSGI script that serves as a connection between Apache and Django. The Django file structure by default is something like this( /var/www/python/pysite ):

    pysite/
        manage.py
        pysite/
            __init__.py
            settings.py
            urls.py
        myapp1/
            models.py
            views.py
        myapp2/
            models.py
            views.py

We need to transfer the ownership of the apache directory to Apache's default user www-data in order to allow it to access the directory:

    sudo chown -R  www-data:www-data /var/www/python/pysite/

### Configure Apache Settings

To configure Apache to use your WSGI script, you need to edit the configuration file as shown below:

    sudo vi /etc/apache2/sites-enabled/000-default.conf

Add the following lines to the file:

    <VirtualHost *:80>
        ....

        WSGIDaemonProcess scrapyweb python-path=/var/www/python/pysite:/usr/local/lib/python2.7/dist-packages
        WSGIProcessGroup scrapyweb
        WSGIScriptAlias / /var/www/python/pysite/pysite/wsgi.py
        <Directory "/var/www/python/pysite/pysite/">
            Require all granted
        </Directory>
        Alias /media/ /var/www/python/pysite/
        Alias /static/ /var/www/python/pysite/static/

        <Directory /var/www/python/pysite/static>
            Require all granted
        </Directory>

        <Directory /var/www/python/pysite/media>
            Require all granted
        </Directory>
        ....
    </VirtualHost>


If you have a custom robots.txt and favicon, you may add an alias as follows:

    Alias /robots.txt /var/www/python/pysite/robots.txt
    Alias /favicon.ico /var/www/python/pysite/favicon.ico

### Django collectstatic

To deploy a Django app static to www:

    sudo python manage.py collectstatic

Finally, restart Apache to see the changes:

    sudo service apache2 restart

Done!
