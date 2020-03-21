#!/usr/bin/python3 -Iu
# -*- coding: utf-8 -*-
#
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
import time

iface = 'lo' # Monitored interface

# Bytes received
rx1 = int(open(f'/sys/class/net/{iface}/statistics/rx_bytes').read())
tx1 = int(open(f'/sys/class/net/{iface}/statistics/tx_bytes').read())

time.sleep(950000/1000000.0)

# Bytes sent
rx2 = int(open(f'/sys/class/net/{iface}/statistics/rx_bytes').read())
tx2 = int(open(f'/sys/class/net/{iface}/statistics/tx_bytes').read())

ms = int(round(time.time() * 1000))

print('Content-Type: application/json\n\n{{"download": [{}, {}], "upload": [{}, {}]}}'.format(ms, rx2 - rx1, ms, tx2 - tx1))
