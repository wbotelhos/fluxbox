#!/bin/bash

##################
# --- Common --- #
##################

GRAY='\033[0;36m'
GREEN='\033[0;32m'
NO_COLOR='\033[1;0m'
YELLOW='\033[1;33m'

if [ $UID != 0 ]; then
  echo -e "${YELLOW}You need to be root!${NO_COLOR}\n"
  exit 1
fi

##########################
# --- Configurations --- #
##########################

JOB_NAME='Fluxbox#install'
FLUXBOX_PATH=~/.fluxbox

########################
# --- Dependencies --- #
########################

sudo apt-get -f install           -qq -y
sudo apt-get install xscreensaver -qq -y

#####################
# --- Functions --- #
#####################

end() {
  echo -e "${GREEN}Done!${NO_COLOR}"
  echo -e "-------------------------------------\n"
}

begin() {
  echo -e "-------------------------------------"
  echo -e "${GRAY}Starting ${JOB_NAME}...${NO_COLOR}\n"
}

clean() {
  sudo apt-get remove gnome-screensaver
  sudo apt-get purge gnome-screensaver
  sudo killall gnome-screensaver
}

install() {
  # clean
  rm -rf $FLUXBOX_PATH

  # compile
  sudo apt-get install fluxbox -qq -y

  # copy examples
  cp -r ./files $FLUXBOX_PATH

  # check version
  version `fluxbox --version | cut -d ' ' -f 2`
}

version() {
  echo -e "${YELLOW}Version now:${NO_COLOR} ${1}\n"
}

###################
# --- Install --- #
###################

begin

clean
install

end
