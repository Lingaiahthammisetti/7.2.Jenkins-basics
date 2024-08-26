#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo  -e "$G Script started executing at:$TIMESTAMP $N"

VALIDATE(){
if [ $1 -ne 0 ]
then 
   echo -e "$R $2... FAITURE $N"
   exit 1
else
   echo -e "$G $2..  SUCCESS $N"
fi
}
#checking root user or not.
if [ $USERID -ne 0 ]
then
   echo -e "$R Please run this script with root access $N"
   exit 1
else
   echo -e "$G You are super user. $SCRIPT_NAME"

fi

yum update -y &>>$LOGFILE
VALIDATE $? "Updating yum packages"

curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOGFILE
VALIDATE $? "Add the LTS Jenkins repository"

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOGFILE
VALIDATE $? "Import the repo key"

yum upgrade -y &>>$LOGFILE
VALIDATE $? "Upgrading yum packages"

sudo yum install fontconfig java-17-openjdk -y &>>$LOGFILE
VALIDATE $? "Add required dependencies - Installing Java 17 openjdk"

yum install jenkins -y &>>$LOGFILE
VALIDATE $? "Add required dependencies - Installing Jenkins"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Jenkins - Daemon reload"

systemctl enable jenkins &>>$LOGFILE
VALIDATE $? "Enabling jenkins"

systemctl start jenkins &>>$LOGFILE
VALIDATE $? "Starting jenkins"

systemctl status jenkins &>>$LOGFILE
VALIDATE $? "Checking Jenkins installation Status"
