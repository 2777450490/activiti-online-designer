#!/usr/bin/env bash

cd ${PROJ_PATH}/activiti-online-designer/target
BUILD_ID=dontKillMe nohup java -jar activiti-demo.jar --server.port=80 &
