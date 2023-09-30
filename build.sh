#!/bin/bash
VERSION='saas-16.3'
DEPTH=10
VALUMES='./volumes'
args=()
i=1;
for arg in "$@" 
do
    args+=($arg)
    i=$((i + 1));
done


if [[ ${args[@]} = '-init' ]]
then
    echo "initialiaze database"
    docker-compose down 
    if [ ! -d 'odoo' ]
    then
        sudo rm ./odoo -rf
    fi
    git clone -b $VERSION --depth=$DEPTH https://github.com/odoo/odoo.git odoo
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