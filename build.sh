#!/bin/bash

export $(xargs <.env)

DEPTH=10
VALUMES='./volumes'
args=()
i=1;
for arg in "$@" 
do
    args+=($arg)
    i=$((i + 1));
done

if [ ! -f wkhtmltox_0.12.5-1.bionic_amd64.deb ]
then 
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
fi



if [[ ${args[@]} = '-init' ]]
then
    echo "initialiaze database"
    docker-compose down 
    if [ ! -d 'odoo' ]
    then
        sudo rm ./odoo -rf
    fi
    git clone -b $ODOO_VERSION --depth=$DEPTH https://github.com/odoo/odoo.git odoo
    if [ ! -d $VALUMES'/postgresql' ]
        then
        sudo rm $VALUMES'/postgresql' -rf

    fi
fi

if [[ ${args[@]} = '-build' ]]
then
    echo "recreate images"
    docker-compose up -d --build

else
    docker-compose up -d
fi
