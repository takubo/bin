#!/bin/sh
# vim:set sw=2 :

bases="b o d h x"

for i in ${bases} ; do
  for j in ${bases} ; do
    if [ ${i} != ${j} ] ; then
      #rm ${HOME}/bin/${i}2${j}
      ln -s ${HOME}/bin/base_change.sh ${HOME}/bin/${i}2${j}
    fi
  done
done
rm ${HOME}/bin/h2x ${HOME}/bin/x2h
