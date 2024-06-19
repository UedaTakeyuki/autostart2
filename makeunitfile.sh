#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CMD=$(basename -z $SCRIPT_DIR | sed 's/\x0//g')
UNITFILE=${SCRIPT_DIR}/${CMD}.service

# default [Unit] section
set_default_unit(){
  Description="Get temp, humid, and humiditydeficit data \& Post to the monitor"
  After=rc-local.service
}
write_default_unit(){
  echo [Unit] > $UNITFILE
  echo Description=${Description} >> $UNITFILE
  echo After=${After} >> $UNITFILE
  echo >> $UNITFILE
}

# default [Service] section
default_service(){
  echo [Service] >> $UNITFILE
  echo WorkingDirectory=${SCRIPT_DIR} >> $UNITFILE
  echo ExecStart=${SCRIPT_DIR}/${CMD} >> $UNITFILE
  echo Restart=always >> $UNITFILE
  echo RestartSec=30 >> $UNITFILE
  echo Type=simple >> $UNITFILE
  echo PIDFile=/var/run/${CMD}.pid >> $UNITFILE
  echo >> $UNITFILE
}


set_default_unit

# replace default
if [ -e replaceunit.sh ]; then
  source replaceunit.sh
fi

# [Unit] section
write_default_unit

# [Service] section
default_service

# [Install] section
echo [Install] >> $UNITFILE
echo WantedBy=multi-user.target >> $UNITFILE

