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


# Print the usage string.
__g_usage() {
    echo "usage: g [-h | --help] [-v | --version] <command> [<args>]"
}

# Print the help message.
__g_help() {
    __g_usage
    echo -e "\nThe g commands are:"
    tab=$'\t'
    column -t -s $'\t' <<HERE
   add${tab}Add a new shortcut.
   rm${tab}Remove a shorcut.
   list${tab}List all the available shortcuts.
HERE
}

# Fill the hash of shortcuts with the contents of the __g_file.
__g_get_shortcuts() {
    local i=0 word=""

    __g_shortcuts=()
    while read line; do
        if [ ! -z "$line" ]; then
            if [ "$word" == "" ]; then
                word=$line
            else
                __g_shortcuts[$word]=$(eval echo $line)
                word=""
            fi
            i=$(($i+1))
        fi
    done < $__g_file
}

# Save the computed shortcuts into the __g_file.
__g_save_shortcuts() {
    # Erase the contents of the __g_file.
    >$__g_file

    # Finally write the hash into the __g_file.
    for i in "${!__g_shortcuts[@]}"; do
        echo "$i" >> $__g_file
        echo "${__g_shortcuts[$i]}" >> $__g_file
    done
}

# Returns true if the given parameter is a keyword, false otherwise.
__g_is_keyword() {
    case "$1" in
    add | rm | list | -v | --version | -h | --help)
        return 0
        ;;
    *)
        return 1
    esac
}

# It returns a string with all the elements of the given array joined by slash
# characters.
__g_join_path() {
    local IFS="/"; echo "$*";
}

# The main function for this script.
g() {
    version="0.3.8"
    cmd="$1"
    __g_file=$HOME/.gfile
    declare -A __g_shortcuts

    # Make sure that the __g_file actually exists.
    if [ ! -z "$GFILE" ]; then
        __g_file="$GFILE"
    fi
    touch $__g_file

    # Parse the command.
    case "$cmd" in
    -v | --version)
        echo "g version $version"
        ;;
    -h | --help)
        __g_help
        ;;
    add)
        if [ "$#" = "2" ]; then
            path=`pwd`
        else
            if [ "$#" = "3" ]; then
                path=$3
            else
                echo "usage: g add <name> [path]"
                return 1
            fi
        fi
        if __g_is_keyword $2; then
            echo "Cannot use '$2': keyword."
            return 1
        fi
        __g_get_shortcuts
        __g_shortcuts[$2]=$(realpath $path)
        __g_save_shortcuts
        ;;
    rm)
        if [ "$#" != "2" ]; then
            echo "usage: g rm <name>"
            return 1
        fi
        __g_get_shortcuts
        unset __g_shortcuts[$2]
        __g_save_shortcuts
        ;;
    list)
        __g_get_shortcuts
        if [[ "$#" = "2" && "$2" = "--keys" ]]; then
            str=""
            for i in "${!__g_shortcuts[@]}"; do
                str="$str $i"
            done
            echo $str
        else
            for i in "${!__g_shortcuts[@]}"; do
                echo -e "$i\t=> ${__g_shortcuts[$i]}"
            done | sort | column -t -s $'\t'
        fi
        ;;
    *)
        __g_get_shortcuts

        # Split the path and check whether the first element is a shortcut or
        # not.
        IFS='/' read -a path <<< $cmd
        init=${path[0]}

        if [ -z ${__g_shortcuts[$init]} ]; then
            echo -e "Unknown shortcut \`$init'.\n"
            __g_usage
            return 1
        else
            # Expand the shortcut and append the remaining parts of the path.
            path[0]="${__g_shortcuts[$init]}"
            cd $(__g_join_path ${path[@]})
        fi
        ;;
    esac

    return 0
}
