#!/bin/bash

zenity --warning --title="Upgrading System" --text="System will now upgrade. Please do not shut down or remove power from the system until after the upgrade window has completely closed.\n\nThere is a possibility that the upgrade window will prompt you with questions regarding the upgrade.  In most cases it is safe to simply answer Y to these questions, then the upgrade can continue."

/usr/bin/aptitude update
/usr/bin/aptitude full-upgrade --allow-untrusted -y
/usr/bin/aptitude autoclean
/usr/bin/aptitude clean
sync
