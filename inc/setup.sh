#!/usr/bin/env bash
#
#
#  minerboot - A script to set up and run NVIDIA miner(s) on boot
#
#  Copyright (C) 2019 LeshaCat
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#


logit "Updating system, please wait..."
#UPDATERES=$(apt update 2>&1)
#REMOVERES=$(apt autoremove -y 2>&1)
#UPGRADERES=$(apt upgrade -y 2>&1 ; apt full-upgrade -y 2>&1 ;)
#REMOVERES="${REMOVERES} "$(apt autoremove -y 2>&1)

#   CHECK IF NVIDIA DRIVER WAS UPDATED AND REBOOT
logit "Checking NVIDIA updates..."
NUMNVIDIACHGS=$(echo ${UPGRADERES} | grep "nvidia" | wc -l)

if [ $NUMNVIDIACHGS -gt 0 ] ; then
    logit "Counted ${NUMNVIDIACHGS} changes to NVIDIA packages :("
    logit "FORCING REBOOT IN 5 SECONDS!"
    sleep 5
    /sbin/reboot
else
    logit "No changes to NVIDIA packages :)"
fi

logit "Enabling NVIDIA Persistance Mode..."
nvidia-smi -pm 1 2>&1 >/dev/null

logit "Counting GPU's..."
NUMGPUS=$(nvidia-smi -L | grep "UUID:" | wc -l)
logit "Counted ${NUMGPUS} GPU's"

for (( c=0; c<=($NUMGPUS-1); c++ ))
do
  logit "Getting info for GPU #${c}"  
  QRES="${QRES} "$(nvidia-smi -i ${c} -q;)
done



