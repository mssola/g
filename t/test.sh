#!/bin/bash

set -e

source g.sh
cd /

# Setup the test file system.
mkdir -p a/b/c
mkdir -p a/d

g -v                                >> /output.txt 2>&1
g --version                         >> /output.txt 2>&1
g -h                                >> /output.txt 2>&1
g --help                            >> /output.txt 2>&1

# Let's add some shortcuts.
g add root
g add b a/b
g add c a/b/c

# Errors on the `add` command.
set +e
g add add                           >> /output.txt 2>&1
g add lala lala lala                >> /output.txt 2>&1
set -e

# Removing shortcuts.
g rm c
g rm d

# Errors on the `rm` command.
set +e
g rm                                >> /output.txt 2>&1
g rm lala lala                      >> /output.txt 2>&1
set -e

# The list command.
g list --keys | xargs -n1 | sort | xargs   >> /output.txt 2>&1
g list | awk '{ print $1 }' | sort | xargs >> /output.txt 2>&1

# Bare g command.
cd /
g b
basename $(pwd)                     >> /output.txt 2>&1
g root
basename $(pwd)                     >> /output.txt 2>&1
g root/a/b/c
basename $(pwd)                     >> /output.txt 2>&1

# Unknown shortcut.
set +e
g unknown                           >> /output.txt 2>&1
set -e

# Final diff
diff /expected.txt /output.txt
