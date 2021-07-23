#!/usr/bin/env bash

# - https://mywiki.wooledge.org/IFS

cd "$(dirname "${BASH_SOURCE[0]}")";

# TODO: review quoting and bracket usage for variables. I actually need to do that before I continue with these notes

# - The default value of the IFS is space, tab, newline

# - The start and end of the sequence are inclusive
# - By default, the output of seq is a single string that contains numbers separated by newlines 
generate_ascending_sequence() {
    sequence=$(seq 1 10);
    printf '%s' $sequence # 12345678910
    printf '%s' "$sequence" # 1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n
    printf '%s' "$(seq 1 3 10)" # 1\n4\n7\n10


    #for num in "${s}";
    #do
    #    printf '%d' "${num}";
    #done;
}

descending_integers() {
    seq 10 1;
    #seq 10 4 1;
}

generate_ascending_sequence;
#descending_integers