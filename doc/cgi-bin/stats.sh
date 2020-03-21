#!/bin/sh
# Copyright 2018 Sandro Marcell <smarcell@mail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.

iface='lo' # Monitored interface

# Bytes received
exec 3</sys/class/net/$iface/statistics/rx_bytes
read -r rx_1 <&3
exec 3<&-

# Bytes sent
exec 4</sys/class/net/$iface/statistics/tx_bytes
read -r tx_1 <&4
exec 4<&-

/bin/sleep 1s

exec 3</sys/class/net/$iface/statistics/rx_bytes
read -r rx_2 <&3
exec 3<&-

exec 4</sys/class/net/$iface/statistics/tx_bytes
read -r tx_2 <&4
exec 4<&-

ms=$(/bin/date '+%s%3N')

printf 'Content-Type: application/json\n\n{"download": [%i, %i], "upload": [%i, %i]}' $ms $((rx_2 - rx_1)) $ms $((tx_2 - tx_1))
