

# Configuration
source "$(dirname "$(realpath "$0")")/git-activity.cfg"

# Since date (inclusive)
if [ ! $1 ]
then
    echo "Usage: $0 [since (yyyy-mm-dd)]"
    exit
fi

for loc in $locations
do
    read account path <<< "$(echo $loc | tr ':' ' ')"
    for gitloc in $(ssh $account "cd $path ; find . -type d -name '.git'")
    do

        echo ""
        echo "================================"
        echo "$account:$path/$(dirname $gitloc) SINCE $1"

        echo "Unstaged: ----------------------"
        ssh $account "cd $gitloc ; cd .. ; git ls-files --others --exclude-standard"
        echo "--------------------------------"

        echo "Uncommitted: -------------------"
        ssh $account "cd $gitloc ; cd .. ; git diff HEAD --name-only"
        echo "--------------------------------"

        echo "Committed: ---------------------"
        ssh $account "cd $gitloc ; cd .. ; git --no-pager log --author=\"$gitauth\" --after=$1T00:00:00"
        echo "--------------------------------"
    done
done

