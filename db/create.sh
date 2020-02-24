#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE isitoutyet_test;"
    psql -U postgres -c "CREATE USER isitoutyet PASSWORD 'isitoutyet' SUPERUSER;"
else
    sudo -u postgres dropdb --if-exists isitoutyet
    sudo -u postgres dropdb --if-exists isitoutyet_test
    sudo -u postgres dropuser --if-exists isitoutyet
    sudo -u postgres psql -c "CREATE USER isitoutyet PASSWORD 'isitoutyet' SUPERUSER;"
    sudo -u postgres createdb -O isitoutyet isitoutyet
    sudo -u postgres psql -d isitoutyet -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O isitoutyet isitoutyet_test
    sudo -u postgres psql -d isitoutyet_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    LINE="localhost:5432:*:isitoutyet:isitoutyet"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi
