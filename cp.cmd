@ECHO OFF

REM  This script:
REM  - Creates a new remote repository on Github 
REM  - Clones the remote repository to the local machine
REM  - renames item list to project-specific name
REM  - Creates a media directory, fab files directory, code directory, subdirectories 
REM  - Moves runPlant.cmd to flowcharts folder 
REM  - Adds c+p.cmd to repo and .gitignore
REM  - Commits & pushes Initial Files

git remote remove origin
REM  - Creates a new remote repository on Github 
gh repo create %1 --template new-project-template --public --confirm	
mkdir C:\Lab\%1
REM - Clones the remote repository to the local machine
gh repo clone Markahofmeister/%1 C:\Lab\%1								
cd C:\Lab\%1
REM  - renames item list to project-specific name
rename Item-List.xlsx %1-Item-List.xlsx			
REM  - Creates a media directory, fab files directory, code directory, subdirectories 						
mkdir media fab-files software											
cd media
mkdir flowcharts pinouts-datasheets system-diagrams images 
move C:\Lab\%1\runPlant.cmd C:\Lab\%1\media\flowcharts\					
cd C:\Lab\%1
REM  - Adds c+p.cmd to .gitignore
echo c+p.cmd > .gitignore								
REM  - Adds plantuml.jar to .gitignore 				
echo plantuml.jar >> .gitignore											
git add .
REM  - Commits Initial Files
git commit -m "Initial File Commit" 									
git push origin main 
cd C:\Users\marka\Downloads\Lab\automation 
git remote set-url origin https://github.com/Markahofmeister/automation.git
git push --set-upstream origin main 


ECHO New project file created 
