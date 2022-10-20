# Github notes

## General
`git init` \
`git status` \
`git diff [unchanged repo] [changed repo]` 

`git log` \
`git log --pretty=online`  from <https://ma.ttias.be/pretty-git-log-in-one-line/> \
`git log --stat`  

`git add [filename]` \
`git add .`  adds everything (incl. subdirectories) 

`git commit -m "[message]"`  Note:  `commit -a` stages and commits changes to *all* tracked files 

*if necessary* after initial commit, can change branch name (e.g., from master to main) using: \
`git branch -m main` while in the master branch

`git remote add [alias] [url]`  (usually the main alias for remote will be origin)

`git push [alias] [local branch]` \
`git push --set-upstream [alias] [branch name]`




## Connect to a remote repo
`git remote add [nickname] [project-url]`

`git fetch` is the first half of git pull, can then use git diff to check what changes / commits were \
`git pull`



## Branches
`git branch -a` lists all branches \
`git checkout -b [new branch name]` creates and checks out the [new branch name]

Adds a local branch to remote \
`git push <remote alias> <branch>` e.g., `git push origin [new branch name]`

Delete a branch \
`git branch -d [branch name]`  (delete local branch)\
`git push --delete origin [branch name]`  (delete remote branch)



## To merge (into main)
`git checkout main`\
`git merge [branch name] --no-ff` (could also use ` --squash ` ) \
`git push`


