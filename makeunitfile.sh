#!/bin/bash

if [ $# -eq 0 ]; then
  TARGET_DIR=$(cd $(dirname $0); pwd)
else
  TARGET_DIR=$(realpath $1)
fi
CMD=$(basename -z $TARGET_DIR | sed 's/\x0//g')
UNITFILE=${TARGET_DIR}/${CMD}.service

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
  WorkingDirectory=${TARGET_DIR}
  ExecStart=${TARGET_DIR}/${CMD}
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
if [ -e ${TARGET_DIR}/replaceoptions.sh ]; then
  source ${TARGET_DIR}/replaceoptions.sh
fi

# write sections
write_unit
if [ -e ${TARGET_DIR}/add_to_unit_section.sh ]; then
  ${TARGET_DIR}/add_to_unit_section.sh >> $UNITFILE
fi
write_service
if [ -e ${TARGET_DIR}/add_to_service_section.sh ]; then
  ${TARGET_DIR}/add_to_service_section.sh >> $UNITFILE
fi
write_install
if [ -e ${TARGET_DIR}/add_to_install_section.sh ]; then
  ${TARGET_DIR}/set_default_install.sh >> $UNITFILE
fi
