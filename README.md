These are shell scripts that are compatible with zsh for invoking the Xilinx
toolchain on smallish research projects. The scripts are intended to quickly estimate resource utilization and timing of small Verilog/RTL designs. 

----------------
How it works
----------------
The script adds all Verilog files in given folder to a Vivado project and runs the Synthesis and Implementation phases. It then exports the area/timing/power reports for investigation by the user.

----------------
How to install
----------------

You need to clone the directory in the $HOME folder. Note that you need to rename the directory after cloning.

```git clone git@git.bitbucket.com:nachiketkapre/oh-my-xilinx.git ~/.oh-my-xilinx```

--------------
How to run
--------------
Set your PATH variable to include ~/.oh-my-xilinx. Also make sure the XILINX paths are properly setup as well.

```export PATH=$PATH:~/.oh-my-xilinx

To compile code sitting inside a folder just run:

```vivadocompile.sh <top-level-entity> <clock-name>```

To collect results in a nice summary run: (Not implemented yet)
 
```vivadoresults.sh <top-level-entity>```

--------------
Testing Notes
--------------
Tested to work on Ubuntu 14.04 64b and Vivado 2015.4 toolchain. Older Xilinx releases are also supported using other scripts in the folder "xilinxcompile.sh", etc.
Thanks: This git repository is inspired by oh-my-zsh