#!/bin/bash

## Please edit the example paths. Pay attention to leading and trainling slashes.
## Do not use a configuration file for fswebcam. Edit the command line instead.

## directory for the photos
localdir = /var/foto/

## remote path, where the taken photo is stored
remotedir = html/foto

## the root directory of your archive on remote machine
remarchdir = archiv/

## ncftp configuration file
ftpcfg = /absolute/path/to/ftp.cfg

## taking the photo
fswebcam -r 960x720 -d /dev/video0 ${localdir}webcam.jpg 1>/dev/null

## uploading the file via FTP and attending to create the remote dir if it does not exist
ncftpput -f $ftpcfg -m $remotedir ${localdir}webcam.jpg 1>/dev/null

## generating date
datum = $(date +%-Y_%-m_%-d)

## generating unix timestamp
timestamp = ${date +"%s"}

## renaming the photo file
mv ${localdir}webcam.jpg ${localdir}${timestamp}.jpg

## uploading the renamed file to a directory named after the current date and trying to create if it does not exist
ncftpput -f ${configpath}ftp.cfg -m ${remarchdir}${datum} ${localdir}${timestamp}.jpg 1>/dev/null

## cleaning up
rm -rf ${localdir}${timestamp}.jpg

echo "Done: $datum $(date +"%T")"
