#!/bin/bash
VERSION='saas-16.3'
DEPTH=10
VALUMES='./volumes'
args=()
i=1;
for arg in "$@" 
do
    echo "arg - $i: $arg";
    args+=($arg)
    i=$((i + 1));
done

echo "${args[@]}"

if [[ ${args[@]} = '-init' ]]
then
    echo "init found"
    docker-compose down -v
    if [ ! -d $service ]
        then
        sudo rm odoo -rf
    fi
    git clone -b $VERSION --depth=$DEPTH https://github.com/odoo/odoo.git odoo
    if [ ! -d $service ]
        then
        sudo rm $VALUMES'/postgresql' -rf

    fi
fi

if [[ ${args[@]} = '-build' ]]
then
    docker-compose up -d --build

else
    docker-compose up -d
fi