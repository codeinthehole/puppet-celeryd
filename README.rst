=========================
Puppet module for Celeryd
=========================

Simple puppet module for Celery.   

This module will:

* Create folders for PID files and logs
* Create a ``celery`` user
* Create an init script in ``/etc/init.d``
* Ensure the Celery daemon is running

It's pretty basic at the moment.

Usage
-----

You need to pass the path to your Celery config file::

    include celeryd
    celeryd::service { "celeryd":
        conf_path => "/path/to/conf/file",
    }

You can also pass an ``environment`` variable which is used to name the init
script in ``/etc/init.d``.  This allows multiple Celery daemons to be run on the
same server (useful for small projects where a test and stage build may sit on
the same machine).  Usage::

    include celeryd
    celeryd::service { "celeryd-test":
        conf_path => "/var/www/project/config/celeryd/stage"
        environment => "test"
    }
    celeryd::service { "celeryd-stage":
        conf_path => "/var/www/project/config/celeryd/test"
        environment => "stage"
    }
