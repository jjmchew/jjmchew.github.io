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



## New repo
- after creating repo online
- locally:
  - `git init`
  - `git add .`
  - `git commit -m "first commit"`
  - `git branch -M main`
  - `git remote add origin https://github.com/...`
  - `git push -u origin main`


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

- always be sure you haved checked out the branch you want to merge **into**
  - then run `git merge [branchName]`, where `branchName` is the other branch

- `git merge --abort` : if there are conflicts, just abort the merge
- after resolving conflicts i.e., editing the file(s) that have conflicts:
  - need to `git add [conflicting files]`
  - then `git commit -m "commitMessage"`



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


## Bringing main back into feature branches
- `git rebase main` : integrates upstream changes into the local repository
  - i.e., "base my changes on what everybody has already done"
  - moves or combines a sequence of commits to a new base commit
  - e.g., if commits were previously based on a prior version of main, we can make them branch off a later version of main
    - this creates a linear commit history which makes it easier to debug
  - https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase


- if there are merge conflicts - need to modify the merge file (remove the git added annotations) and then add and commit that file
  - i.e., edit conflicting file
  - `git add conflicting file`
  - `git commit -m "message here"`
  - `git rebase --continue`

- rules for using `rebase`:
  - https://www.atlassian.com/git/tutorials/merging-vs-rebasing#the-golden-rule-of-rebasing
  - use `git rebase main` ONLY on private (non-public) branches
    - e.g.,  do NOT do `git checkout main`, `git rebase feature`  
    - if you rebase a public branch (e.g., main) onto your feature branch, then there will be 2 diverging versions of that public branch - the original, and the one you added to your feature branch:  this is hard to fix and confusing

  - rebase is typically best if your feature branch is long-lived
    - rebase often will reduce conflicts for a future merge or rebase
    - if you no longer need the feature branch, git merge may add an extra commit and obscure history, but may not require multiple conflicts to be resolved

  - don't do a `git rebase` AFTER submitting your pull request (once other devs look at your code - it's a public branch)
    - always use `git merge` for subsequent changes

  - a great way to use `rebase` is BEFORE a pull request, do an interactive rebase (e.g., `git rebase -i HEAD~3` : allows you to re-write the last 3 commits (e.g., combine, etc.) and help create a linear commit history after merging onto main
  - https://git-scm.com/docs/git-rebase#_interactive_mode





## renaming a branch
- `git branch -m oldName newName`
- OR: rename current branch:
  - `git branch -m newName`



## Conventional commits
- <type>(scope): <description>

- types:
  - `fix` : patch a bug fix
  - `feat` : introduce a new feature
  - add `!` to type : introduces a breaking change
      - could also add a footer `BREAKING CHANGE`
  - `build`
  - `chore`
  - `docs`
  - `style`
  - `refactor`
  - `perf`
  - `test`
  - `revert`
      - when using this type, recommended to add commit SHAs that are being reverted

    - e.g., `feat(api): send an email to customer when product is shipped` 

- scope:
  - must be a noun describing a section of the codebase
- description:
  - short summary

- if a "body" is included, it must be delineated (i.e., separated from first commit line) with an empty line
- if a "footer" is included, it must be delineated (i.e., separated from body) with an empty line



## Resources
- https://docs.github.com/en/authentication/connecting-to-github-with-ssh
- [How to resolve merge conflicts in git](https://www.youtube.com/watch?v=xNVM5UxlFSA)
- [LS cheatsheet github](https://gist.github.com/NickMiller11/b7bf08f40f712c59d42536df7ee1b299)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary)



