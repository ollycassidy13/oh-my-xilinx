These are shell scripts that are compatible with zsh to invoking the Xilinx
toolchain on research problems.

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

Thanks: This git repository is inspired by oh-my-zsh