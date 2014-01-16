#!/bin/sh

for i in b o d h x ; do
    for j in b o d h x ; do
	if [ ${i} != ${j} ] ; then
	    ln -s ~/bin/base_change.sh ${i}2${j}
	fi
    done
done
rm h2x x2h
