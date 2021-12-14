## Restore card partclone image to card
# Usage: write_card_mmc backup_dir

################################################################################
# Check if root

if [ ! `id -u` -eq 0 ]
then
  echo You must run as root. Exiting.
  exit
fi

if [ "$#" -ne 2 ] || ! [ -d "$2" ]; then
  echo "Usage: $0 DEVICE DIRECTORY" >&2
  exit 1
fi

if [ ! -b $1 ]
then
  echo "Device $1 does not exist. Exit."
  exit 1
fi
echo "Creating partition table in $1"

read -p "All data in $1 will be destroyed. Proceed? (N/y): " -e -i "n"  START
  if [ $START = "y" -o $START = "Y" ]
  then
    echo Creating partition table  
  else
    echo Cancelled.
    exit 1
  fi

# create partition table
sfdisk $1 < ${2}/${2}.pt

# Restore partitions
if [ `expr substr $1 6 6` == "mmcblk" ]
then
  base=`expr substr $1 1 12`p
elif [ `expr substr $1 6 2` == "sd" ]	
then
  base=`expr substr $1 1 8`	
fi
gzip -d -c ${2}/${2}.boot.gz | partclone.restore -N -o ${base}1 -s -
gzip -d -c ${2}/${2}.rootfs.gz | partclone.restore -N -o ${base}2 -s -
