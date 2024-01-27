#!/bin/bash
# CRSH1TTY BUILD 1 / BETA #1

# patch notes:
# - none, check back next build (few days / hours)

force=true

if grep -q "warning: script from noexec mount" "$0"; then
    echo "ignore that warning ^"
fi

read -p "do you want to clear the console each time it tries a code? (y/n): " answer && { [ "$answer" == "y" ] && fast=1 || fast=2; }

generate_code() {
  characters="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  code_length=8

  ac=""
  for ((j=0; j<code_length; j++)); do
    ac+=${characters:$((RANDOM%${#characters})):1}
  done
}

main() {
  while $force; do
    generate_code
    if [ "$fast" != "2" ]; then
      clear
      echo "CRSH1TTY Public Beta #1 - build 1" # just gonna list this as build 1, all subsequent releases will be built off of this haha
    fi
    echo "Trying the code $ac"
    gsctool -t -r "$ac"
    if [ $? -eq 0 ]; then
      force=false
      echo "Correct code is $ac"
      sleep 1
      read -p "Write down your auth code or take a picture and press enter to continue"
      sleep 2
      echo "Let's check if write protection is actually off"
      sleep 3
      crossystem wpsw_cur # more convenient than flashrom, i swear!!!
      sleep 3
      echo "DM @crossystem about this on Discord and send her the picture"
      break
    fi
  done
}

main # this is good for public release, right?