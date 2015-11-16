 #!/usr/bin/env bash

if [ -e "/etc/vagrant-provisioned" ];
then
    if [ "/vagrant/provision.sh" -ot "/etc/vagrant-provisioned" ];
    then
        echo "Vagrant provisioning already completed. Skipping..."
        exit 0
    else
        echo "Starting Vagrant provisioning process..."
    fi

else
    echo "Starting Vagrant provisioning process..."
fi

# Install core components
/vagrant/sh/core.sh

# Install python
/vagrant/sh/python.sh

# Install postgresql
/vagrant/sh/postgresql.sh

{% if cookiecutter.use_redis == "y" %}
# Install redis
/vagrant/sh/redis.sh
{% endif %}

{% if cookiecutter.use_postgis == "y" %}
# Install postgis
/vagrant/sh/postgis.sh
{% endif %}

# Install bower
/vagrant/sh/bower.sh


touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running"
