#!/bin/bash
#2013-12-14 
#config for git

echo -n "You sure you want to config your git?(Y/N): "
read answer
if ! [[ $answer == "Y" || $answer == "y" ]];then
    exit 0
fi

git config --global user.name xiaok
git config --global user.email helloassemble@outlook.com
#git config --global user.email helloassemble@gmail.com

git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global aslias.glog "log --graph"
git config --global color.ui true
git config --global color.status.added "green normal "
git config --global  color.status.modified "green blue bold"
git config --global color.status.changed "green blue bold" 
git config --global color.status.untracked magenta

#支持中文名??
#git config --global core.quotepath false

