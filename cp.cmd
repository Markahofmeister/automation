@ECHO OFF

REM  This script:
REM  - Creates a new remote repository on Github 
REM  - Clones the remote repository to the local machine
REM  - renames item list to project-specific name
REM  - Creates a media directory, fab files directory, code directory

git remote remove origin
gh repo create %1 --template new-project-template --public --confirm
mkdir C:\Users\marka\Downloads\Lab\%1
gh repo clone Markahofmeister/%1 C:\Users\marka\Downloads\Lab\%1
cd C:\Users\marka\Downloads\Lab\%1
rename Item-List.xlsx %1-Item-List.xlsx
mkdir media fab-Files software
cd media
mkdir flowsheets pinouts-datasheets systemDiagrams images 
cd ..
echo c+p.cmd > .gitignore
git add .
git commit -m "Initial File Commit" 
git push origin main 
cd C:\Users\marka\Downloads\Lab\automation 
git remote set-url origin https://github.com/Markahofmeister/automation.git
git push --set-upstream origin main 


ECHO New project file created 