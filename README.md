# Yeah! just one letter ! [![Build Status](https://travis-ci.org/mssola/g.svg)](https://travis-ci.org/mssola/g)

This repository holds a very humble and simple script that handles shortcuts
of bash paths. For example:

    $ g awesome
    (instead of ...)
    $ cd /home/user/directory/dir/awesome

Furthermore, this repo also brings a file that adds bash completion so the user
can access the desired directory as fast as possible. In order to manage
shortcuts, this script accepts three commands:

    $ g add awesome /home/user/directory/dir/awesome
    $ g rm awesome
    $ g list

I guess that the commands above are quite self-explanatory. Note though that if
the path was not given to the add command then the current working directory
will be picked instead.

## Install

Just place the `g.sh` and the `gcompletion.sh` files wherever you want and then
add a `source` command for both of the files in the `.bashrc` file.

## Legal stuff

Copyright (C) 2013-2016 Miquel Sabaté Solà

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
