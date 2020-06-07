#!/bin/bash

TOMCAT=/opt/tomcat

echo -e "backing up existing deployment\n"
if [ -d "$TOMCAT/webapps/java-hello-world" ]; then
	backup_dir=backup_$(date +%m-%d-%Y)
	if [ -d $backup_dir ]; then
		rm -rf $backup_dir
	fi
	mkdir $backup_dir
	mv $TOMCAT/webapps/java-hello-world* $backup_dir
fi
echo -e "stop tomcat service\n"
sh /opt/tomcat/bin/shutdown.sh

echo -e "untar webapps\n"
unzip scripting.zip
# I am deploying a "Hello World" file
echo -e "deploying web application\n"
cp /home/ec2-user/target/java-hello-world.war /opt/tomcat/webapps/

echo -e "start tomcat service"
sudo sh /opt/tomcat/bin/startup.sh

echo -e "Cleanup workspace"
rm -rf target
