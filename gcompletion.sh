# Copyright (C) 2013-2018 Miquel Sabaté Solà <mikisabate@gmail.com>
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


# Do the completion work. Shamelessly taken from the git completion script.
__gcomp()
{
    local all c s=$'\n' IFS=' '$'\t'$'\n'
    local cur="${COMP_WORDS[COMP_CWORD]}"

    for c in $1; do
        case "$c$4" in
        --*=*) all="$all$c$4$s" ;;
        *.)    all="$all$c$4$s" ;;
        *)     all="$all$c$4 $s" ;;
        esac
    done
    IFS=$s
    COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
    return
}

# Main function for the completion of the g command.
_g()
{
    local c=1 command
    opts=$(g list --keys)

    while [ $c -lt $COMP_CWORD ]; do
        command="${COMP_WORDS[c]}"
        c=$((++c))
    done

    if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
        case "${COMP_WORDS[COMP_CWORD]}" in
        --*)   __gcomp "--version --help" ;;
        *)     __gcomp "${opts}" ;;
        esac
        return
    fi

    case "$command" in
    rm)         __gcomp "${opts}" ;;
    *) COMPREPLY=() ;;
    esac
}


complete -o default -o nospace -F _g g
