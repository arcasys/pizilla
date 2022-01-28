## Backup Raspberry Pi sd card to partclone image ##############################
#  Assumes a vfat and an ext4 partition
#  Supports devices /dev/mmcblk* and /dev/sd* 
################################################################################

# Check if root

if [ ! `id -u` -eq 0 ]
then
  echo You must run as root. Exiting.
  exit
fi

if [ "$#" -ne 2 ]
then
  echo "Usage: $0 DEVICE DIRECTORY" >&2
  exit 1
fi

if [ ! -b $1 ]
then
  echo "Device $1 does not exist. Exit."
  exit 1
fi

# Create backup dir
mkdir -p $2
if [ `ls $2 | wc -l` -gt 0 ]
then
  read -p "Directory $2 is not empty. Delete? (N/y): " -e -i "n" DELDIR
  if [ $DELDIR = "y" -o $DELDIR = "Y" ]
  then
    rm ${2}/*
  else
    echo Cancelled.
    exit 1
  fi
fi

# Create backup
# Save partition table
sfdisk $1 -d > ${2}/${2}.pt

# Save partitions
if [ `expr substr $1 6 6` == "mmcblk" ]
then
  base=`expr substr $1 1 12`p
elif [ `expr substr $1 6 2` == "sd" ]
then
  base=`expr substr $1 1 8`
fi

partclone.vfat -c -N -x gzip -s ${base}1 -o ${2}/${2}.boot.gz
partclone.ext4 -c -N -x gzip -s ${base}2 -o ${2}/${2}.rootfs.gz

