# Steps to use `git`.


## 1. Show the current status of git
It is a good idea to do this as often as possible, so that you know what is happening inside your directory.
```
git status
```

Result
```
On branch main
Your branch is up-to-date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        git_tutorial.md

nothing added to commit but untracked files present (use "git add" to track)
```


## 2. Adding files to the staging area
This tells git that you want put these files for a commit. It means that git now tracks this file.

You can add just a single file:
```
git add <file name>
```

Or every file in the current directory:
```
git add .
```

Example result
```
On branch main
Your branch is up-to-date with 'origin/main'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   git_tutorial.md
```

## 3. Committing changes
Once you have added your changes, you can make a **commit**. A commit is **immutable** and is identified with a unique hash. 

**Important**: You should make small commits often, instead of big commits rarely.

To make a commit:
```
git commit -m "<a commit message>"
```

Example output:
```
git commit -m "Adding a small tutorial for git"

[main 6dd4388] Adding a small tutorial for git
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 git_tutorial.md
```

**Important**: Make sure to type a commit message that describes your changes.


## 4. Push changes
Now that the changes are committed, they just exist locally on your machine. But we want others to see the changes as well! So we need to push.

To push
```
git push
```

Example output:
```
Counting objects: 2, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 256 bytes | 51.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To github.com:Gianlufrez/ADM_HW4.git
   350b8c3..6dd4388  main -> main
```



