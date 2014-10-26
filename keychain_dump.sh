#!/bin/bash

WHOAMI=`whoami`

for i in `security list-keychains | grep ${WHOAMI} | sed -e 's/"//g'`
do
security unlock-keychain -p ${PASSWORD} ${i}
security dump-keychain -d ${i} >> raw_dump.txt
done
