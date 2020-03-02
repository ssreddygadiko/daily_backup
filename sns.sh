#!/bin/bash
echo "Enter Topic name :"
read topic_name
echo "Enter email id :"
read email
arn=`aws sns create-topic --name $topic_name | awk '{gsub(/\"|\;/,"")}{print $2}'`
aws sns subscribe --topic-arn $arn --protocol email --notification-endpoint $email
#aws sns publish --topic-arn $arn --message "Hi Friends!"


