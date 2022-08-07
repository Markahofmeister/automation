:: @ECHO OFF

REM  This script:
REM  - Creates a new remote repository on Github
REM  - Clones the remote repository to the local machine
REM  - renames BOM to project-specific name
REM  - Creates a media directory, figures directory, fab files directory, code directory, subdirectories
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

REM  - Prepends project name to the README
echo # %1 >> README-temp.md
type README.md >> README-temp.md
del README.md
ren README-temp.md README.md

REM  - Creates a media directory, figures directory, fab files directory, code directory, subdirectories
mkdir media figures fab software electrical
cd figures
mkdir flowcharts pinouts-datasheets system-diagrams
move C:\Lab\%1\hierarchy.txt C:\Lab\%1\figures\

REM  - Moves flowchart creation scripts to flowchart folder
move C:\Lab\%1\runPlant.cmd C:\Lab\%1\figures\
move C:\Lab\%1\plantuml.jar C:\Lab\%1\figures\
move C:\Lab\%1\flowchart-v1.txt C:\Lab\%1\figures\flowcharts\

REM  - Primes & Runs plantuml on flowsheet-v1
cd C:\Lab\%1\figures\flowcharts\
echo @startuml > "flowchart-v1.txt"
echo start >> "flowchart-v1.txt"
echo stop >> "flowchart-v1.txt"
echo @enduml >> "flowchart-v1.txt"
cd ..
java -jar plantuml.jar "C:\Lab\%1\figures\flowcharts\flowchart-v1.txt"
java -jar plantuml.jar "C:\Lab\%1\figures\hierarchy.txt"
cd C:\Lab\%1

REM  - Adds all .cmd files to .gitignore
echo **/*.cmd > .gitignore

REM  - Adds plantuml.jar (in all directories) to .gitignore
echo **/plantuml.jar >> .gitignore

REM  - Adds hierarchy .txt generation file to .gitignore
echo figures/hierarchy.txt >> .gitignore

REM  - Moves Design Log to Obsidian, renames accordingly
cd C:\Brain-2\Lab
mkdir %1
cd %1
move C:\Lab\%1\Design-Log.md C:\Brain-2\Lab\%1\
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