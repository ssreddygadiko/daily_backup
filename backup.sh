#!/bin/sh
arn=arn:aws:sns:ap-south-1:120812721878:sai_test
backup_files="/var/www/html/index.nginx-debian.html"
dest="/opt/backup"
day=$(date +%A-%Y-%m-%d_%H-%M);
host=$(hostname -s)
archive_file="$host-$day.zip"
#tar czf $dest/$archive_file $backup_files
zip -r $dest/$archive_file $backup_files
msg=`ls -lh $dest | grep $day | awk '{print $9}'`
file=$dest/$archive_file

if [ ! -f "$file"  ]; then
	aws sns publish --topic-arn $arn --message "crimson cloud backup process has been failed"
else
	aws sns publish --topic-arn $arn --message "crimson cloud $msg backup has been success"

exit 1
fi

