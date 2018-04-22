These are shell scripts for invoking the Xilinx Vivado toolchain on smallish RTL projects to quickly estimate resource utilization and timing of designs. 
The hardware (fpga_part) is assumed to be the PYNQ board, but can be specified as a command line argument. 
(repo named after the cool .oh-my-zsh project)

----------------
How it works
----------------
The script adds all Verilog or VHDL files in given folder to a Vivado project and runs the Synthesis and Implementation phases. It then exports the area/timing/power reports for investigation by the user.

----------------
How to install
----------------

First, install zsh on your system. For most distros this is available in the
package manager, so for Ubuntu/Debian you could do:

```sudo apt install zsh```

Now clone the git repository, then export an environment variable that
specifies this location as OHMYXILINX:

```git clone git@git.bitbucket.com:maltanar/oh-my-xilinx.git /path/to/local/dir```
```export OHMYXILINX=/path/to/local/dir```

Probably want to modify PATH variable in vivadocompile.sh appropriately for your setup.

--------------
How to run
--------------
Set your PATH variable to include $OHMYXILINX. Also make sure the Xilinx paths
are properly setup as well, i.e. vivado should be on PATH.

```export PATH=$PATH:$OHMYXILINX```

To compile code sitting inside a folder just run:

```vivadocompile.sh <top-level-entity> <clock-name (optional)> <fpga-part (optional)>```

To collect results in a nice summary run:

```vivadoresults.sh <top-level-entity>```

--------------
Testing Notes
--------------
Tested to work on Ubuntu 14.04 64b and Vivado 2015.4 toolchain. Older Xilinx releases are also supported using other scripts in the folder "xilinxcompile.sh", etc.

--------------
Author Notes
--------------
Original: Nachiket Kapre (nachiket@ieee.org)
Modifications: Yaman Umuroglu (maltanar@gmail.com)
