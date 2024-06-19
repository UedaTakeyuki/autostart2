#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CMD=$(basename -z $SCRIPT_DIR | sed 's/\x0//g')
UNITFILE=${SCRIPT_DIR}/${CMD}.service

# default [Unit] section
set_default_unit(){
  Description="Simple Unit file for "${CMD}"."
  After=rc-local.service
}
write_unit(){
  echo [Unit] > $UNITFILE
  echo Description=${Description} >> $UNITFILE
  echo After=${After} >> $UNITFILE
  echo >> $UNITFILE
}

# default [Service] section
set_default_service(){
  WorkingDirectory=${SCRIPT_DIR}
  ExecStart=${SCRIPT_DIR}/${CMD}
  Restart=always
  RestartSec=30
  Type=simple
  PIDFile=/var/run/${CMD}.pid
}
write_service(){
  echo [Service] >> $UNITFILE
  echo WorkingDirectory=${WorkingDirectory} >> $UNITFILE
  echo ExecStart=${ExecStart} >> $UNITFILE
  echo Restart=${Restart} >> $UNITFILE
  echo RestartSec=${RestartSec} >> $UNITFILE
  echo Type=${Type} >> $UNITFILE
  echo PIDFile=${PIDFile} >> $UNITFILE
  echo >> $UNITFILE
}

# default [Install] section
set_default_install(){
  WantedBy=multi-user.target
}
write_install(){
  echo [Install] >> $UNITFILE
  echo WantedBy=${WantedBy} >> $UNITFILE
}

# set defaults
set_default_unit
set_default_service
set_default_install

# replace default
if [ -e replaceunit.sh ]; then
  source replaceunit.sh
fi

# write sections
write_unit
write_service
write_install