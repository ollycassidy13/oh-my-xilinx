These are shell scripts for invoking the Xilinx Vivado toolchain on smallish RTL projects to quickly estimate resource utilization and timing of designs. The hardware is assumed to be the VC707 board. (repo named after the cool .oh-my-zsh project)

----------------
How it works
----------------
The script adds all Verilog or VHDL files in given folder to a Vivado project and runs the Synthesis and Implementation phases. It then exports the area/timing/power reports for investigation by the user.

----------------
How to install
----------------

You need to clone the directory in the $HOME folder. Note that you need to rename the directory after cloning.

```git clone git@git.bitbucket.com:nachiketkapre/oh-my-xilinx.git ~/.oh-my-xilinx```

Probably want to modify PATH variable in vivadocompile.sh appropriately for your setup.

--------------
How to run
--------------
Set your PATH variable to include ~/.oh-my-xilinx. Also make sure the XILINX paths are properly setup as well.

```export PATH=$PATH:~/.oh-my-xilinx```

To compile code sitting inside a folder just run:

```vivadocompile.sh <top-level-entity> <clock-name>```

To collect results in a nice summary run:
 
```vivadoresults.sh <top-level-entity>```

--------------
Testing Notes
--------------
Tested to work on Ubuntu 14.04 64b and Vivado 2015.4 toolchain. Older Xilinx releases are also supported using other scripts in the folder "xilinxcompile.sh", etc.

--------------
Author Notes
--------------
Contact: Nachiket Kapre (nachiket@ieee.org)