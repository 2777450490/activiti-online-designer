#!/usr/bin/env bash

##########开始########
## export BUILD_ID=DONTKILLME   这一句很重要，这样指定了，项目启动之后才不会被Jenkins杀掉。
## 加载配置参数
## . /etc/profile
## export PROJECT_PATH=`pwd`
## sh ${PROJECT_PATH}/deploy.sh
##########结束########
########以上在jenkins网页中编写


killServer(){
    pid=`ps -ef|grep ${NAME}-${VERSION}|grep -v grep|awk '{print $2}'`
    echo "jar Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no jar pid alive"
    else
      kill -9 $pid
    fi
}

cd ${PROJECT_PATH}/

#Maven命令获取项目名
PROJECT_NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
echo "项目名为 ${PROJECT_NAME}"

#Maven命令获取项目版本
PROJECT_VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
echo "项目版本号为 ${PROJECT_VERSION}"

#Jenkins中编译好的jar位置
JAR_PATH=${PROJECT_PATH}/target

#备份路径（最终运行路径）
BACKUP_PATH=/home/backups

#备份
cp ${JAR_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar ${BACKUP_PATH}/

#关闭上一次运行中的进程
killServer

echo "启动项目开始"
nohup java -jar ${BACKUP_PATH}/${PROJECT_NAME}-${PROJECT_VERSION}.jar >  /dev/null &
echo "启动项目结束"