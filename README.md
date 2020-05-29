# assistance
A shell script framework so assist you in managing all of your scripts. This is
currently filled in with my configs shell scripts

## Installation:
``` bash
git clone git@github.com:p4p1/assistance.git
cd assistance/ && chmod +x ./assistance.sh && ./assistance.sh -i
```

## Tutorial:
To add new scripts to this project you need to create a .sh file inside of the
src folder. All of the files in the src folder will be sourced to the main
script. Every scripts need to start by sourcing the vars.sh file that is located
in /opt/assistance/data/.
Files need to be name in this case: file_name_is_this.sh. This script will take
the file name and set it like so in the prompt: file name is this ?.

##### example_script.sh
``` bash
# file_name.sh
source /opt/assistance/data/vars.sh

echo -n "Please enter your name: "
read name
echo "Hello $name"
```
![example_script](https://raw.githubusercontent.com/p4p1/assistance/master/assets/example.png)

## Usage:
``` bash
Description:
    Need to work with a lot of shell scripts? Assistances is a framework to
    manage your shell scripts in a nice environement.
Usage:
    ./assistance.sh
    ./assistance.sh -b         # Show a banner
    ./assistance.sh -i         # Install this software
    ./assistance.sh -n [file]  # Add a new script
    ./assistance.sh -d [file]  # Delete a script
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
├── assistance.sh       # Main script of this folder
├── README.md           # this file
|
└── src/            # Folder with the scripts to be executed
    └── ....        # add your scripts in this folder
```
