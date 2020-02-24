#!/bin/sh

BASE_DIR=$(dirname "$(readlink -f "$0")")
if [ "$1" != "test" ]; then
    psql -h localhost -U isitoutyet -d isitoutyet < $BASE_DIR/isitoutyet.sql
fi
psql -h localhost -U isitoutyet -d isitoutyet_test < $BASE_DIR/isitoutyet.sql
