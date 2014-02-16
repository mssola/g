#
# Copyright (C) 2013-2014 Miquel Sabaté Solà <mikisabate@gmail.com>
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


# Print the usage string.
usage() {
    echo "usage: g [-h | --help] [-v | --version] <command> <args>"
}

# Print the help message.
help() {
    usage
    echo -e "\nThe g command are:"
    echo -e "   add\tAdd a new shortcut."
    echo -e "   rm\tRemove a shorcut."
    echo -e "   list\tList all the available shortcuts."
}

# Fill the hash of shortcuts with the contents of the gfile.
get_shortcuts() {
    local i=0 word=""

    gshortcuts=()
    while read line; do
        if [ ! -z "$line" ]; then
            if [ "$word" == "" ]; then
                word=$line
            else
                gshortcuts[$word]=$(eval echo $line)
                word=""
            fi
            i=$(($i+1))
        fi
    done < $gfile
}

# Save the computed shortcuts into the gfile.
save_shortcuts() {
    # Erase the contents of the gfile.
    >$gfile

    # Finally write the hash into the gfile.
    for i in "${!gshortcuts[@]}"; do
        echo "$i" >> $gfile
        echo "${gshortcuts[$i]}" >> $gfile
    done
}

# The main function for this script.
g() {
    version="0.1"
    cmd="$1"
    gfile=$HOME/.gfile
    declare -A gshortcuts

    # Make sure that the gfile actually exists.
    if [ ! -z "$GFILE" ]; then
        gfile="$GFILE"
    fi
    touch $gfile

    # Parse the command.
    case "$cmd" in
    -v | --version)
        echo "g version: $version"
        ;;
    -h | --help)
        help
        ;;
    add)
        path=`pwd`
        if [ "$#" != "2" ] && [ "$#" != "3" ]; then
            echo "usage: g add <name> [path]"
            return
        fi
        if [ "$#" == "3" ]; then
            path=$3
        fi
        get_shortcuts
        gshortcuts[$2]=$path
        save_shortcuts
        ;;
    rm)
        if [ "$#" != "2" ]; then
            echo "usage: g rm <name>"
            return
        fi
        get_shortcuts
        unset gshortcuts[$2]
        save_shortcuts
        ;;
    list)
        get_shortcuts
        if [[ "$#" == "2" && "$2" == "--keys" ]]; then
            str=""
            for i in "${!gshortcuts[@]}"; do
                str="$str $i"
            done
            echo $str
        else
            for i in "${!gshortcuts[@]}"; do
                echo -e "$i\t=> ${gshortcuts[$i]}"
            done
        fi
        ;;
    *)
        get_shortcuts
        if [ -z ${gshortcuts[$cmd]} ]; then
            echo -e "Unknown shortcut \`$cmd'.\n"
            usage
        else
            cd ${gshortcuts[$cmd]}
        fi
        ;;
    esac
}
