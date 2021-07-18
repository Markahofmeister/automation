# Automation
A collection of system-level programs to automate menial tasks with project organization

## create-project.cmd: 

This script will work in a Windows command line. The purpose of the script is to create a remote github repository, named the argument passed to the script. The repository is based on a template repository. 

It will then make a directory ouside of the automation folder, named the same as the remote directory. It will clone the remote repository to the local directory, and then rename the Item-List.xlsx file that is used for Accounting to a project-specific name. Finally, it creates 3 commonly used directories for different parts of a project. 

create-project.cmd requires the use of Github CLI, so gh.exe must be in the same directory. 

