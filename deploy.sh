#!/bin/bash

TOMCAT=/opt/tomcat

echo -e "backing up existing deployment\n"
if [ -d "$TOMCAT/webapps/java-hello-world" ]; then
	mkdir backup
	mv $TOMCAT/webapps/java-hello-world* backup
fi
echo -e "stop tomcat service\n"
sh /opt/tomcat/bin/shutdown.sh

echo -e "untar webapps\n"
unzip scripting.zip

echo -e "deploying web application\n"
cp /home/ec2-user/target/java-hello-world.war /opt/tomcat/webapps/

echo -e "start tomcat service"
sh /opt/tomcat/bin/startup.sh

echo -e "Cleanup workspace"
rm -rf target