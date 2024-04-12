# Github notes

## General
- `git init`
- `git status`
- `git diff [unchanged repo] [changed repo]`
>
- `git log` 
- `git log --pretty=online`  from <https://ma.ttias.be/pretty-git-log-in-one-line/> 
- `git log --stat`  
>
- `git add [filename]`
- `git add .`  adds everything (incl. subdirectories) 
>
- `git commit -m "[message]"`  Note:  `commit -a` stages and commits changes to *all* tracked files 
>
- *if necessary* after initial commit, can change branch name (e.g., from master to main) using:
- `git branch -m main` while in the master branch
>
- `git remote add [alias] [url]`  (usually the main alias for remote will be origin)
>
- `git push [alias] [local branch]`
- `git push --set-upstream [alias] [branch name]`

- `git grep -n [search term]` : will search all files in repo for 'search term'; `-n` displays line numbers for match



## Connect to a remote repo
- `git remote add [nickname] [project-url]`
>
- `git fetch` is the first half of git pull, can then use git diff to check what changes / commits were
- `git pull`



## Branches
- `git branch -a` lists all branches
- `git checkout -b [new branch name]` creates and checks out the [new branch name]
  

Adds a local branch to remote
- `git push <remote alias> <branch>` e.g., `git push origin [new branch name]`

Delete a branch
- `git branch -d [branch name]`  (delete local branch)
- `git push --delete origin [branch name]`  (delete remote branch)



## To merge (into main)
- `git checkout main`
- `git merge [branch name] --no-ff` (could also use ` --squash ` ) 
- `git push`



## Replicating an online repo
- from: https://stackoverflow.com/questions/5377960/git-whats-the-best-practice-to-git-clone-into-an-existing-folder (2nd solution, doesn't use git clone)
- create the desired directory and enter it
- `git init` : to create a new repo in the desired directory
- `git remote add origin [repo url]`
- `git fetch origin`
- `git checkout -b main --track origin/main`

### git clone
https://docs.github.com/en/get-started/using-git/getting-changes-from-a-remote-repository

- `git clone [repo url]` : will create a new folder for the repo (named according to the repo) and clone into that folder
- `git fetch` will fetch any additional work from remote repo
- `git merge remotes/origin/branch-name` will merge work from remote repo with local work

- `git pull` : is a shortcut which combines `git fetch` and `git merge`

- use `git status` to check what is happening, follow-up commands may be given (e.g., `git commit --amend` or `git rebase --continue`)

