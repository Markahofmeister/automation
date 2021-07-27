# Automation
A collection of system-level programs to automate menial tasks with project organization

## cp.cmd: Create new Project

This script will work in a Windows command line. The purpose of the script is to create a remote github repository, named the argument passed to the script. The repository is based on a template repository. 

It will then make a directory ouside of the automation folder, named the same as the remote directory. It will clone the remote repository to the local directory, and then rename the Item-List.xlsx file that is used for Accounting to a project-specific name. Finally, it creates 3 commonly used directories for different parts of a project. 

cp.cmd requires the use of Github CLI, so gh.exe must be in the same directory. 

This Batchfile saves a tremendous amount of time creating new repositories, allowing me to begin work on a new idea and immediately version control my whole process. 

##c+p.cmd: Commit + Push

This script will simply add all modified files tracked by git to git's stage, commit them with a user provided message, and push the changes to remote repositories. 

While it's a very simple file, almost negligibly faster, I commit + push shanges frequently enough where this is a very helpful tool to have. 