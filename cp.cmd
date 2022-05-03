@ECHO OFF

REM  This script:
REM  - Creates a new remote repository on Github 
REM  - Clones the remote repository to the local machine
REM  - renames BOM to project-specific name
REM  - Creates a media directory, fab files directory, code directory, subdirectories 
REM  - Moves runPlant.cmd, plantuml.jar, flowsheet-v1 to flowcharts folder 
REM  - Adds c+p.cmd to repo and .gitignore
REM  - Moves Design Log to Obsidian, renames accordingly
REM  - Commits & pushes Initial Files

git remote remove origin

REM  - Creates a new remote repository on Github 
gh repo create %1 --template new-project-template --public --confirm	
mkdir C:\Lab\%1

REM - Clones the remote repository to the local machine
gh repo clone Markahofmeister/%1 C:\Lab\%1								
cd C:\Lab\%1

REM  - renames BOM to project-specific name
rename BOM.xlsx %1-BOM.xlsx			

REM  - Creates a media directory, fab files directory, code directory, subdirectories 						
mkdir media figures fab-files software											
cd figures
mkdir flowcharts pinouts-datasheets system-diagrams schematics

REM  - Moves flowchart creation scripts to flowchart folder
move C:\Lab\%1\runPlant.cmd C:\Lab\%1\media\	
move C:\Lab\%1\plantuml.jar C:\Lab\%1\media\		
move C:\Lab\%1\flowchart-v1.txt C:\Lab\%1\media\flowcharts\	

REM  - Primes & Runs plantuml on flowsheet-v1
cd C:\Lab\%1\media\flowcharts\	
echo @startuml > "flowchart-v1.txt"
echo start >> "flowchart-v1.txt"
echo stop >> "flowchart-v1.txt"
echo @enduml >> "flowchart-v1.txt"
cd ..
java -jar plantuml.jar C:\Lab\%1\media\flowcharts
cd C:\Lab\%1

REM  - Adds all .cmd files to .gitignore
echo **/*.cmd > .gitignore								

REM  - Adds plantuml.jar (in all directories) to .gitignore 				
echo **/plantuml.jar >> .gitignore		

REM  - Moves Design Log to Obsidian, renames accordingly
cd C:\Brain-2\Lab
mkdir %1
cd %1
move C:\Lab\%1\Design-Log.md C:\Obsidian\Lab\%1\
rename Design-Log.md %1-Design-Log.md

REM  - Commits Initial Files	
cd  C:\Lab\%1						
git add .
git commit -m "Initial File Commit" 									
git push origin main 
cd C:\Lab\automation 
git remote set-url origin https://github.com/Markahofmeister/automation.git
git push --set-upstream origin main 


ECHO New project directory created 
