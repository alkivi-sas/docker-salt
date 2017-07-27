======================
SaltStack Docker Image
======================

Docker images to run SaltStack salt-master as Docker container.
container.

Build
=====

.. code-block:: bash

    docker build -t salt-master -f Dockerfile --build-args version=latest .

Run
===

First create directories on your host and set permissions:

.. code-block:: bash

    mkdir -p /srv/salt /srv/salt/pki/master/minions

Run salt-master manually:

.. code-block:: bash

    docker run -d -v /srv/salt/pki:/etc/salt/pki -v /srv/salt:/srv/salt salt-master

Or use docker-compose:

.. code-block:: bash

    docker-compose up -d

Configuration
=============

You should also get some formulas into ``/srv/salt`` directory.

If you want to make some customizations (eg. on environment locations, add new
volume as ``/etc/salt/master.d/env.conf`` or ``/etc/salt/master.d`` to replace
custom configuration completely.
