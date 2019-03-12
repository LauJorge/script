Here we explain how to use git and gerrit inside RiverMeadow

## Installing git review
Linux/CentOS

    yum install python-pip -y
    pip install git-review

Windows

    Install python and pip - https://www.python.org/downloads/
    From mingw32 shell, execute pip install git-review


## Enabling ssh agent
This is required to talk with Gerrit repository, as all pull and push process goes through SSH

Linux

    eval $(ssh-agent -s)
    ssh-add ~/.ssh/you.private.key

NOTE: This should be executed after every system restart or try to automate it through .bashrc/.bash_profile 

Windows

    1. Download git - https://git-scm.com/download/win
    2. Notepad++, vim or any other editor you like
    3. Putty binaries - https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
    4. Run Pageant and load your private key
    5. Add new environment variable
       GIT_SSH=c:\Program Files\Putty\plink.exe

Step 4 should be repeated after system restart


## Working with git
### Simple workflow to clone, create branch, submit for review and approve

* Clone - git clone ssh://davit-rm@gerrit.rivermeadow.com:29418/RiverMeadow/demo && scp -p -P 29418 davit-rm@gerrit.rivermeadow.com:hooks/commit-msg demo/.git/hooks/
* Prepare for git review

     * git remote rename origin gerrit
     * Or create .gitreview file to use origin in repo root

* Create new branch and submit

>     # Switch to develop branch
>     git checkout develop
>     # Pull all changes from remote server
>     git pull origin develop
>     # Create a new topic/temporary branch
>     git checkout -b NEW-BRANCH;
>     # make your changes
>     # See your changes
>     git diff
>     # Add to index
>     git add .
>     # Commit the changes to local repo
>     git commit -am "RM-0000: Updated with new images"
>     # Create a new review by uploading changes to Gerrit
>     git review develop

* Last command will generate a new gerrit link review, open it and browse
* Ask other developers to review your code and give +2 if everything looks good. Another +1 will be given by Jenkins build
* When you have both +1 and +2, "Submit" button will be available for you to merge the change with parent branch (develop in this case)


### Show how to download review and amend it and re-submit

* Here we pull already existing gerrit review, update and push it back to the same review

>     # Download by review ID
>     git review -d REVIEW_ID
>     # Make your changes
>     git diff
>     git add .
>     # Commit with amend option, to update already commited subject and message
>     git commit --amend
>     # add your comment in opened text editor
>     git review develop # if it's originally created from develop branch


* Cherry pick to another branch - show in UI


### Create new branch for branches other than develop (git review release-85)

>     git checkout release-85
>     git checkout -b NEW-BRANCH
>     # Make some changes
>     git review release-85


### Edit commits inline on the gerrit site

* Open gerrit review page
* Click Edit button, located after Change-ID
* Then click on any file you want to change and update. Save --> Close --> Public Edit


### Submission without RM jira bug number
Create a new review without Jira number

    git checkout develop
    git fetch && git pull origin develop
    git checkout -b NEW-BRANCH
    # Make some changes
    git status
    git diff
    git add .
    git commit -am "Jira comment example"
    git review develop
    remote:
    remote: Processing changes: refs: 1
    remote: Processing changes: refs: 1, done
    To ssh://gerrit.rivermeadow.com:29418/RiverMeadow/demo
    ! [remote rejected] HEAD -> refs/for/develop%topic=v3_1 (REFNAME:refs/for/develop%topic=v3_1
    -->
    ----------------------------------------------------
    Validate JIRA Issue
    hi! Davit Avsharyan (davit@rivermeadow.com) Howdy! This is CI User,
    Your commit message does not have a valid JIRA issue.
    I am really sorry, I cannot allow this commit!
    Please specify a valid JIRA issue.)
    error: failed to push some refs to 'ssh://davit-rm@gerrit.rivermeadow.com:29418/RiverMeadow/demo'


### How to fix

    git commit --amend
    # Update subject and add RM-XXXX: where XXXX is your ticket number.
    # If you don't have a ticket, then just add 0000
    # The result should look like "RM-XXXX: Jira comment example"
    git review develop



### Feature branch with multiple commits and squash commit

Feature branch is used to work on long term features when it's later can be merged with main branch

    git checkout develop
    git pull origin develop

    # Create a new feature branch, it must start with feature/
    git checkout -b feature/v1

    touch file1
    git add file1
    git commit -am "RM-0000: Added file1"

    touch file2
    git add file2
    git commit -am "RM-0000: Added file2"

    git push origin feature/v1


When you're done with all commits and want to merge with develop branch then


    git review develop
    # This will thrown an error, because it's not allowed to push multiple commits in one review.
    # All commits should be squashed into one and then pushed to gerrit

    # Fix is
    git rebase -i develop
    # This will open text editor and you have to squash all your commits
    # First commit should have pick, all others squash
    pick aaa1111 RM-0000: Added file1
    squash aaa2222 RM-0000: Added file2

    # On the next screen merge all comments and make sure the first line has proper subject
    #  that starts with RM-0000: , save and close editor
    git review develop



### Resolving a merge conflict on gerrit

Some other commit got merged in after you branched of develop and this commit touches some of the same code

    git checkout develop
    git pull origin develop
    git review -d 12345
    git rebase develop
    # Fix conflicts manually
    git add *
    git rebase –continue
    git review develop
