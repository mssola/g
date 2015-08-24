# Copyright (C) 2013-2015 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

# From g.sh
__g_realpath() {
    [ -d "$1" ] && echo "$(cd "$1" && pwd)" || echo "$(cd "$(dirname "$1")"
        && pwd)/$(basename "$1")"
}

# Cleanup previous tests and setup some special variables.
d="$(__g_realpath $(dirname $0))"
rm -f $d/output.txt
HOME="$d"

# Setup the test file system.
mkdir -p $d/a/b/c
mkdir -p $d/a/d

source $d/../g.sh

# First check that the basic commands are there.
g -v                                &>> $d/output.txt
g --version                         &>> $d/output.txt
g -h                                &>> $d/output.txt
g --help                            &>> $d/output.txt

# Let's add some shortcuts.
cd $d
g add root
g add b a/b
g add c a/b/c

# Errors on the `add` command.
set +e
g add add                           &>> $d/output.txt
g add lala lala lala                &>> $d/output.txt
set -e

# Removing shortcuts.
g rm c
g rm d

# Errors on the `rm` command.
set +e
g rm                                &>> $d/output.txt
g rm lala lala                      &>> $d/output.txt
set -e

# The list command.
g list --keys                       &>> $d/output.txt
g list | awk '{ print $1 }' | xargs &>> $d/output.txt

# Bare g command.
original=`pwd`
cd /
g b
basename $(pwd)                     &>> $d/output.txt
g root
basename $(pwd)                     &>> $d/output.txt
g root/a/b/c
basename $(pwd)                     &>> $d/output.txt
cd $original

# Unknown shortcut.
set +e
g unknown                           &>> $d/output.txt
set -e

# Teardown
diff $d/output.txt $d/expected.txt
rm $d/output.txt
rm -rf a
rm -rf $d/.gfile
