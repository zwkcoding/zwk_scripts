#!/bin/bash

# git-summary - summarise git repos at some path
#
# Adapted from https://gist.github.com/lmj0011/1a8dd1e376234ac7bf0fba2748ecdd0f
#
# Andy Gimblett, March 2017


usage() {
    sed 's/^        //' <<EOF
        git-summary - summarise git repos at some path
        Usage: git-summary [-h] [-l] [path]
        Given a path to a folder containing one or more git repos,
        print a status summary table showing, for each repo:
          - the folder name
          - the currently checked out branch
          - a short status string showing whether there are:
              - untracked files
              - uncommitted new files
              - uncommitted changes
              - unpulled commits for the current branch
              - unpushed commits for the current branch
        Arguments:
          -h    Print this message
          -l    Local operation only. Without this the script runs
                "git fetch" in each repo before checking for unpushed/
                unpulled commits.  As this can be time consuming, this
                flag lets you skip that.
          path  Path to folder containing git repos; if omitted, the
                current working directory is used.
EOF
}


git_summary() {

    local local_only=0
    local opt
    while getopts "hl" opt; do
        case "${opt}" in
            h) usage ; exit 1 ;;
            l) local_only=1 ;;    # Will skip "git fetch"
        esac
    done
    shift $((OPTIND-1))

    # Use provided path, or default to pwd
    local target=$(readlink -f ${1:-`pwd`})
    local repos=$(list_repos $target)

    # We compute the repo names and branch names here so we can
    # compute their maximum lengths and lay things out nicely.  This
    # can all be done much more easily via the column(1) utility, but
    # that has to consume all its input before it can write anything
    # out, which isn't great when you're running "git fetch" on a
    # whole bunch of repos.  Doing it like this allows us to write the
    # output to stdout incrementally.

    local branches=$(repo_branches $target)
    local max_repo_len=$(max_len "$repos")
    local max_branch_len=$(max_len "$branches")
    local template=$(printf "%%-%ds  %%-%ds  %%-s\\n" $max_repo_len $max_branch_len)

    print_header "$template" $max_repo_len $max_branch_len

    local f
    local here=`pwd`
    for f in $repos ; do
        cd $target/$f
        summarise_one_git_repo "$template" "$local_only" >&1
    done
    cd $here
}


print_header () {
    local template="$1"
    local max_repo_len=$2
    local max_branch_len=$3
    printf "$template\n" repo branch state
    print_divider () {
        printf '=%.0s' $(seq 1 $max_repo_len)
        printf '  '
        printf '=%.0s' $(seq 1 $max_branch_len)
        printf '  '
        printf '=%.0s' $(seq 1 5)
        printf '\n'
    } ; print_divider
}


summarise_one_git_repo () {

    local template=$1
    local local_only=$2

    local app_name=`basename $(pwd)`
    local branch_name=`git rev-parse --abbrev-ref HEAD`
    printf "$template" $app_name $branch_name >&1

    local state=""
    local untracked=`git status | grep Untracked -c`
    local new_files=`git status | grep "new file" -c`
    local modified=`git status | grep modified -c`
    state+=$([ $untracked -ne 0 ] && echo "?" || echo " ")
    state+=$([ $new_files -ne 0 ] && echo "+" || echo " ")
    state+=$([ $modified  -ne 0 ] && echo "M" || echo " ")
    echo -n "$state" >&1

    local rstate=""
    local has_upstream=`git rev-parse --abbrev-ref @{u} 2> /dev/null | wc -l`
    if [ $has_upstream -ne 0 ] ; then
        if [ $local_only -eq 0 ] ; then
            git fetch -q &> /dev/null
        fi
        # Unpulled and unpushed on *current* branch
        local unpulled=`git log --pretty=format:'%h' ..@{u} | wc -c`
        local unpushed=`git log --pretty=format:'%h' @{u}.. | wc -c`
        rstate+=$([ $unpulled -ne 0 ] && echo "v" || echo " ")
        rstate+=$([ $unpushed -ne 0 ] && echo "^" || echo " ")
    else
        rstate+="--"
    fi
    echo "$rstate" >&1

}


# Given the path to a git repo, compute its current branch name.
repo_branch () {
    git --git-dir=$1/.git rev-parse --abbrev-ref HEAD
}


# Given a path to a folder containing some git repos, compute the
# names of the folders which actually do contain git repos.
list_repos () {
    find $1 -maxdepth 2 -type 'd' -name ".git" -print0 | xargs -0 -L1 dirname -z | xargs -0 -L1 basename
}


# Given the path to a folder containing git some repos, compute the
# names of the current branches in the repos.
repo_branches () {
    local root=$1
    local repo
    for repo in $(list_repos $root) ; do
        echo $(repo_branch $root/$repo)
    done
}


max_len () {
    echo "$1" | gawk '{ print length }' | sort -rn | head -1
}


git_summary $@
