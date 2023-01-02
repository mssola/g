<p align="center">
  <a href="https://github.com/mssola/g/actions?query=workflow%3ACI" title="CI status for the main branch"><img src="https://github.com/mssola/g/workflows/CI/badge.svg" alt="Build Status for main branch" /></a>
  <a href="http://www.gnu.org/licenses/gpl-3.0.txt" rel="nofollow"><img alt="License GPL 3" src="https://img.shields.io/badge/license-GPL_3-blue.svg" style="max-width:100%;"></a>
</p>

---

This repository holds a very humble and simple script that handles shortcuts of
bash paths. For example:

``` sh
$ g awesome
# instead of ...
$ cd /home/user/directory/dir/awesome
```

Furthermore, this repo also brings a file that adds bash completion so the user
can access the desired directory as fast as possible. In order to manage
shortcuts, this script accepts three commands:

``` sh
$ g add awesome /home/user/directory/dir/awesome
$ g list
# Output:
# awesome  => /home/user/directory/dir/awesome
$ cd /home/user/directory/anotherawesome
$ g add anotherawesomedir
$ g rm awesome
$ g list
# Output:
# anotherawesome  => /home/user/directory/anotherawesome
```

I guess that the commands above are quite self-explanatory.

## Install

Just place the `g.sh` and the `gcompletion.sh` files wherever you want and then
add a `source` command for both of the files in the `.bashrc` file.

## Contributing

Read the [CONTRIBUTING.org](./CONTRIBUTING.org) file.

## [Changelog](https://pbs.twimg.com/media/DJDYCcLXcAA_eIo?format=jpg&name=small)

Read the [CHANGELOG.org](./CHANGELOG.org) file.

## License

```txt
Copyright (C) 2013-2023 Miquel Sabaté Solà <mikisabate@gmail.com>

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
```
