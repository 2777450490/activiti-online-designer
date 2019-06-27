#!/usr/bin/env bash

##########开始########
## #这一句很重要，这样指定了，项目启动之后才不会被Jenkins杀掉。
## export BUILD_ID=DONTKILLME
## #加载配置参数
## . /etc/profile
## export PROJECT_PATH=`pwd`
## #Maven命令获取项目名
## export PROJECT_NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
## echo "项目名为 ${PROJECT_NAME}"
## #Maven命令获取项目版本
## export PROJECT_VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
## echo "项目版本号为 ${PROJECT_VERSION}"
## sh ${PROJECT_PATH}/deploy.sh
##########结束########
########以上在jenkins网页中编写

#备份路径（最终运行路径）
BACKUP_PATH=/home/backups

#Jenkins中编译好的jar位置
JAR_PATH=${PROJECT_PATH}/target

#项目运行日志文件目录
LOGS_PATH=/home/logs

#项目运行日志文件名
LOGS_FILE_NAME=log.out

killServer(){
    pid=`ps -ef|grep ${PROJECT_NAME}-${PROJECT_VERSION}|grep -v grep|awk '{print $2}'`
    echo "jar Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "没有找到此项目运行的pid"
    else
      kill -9 $pid
    fi
}

createFolder(){
    if [ ! -d $BACKUP_PATH ];then
        mkdir $BACKUP_PATH
    else
        echo "文件夹已经存在"
    fi
}

createLogsFile(){
    if [ ! -d $LOGS_PATH ];then
        mkdir $LOGS_PATH
        touch $LOGS_PATH/$LOGS_FILE_NAME
    else
        if [ ! -f $LOGS_PATH/$LOGS_FILE_NAME  ];then
            touch $LOGS_PATH/$LOGS_FILE_NAME
        else
            echo "日志文件存在"
        fi
    fi
}

createFolder

#备份前先删除之前的备份
rm -f ${BACKUP_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar

#备份
cp ${JAR_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar ${BACKUP_PATH}

#关闭上一次运行中的进程
killServer

#创建日志输出文件
createLogsFile

#清空上次运行日志
echo '' > $LOGS_PATH/$LOGS_FILE_NAME

echo "启动项目开始"
nohup java -jar ${BACKUP_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar > $LOGS_PATH/$LOGS_FILE_NAME &
echo "启动项目结束"