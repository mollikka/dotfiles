#!/bin/sh
set -euf -o pipefail

#get a new mirrorlist
curl https://www.archlinux.org/mirrorlist/all/ > /tmp/mirrors

#activate the mirrors I like
countries="Belgium Finland Germany Iceland Denmark Sweden Norway Latvia Lithuania Poland"
for a in $countries; do
  sed -i "/$a/,/^\s*$/s/^#Server/Server/" /tmp/mirrors
done

#use 15 best mirrors
rankmirrors -n 15 /tmp/mirrors > /tmp/mirrors_ranked

#remove rejected from file
sed -i '/^#/d' /tmp/mirrors_ranked

#ask for permission to update mirrorlist
cat /tmp/mirrors_ranked
read -p "Use this list?" yn
case $yn in
  [Yy]* ) :;;
  [Nn]* ) exit;;
  * ) echo "Please answer yes or no.";;
esac

#end do the update!
sudo cp /tmp/mirrors_ranked /etc/pacman.d/mirrorlist

