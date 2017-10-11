#/bin/bash

# 全局参数
prog_name='program_name'
prog_desc='program_desc'
prog_root_dir='./'
is_del_prog=false

# 使用说明
function show_usage() {
    echo "Usage: sh $0 项目名称 项目概述 [是否删除原地址] [根路径]"
    exit -1
}

function readme_file() {
    title=$1
    content=$2
    file_path=$3

    # echo "title $title\ncontent $content\n file_path $file_path\n"
    echo "# $title\n" > $file_path
    echo "$content\n" >> $file_path
}

# 移动or复制
function move_or_copy() {
    # 创建文件夹
    ls_date=`date +%Y%m%d`
    dist_dir_path="$MY_ACHIEVE_HOME/$1_$ls_date"
    #echo "dist_dir_path:$dist_dir_path\n"
    if [ -d "$dist_dir_path" ];then
        echo "项目目录重复！"
        exit -1
    fi
    mkdir -p $dist_dir_path

    # 添加readme
    readme_file $1 $2 "$dist_dir_path/README.md"
    # echo "program_root_dir:$prog_root_dir\n"

    if [ "$4" = 'false' ];then 
        # copy
        # 递归复制文件
        cp -R -v $3 $dist_dir_path
    elif [ "$4" = "true" ];then
        # move
        cp -R -v $3 $dist_dir_path
    else 
        echo "is_del_prog must [true|false]!"
        exit -1
    fi
}

# 初始化工作
[ -z "$MY_ACHIEVE_HOME" ] && MY_ACHIEVE_HOME="$HOME/achive"
if [ ! -d "$MY_ACHIEVE_HOME" ]; then
    echo "you must [mkdir -p $MY_ACHIEVE_HOME]!"
    exit -1
fi

if [ $# -lt 2 ]; then 
    show_usage $@
fi

# echo "$#个参数"
# echo "hello world"

# 获取参数
prog_name=$1
prog_desc=$2

if [ $# -gt 2 ]; then
    is_del_prog=$3
fi

if [ $# -gt 3 ]; then
    prog_root_dir=$4
fi

# 打印参数
echo "归档程序 0.0.1\n\nargs:\n\tprog_name:\t$prog_name\n\tprog_desc:\t$prog_desc\n\tprog_root_dir:\t$prog_root_dir\n\tis_del_prog:\t$is_del_prog\n"

# 执行
move_or_copy $prog_name $prog_desc $prog_root_dir $is_del_prog

exit 0


