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

#Jenkins中编译好的jar位置
JAR_PATH=${PROJECT_PATH}/target

#备份路径（最终运行路径）
BACKUP_PATH=/home/backups

#备份
\cp -f ${JAR_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar ${BACKUP_PATH}

#关闭上一次运行中的进程
killServer

echo "启动项目开始"
nohup java -jar ${BACKUP_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar >  /dev/null &
echo "启动项目结束"