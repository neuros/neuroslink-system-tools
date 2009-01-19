#!/bin/bash

### Determine if Firefox is running and ask for confirmation
if ps ax | grep -v grep | grep firefox > /dev/null
then
  ### Firefox is running - prompt then kill Firefox
  zenity --question --title="Firefox is running!" --text="To allow the system to fully update the system may need to close Firefox automatically. Are you ready to Contine?"
  CONFIRMFIREFOXCLOSE=$?
  if [ "$CONFIRMFIREFOXCLOSE" = "0" ]; then

  zenity --warning --title="Upgrading System" --text="System will now upgrade. Please do not shut down or remove power from the system until after the upgrade window has completely closed.\n\nThere is a possibility that the upgrade window will prompt you with questions regarding the upgrade.  In most cases it is safe to simply answer Y to these questions, then the upgrade can continue."

  /usr/bin/aptitude update
  /usr/bin/aptitude full-upgrade --allow-untrusted -y
  /usr/bin/aptitude autoclean
  /usr/bin/aptitude clean
  sync

  else
    ### User canceled - stop script
    echo "Aborting"
    exit 0;
  fi
fi


