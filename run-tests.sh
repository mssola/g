# Copyright (C) 2013-2015 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

set -e

if [ -z "$(pidof docker)" ]; then
    echo "Docker has to be running!"
    exit 1
fi
if [ ! -z "$(docker images g | grep latest)" ]; then
    id="$(docker images g | grep latest | awk '{ print $3 }')"
    docker rmi $id
fi

docker build -t g:latest .
docker run --rm -it g:latest
