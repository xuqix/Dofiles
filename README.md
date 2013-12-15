Dotfiles
======

linux下面一些常用的配置。大多数人都将自己的dotfiles托管到github等网站上面，用于在新的机器上面快速部署。

1. 可以写shell脚本将dotfiles的配置过程写好。配置运行时候运行脚本就可以了。 主要是备份下原文件，然后ln -s建立软连接的过程。
2. 不同平台上面建立不同的分支。如branch-win。branch-×unix，branch-mac。

脚本说明:

add_app.sh: 
将一个目标文件移动当前目录的一个新目录下，并创建符号链接文件代替原文件,
备份选项可选
e.g: ./add_app.sh ~/.vimrc vim backup

create_symlink:
为新系统部署配置文件(创建指定的符号链接文件),根据需要自行配置修改脚本
参数1只需相对路径,脚本会自动补全路径,备份选项可选
e.g: 在脚本中添加: create_symlink vim/.vimrc  ~/.vimrc backup

config_git.sh:
配置git工具


