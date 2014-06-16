#!/bin/bash

## Hier kommen die Fotos hin
localdir = /var/foto/

## Das ist der remotepfad fuer das Foto fuer die webseite
remotedir = html/foto

## Hier wird das Archiv angelegt
remarchdir = archiv/

## Hier kommen die Configs für ncftpput etc. rein
configpath = /path/foo/bar/

fswebcam -r 960x720 -d /dev/video0 ${localdir}webcam.jpg
ncftpput -f ${configpath}ftp.cfg $remotedir ${localdir}webcam.jpg

datum = $(date +%-Y_%-m_%-d)
timestamp = ${date +"%s"}
mv ${localdir}webcam.jpg ${localdir}${timestamp}.jpg
ncftpput -f ${configpath}ftp.cfg -m ${remarchdir}${datum} ${localdir}${timestamp}.jpg
rm -rf ${localdir}${timestamp}.jpg
