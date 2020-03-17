#!/bin/bash

set -e

source g.sh
cd /

# Setup the test file system.
mkdir -p a/b/c
mkdir -p a/d

g -v                                &>> /output.txt
g --version                         &>> /output.txt
g -h                                &>> /output.txt
g --help                            &>> /output.txt

# Let's add some shortcuts.
g add root
g add b a/b
g add c a/b/c

# Errors on the `add` command.
set +e
g add add                           &>> /output.txt
g add lala lala lala                &>> /output.txt
set -e

# Removing shortcuts.
g rm c
g rm d

# Errors on the `rm` command.
set +e
g rm                                &>> /output.txt
g rm lala lala                      &>> /output.txt
set -e

# The list command.
g list --keys | xargs -n1 | sort | xargs   &>> /output.txt
g list | awk '{ print $1 }' | sort | xargs &>> /output.txt

# Bare g command.
cd /
g b
basename $(pwd)                     &>> /output.txt
g root
basename $(pwd)                     &>> /output.txt
g root/a/b/c
basename $(pwd)                     &>> /output.txt

# Unknown shortcut.
set +e
g unknown                           &>> /output.txt
set -e

# Final diff
diff /expected.txt /output.txt
