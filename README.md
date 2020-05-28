# assistance
A shell script project to call other shell scripts automatically and do what you
want. Currently made for the school dev&go and calls installation scripts. This
project can be changed to whatever :)

## Installation:
``` bash
git clone git@github.com:p4p1/assistance.git
cd assistance/ ; chmod +x ./problem.sh ; ./problem.sh -i
```

## Tutorial:

To add new scripts to this project you need to create a .sh file inside of the
src folder. All of the files in the src folder will be sourced to the main
script. Every scripts need to start by sourcing the vars.sh file that is located
in /opt/problem/data/.

##### example_script.sh
``` bash
source /opt/problem/data/vars.sh

echo -n "Please enter your name: "
read name
echo "Hello $name"
```

## Usage:
``` bash
Description:
    New to linux? no worries, this tool helps you correct a few bugs
    here and there to help you have a stable working environement.
Usage:
    ./problem.sh
    ./problem.sh -b         # Show a banner
    ./problem.sh -i         # Install this software
Made by p4p1
```

## Tree:
``` bash
assistance/
|
├── banner/         # The folder with all of the banners
│   ├── blackmesa.sh    # Banner 1
│   ├── devgo.sh        # Banner 2
│   └── webac.sh        # Banner 3
|
├── data/           # Data folder for misc information
│   ├── packages.txt    # list of the packages
│   └── vars.sh         # global variables for the scripts
|
├── problem.sh          # Main script of this folder
├── README.md           # this file
|
└── src/            # Folder with the scripts to be executed
    └── ....        # add your scripts in this folder
```
