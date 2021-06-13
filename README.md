# git-activity

Polls a list of remote locations for Git activity since a given date

Finds all Git repositories (by existence of a .git directory) at each listed location.

Each repository is checked for:
 * unstaged changes
 * staged but uncommitted changes
 * all commits on or after the date argument

git clone https://github.com/whitelamp-uk/git-activity.git
cd git-activity
cp git-activity.cfg-example git-activity.cfg
nano git-activity.cfg
bash git-activity.bash

