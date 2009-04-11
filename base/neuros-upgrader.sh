#!/bin/bash

/usr/bin/aptitude update
/usr/bin/aptitude full-upgrade --allow-untrusted -y
/usr/sbin/cleanup-version.sh
/usr/bin/aptitude autoclean
/usr/bin/aptitude clean
sync

