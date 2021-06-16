

# Configuration
source "$(dirname "$(realpath "$0")")/git-activity.cfg"

# Since date (inclusive)
if [ ! $1 ]
then
    echo "Usage: $0 [since (yyyy-mm-dd)]"
    exit
fi

echo "SINCE $1"

for loc in $locations
do
    read account path <<< "$(echo $loc | tr ':' ' ')"
    for gitloc in $(ssh $account "cd $path ; find . -type d -name '.git'")
    do

        echo "================================"
        ssh $account "cd $path ; cd $gitloc ; cd .. ; echo -n $account: ; pwd"

        echo "Unstaged: ----------------------"
        ssh $account "cd $path ; cd $gitloc ; cd .. ; git ls-files --others --exclude-standard"
        echo "--------------------------------"

        echo "Uncommitted: -------------------"
        ssh $account "cd $path ; cd $gitloc ; cd .. ; git diff HEAD --name-only"
        echo "--------------------------------"

        echo "Committed: ---------------------"
        ssh $account "cd $path ; cd $gitloc ; cd .. ; git --no-pager log --author=\"$gitauth\" --after=$1T00:00:00"
        echo "--------------------------------"

        echo ""

    done
done

