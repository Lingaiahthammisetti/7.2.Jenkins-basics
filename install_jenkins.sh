#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
       echo "$2...FAILURE"
       exit 1
    else
       echo "$2.. SUCCESS"
    fi    
}
#check whether root user or not.
if [ $USERID -ne 0 ]
then 
   echo "please run this script with root access."
   exit 1 #manaully exit if error comes.
else
   echo "you are super user."
fi


yum update -y &>>$LOGFILE
VALIDATE $? "Updating yum packages"

yum install fontconfig java-17-openjdk -y &>>$LOGFILE
VALIDATE $? "Installing java-17"

# sudo wget -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOGFILE
# VALIDATE $? "downloading jenkins repository"

curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOGFILE
VALIDATE $? "downloading jenkins repository"

yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo &>>$LOGFILE
VALIDATE $? "adding Docker repo"

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOGFILE
VALIDATE $? "Importing jenkins key"

yum install jenkins -y &>>$LOGFILE
VALIDATE $? "Installing Jenkins"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Jenkins - Daemon reload"

systemctl enable jenkins &>>$LOGFILE
VALIDATE $? "Enabling jenkins"

systemctl start jenkins &>>$LOGFILE
VALIDATE $? "Starting jenkins"





