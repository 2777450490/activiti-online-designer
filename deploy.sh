#!/usr/bin/env bash

#export BUILD_ID=dontKillMe这一句很重要，这样指定了，项目启动之后才不会被Jenkins杀掉。
#export BUILD_ID=DONTKILLME
#加载配置参数
#. /etc/profile
#projectPath是jenkins工作目录
#export PROJECT_PATH=`pwd`
#cd ${PROJECT_PATH}/activiti-online-designer/
#export NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
#echo ${NAME}
#export VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
#echo ${VERSION}

## PROJECT_PATH  是Jenkins工作目录
## NAME Jar名称
## VERSION Jar版本

#指定最后编译好的jar存放的位置
WWW_PATH=/home/jars

#Jenkins中编译好的jar位置
JAR_PATH=${PROJECT_PATH}/target/

#获取运行编译好的进程ID，便于我们在重新部署项目的时候先杀掉以前的进程
PID=$(cat /home/pidfiles/activiti.pid)

#输出pid
echo ${PID}

#进入指定的编译好的jar的位置
cd ${JAR_PATH}

#将编译好的jar复制到最后指定的位置
cp ${JAR_PATH}/${NAME}-${VERSION}.jar ${WWW_PATH}

#进入最后指定存放jar的位置
cd ${WWW_PATH}

#杀掉以前可能启动的项目进程
kill -9 ${PID}

#启动jar，指定SpringBoot的profiles为test,后台启动
#java -jar -Dspring.profiles.active=test ${jar_name} &
java -jar ${NAME}-${VERSION}.jar &

#将进程ID存入到activiti.pid文件中
echo $! > /home/pidfiles/activiti.pid