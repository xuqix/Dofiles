#!/bin/bash
#2013-12-14 21:30

#create symlink in your $HOME for any config 


conf_dir=$(cd `dirname $0`; pwd)

function create_symlink() 
{
    if [[ -f $2 || -d $2 ]]; then
        echo "The file \"$2\" already exists."
        echo -n "Replace it?(Y/N): "
        read answer
        
        if ! [[ $answer == "Y" || $answer == "y" ]];then
            echo "Nothing to do."
            return 
        fi

        if [[ $3 == "backup" ]];then
            mv -i $2 ${2}"_backup"
        fi
    fi

    dir=$(dirname $2)

    if [[ ! -d $dir ]];then
        echo "Create directory for the symlink: $dir"
        mkdir -p $dir
    fi

    echo "Create symlink from $conf_dir/$1 to $2"
    echo -n `ln -sf $conf_dir/$1 $2`
}

echo -n "Do you want to config in your system?(Y:N) :"
read ans
if ! [[ $ans == "Y" || $ans == "y" ]];then
    echo "Nothing to do."
    exit 0
fi

#in here you can add your config file like this:
#       create_symlink <config file> <symlink file in your os>
create_symlink vim/.vimrc ~/.vimrc backup
create_symlink vim/.vim ~/.vim backup
create_symlink gdb/.gdbinit ~/.gdbinit backup
create_symlink gdb/.cgdb ~/.cgdb backup
create_symlink bpython/.bpython ~/.bpython backup
create_symlink bash/.bashrc ~/.bashrc backup

#auto write from add_app.sh
create_symlink /home/xiaok/Dofiles/tweak/.tweakrc /home/xiaok/.tweakrc backup
