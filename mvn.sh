#!/usr/bin/env bash
#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

killSpringBootServer(){
    pid=`ps -ef|grep "java -jar activiti-demo-*-SNAPSHOT.jar"|grep -v grep|awk '{print $2}'`
    echo "jar Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no jar pid alive"
    else
      kill -9 $pid
    fi
}
cd $PROJ_PATH/activiti-online-designer
clean install -Dmaven.test.skip=true -Ptest

killSpringBootServer

#cd $PROJ_PATH/activiti-online-designer/target/
#jar_path=find . -name "activiti-demo-*-SNAPSHOT.jar"
#java -jar $jar_path --server.port=9999