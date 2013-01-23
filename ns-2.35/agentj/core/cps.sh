#!/bin/bash
# takes one args:
# 1. the name (relative path) to the class path file to create
# this gets the actual script file
#SELF=$(cd $(dirname $0); pwd -P)/$(basename $0)

SELF=$(cd $(dirname $0); pwd -P)

rm -f $1

echo "#DO NOT EDIT THIS FILE - IT IS AUTOGENERATED FROM AGENTJ DEPENDENCIES USING MAVEN!" >> $1
echo "" >> $1

echo $SELF/target/classes >> $1

for i in `find lib -name '*.jar'`; do
    echo $SELF/$i >> $1
done
