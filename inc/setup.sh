#!/usr/bin/env bash
#
#
#  minerboot script - set up and run miner on boot 
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

echo $(timestamp) "Updating system, please wait..."
UPDATERES=$(apt update 2>&1)
REMOVERES=$(apt autoremove -y 2>&1)
UPGRADERES=$(apt upgrade -y 2>&1 ; apt full-upgrade -y 2>&1 ;)
REMOVERES=$(echo ${REMOVERES} ; apt autoremove -y 2>&1)

#   CHECK IF NVIDIA DRIVER WAS UPDATED AND REBOOT
echo $(timestamp) "Checking NVIDIA updates..."
NUMNVIDIACHGS=$(echo ${UPGRADERES} | grep "nvidia" | wc -l)
echo $(timestamp) "Counted ${NUMNVIDIACHGS} changes to NVIDIA packages"


echo $(timestamp) "Enabling NVIDIA Persistance Mode..."
nvidia-smi -pm 1

echo $(timestamp) "Counting GPU's..."
NUMGPUS=$(nvidia-smi -L | grep "UUID:" | wc -l)
echo $(timestamp) "Counted ${NUMGPUS} GPU's"