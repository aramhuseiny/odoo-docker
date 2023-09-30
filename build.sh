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
    sudo rm odoo -rf
    git clone -b $VERSION --depth=$DEPTH https://github.com/odoo/odoo.git odoo
    sudo rm $VALUMES'/postgresql' -rf
fi

if [[ ${args[@]} = '-build' ]]
then
    docker-compose up -d --build

else
    docker-compose up -d
fi