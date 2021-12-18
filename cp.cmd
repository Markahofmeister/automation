@ECHO OFF

REM  This script:
REM  - Creates a new remote repository on Github 
REM  - Clones the remote repository to the local machine
REM  - renames item list to project-specific name
REM  - Creates a media directory, fab files directory, code directory, subdirectories 
REM  - Moves runPlant.cmd, plantuml.jar, flowsheet-v1 to flowcharts folder 
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
rename BOM.xlsx %1-BOM.xlsx			
REM  - Creates a media directory, fab files directory, code directory, subdirectories 						
mkdir media fab-files software											
cd media
mkdir flowcharts pinouts-datasheets system-diagrams images 
REM  - Moves flowchart creation scripts to flowchart folder
move C:\Lab\%1\runPlant.cmd C:\Lab\%1\media\flowcharts\		
move C:\Lab\%1\plantuml.jar C:\Lab\%1\media\flowcharts\			
move C:\Lab\%1\flowsheet-v1.txt C:\Lab\%1\media\flowcharts\	
REM  - Runs plantuml on flowsheet-v1
java -jar plantuml.jar "flowsheet-v1.txt"
cd C:\Lab\%1
REM  - Adds c+p.cmd to .gitignore
echo c+p.cmd > .gitignore								
REM  - Adds plantuml.jar (in all directories) to .gitignore 				
echo **/plantuml.jar >> .gitignore											
git add .
REM  - Commits Initial Files
git commit -m "Initial File Commit" 									
git push origin main 
cd C:\Lab\automation 
git remote set-url origin https://github.com/Markahofmeister/automation.git
git push --set-upstream origin main 


ECHO New project file created 
