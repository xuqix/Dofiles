#!/bin/bash
#create date:2013-12-14 21:30
#last change:2014-01-24 18:52

#add new config file to this dir

if [[ $# < 2 ]];then
    echo "usage: add_app <config file> <app name in cur dir> [\"backup\"]"
    exit 0
fi

if ! [[ -f $1 || -d $1 ]];then
    echo "file $1 not exists!"
    exit 0
fi

echo -n "You sure you want to add new config file to here?(Y/N): "
read answer
if ! [[ $answer == "Y" || $answer == "y" ]];then
    echo "Nothing to do"
    exit 0
fi


if [[ -d $2 ]];then
    echo -n "Dir already exists,continue exec?(Y/N): "
    read answer
    if ! [[ $answer == "Y" || $answer == "y" ]];then
        echo "Nothing to do"
        exit 0
    fi
else
    mkdir $2
    echo "create new dir $2"
fi

conf_dir=$(cd `dirname $0`; pwd)
app_dir=$(basename $2)
file_name=$(basename $1)

#backup
if [[ $3 == "backup" ]];then
    cp -ir $1 ${1}"_backup"
    echo "backup $1 to ${1}_backup success!"
fi


mv -i $1 $conf_dir/$app_dir/$file_name
ln -sf $conf_dir/$app_dir/$file_name $1
#cmd="create_symlink $conf_dir/$app_dir/$file_name $1 backup"
cmd="create_symlink $app_dir/$file_name $1 backup"
echo "auto write \"$cmd\" to create_symlink.sh"
echo $cmd >> create_symlink.sh
echo "add new app success!"




