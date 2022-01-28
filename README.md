# pizilla - save and restore pi sd cards
pizilla provides two simple shell scrips running on linux.  
Unlike Clonezilla, pizilla can simply run on any linux system with enough space to hold the created backups.  
Like with Clonezilla, the created images are relatively small. partclone writes only used blocka and the result will be further compressed with gzip.
## Dependencies
- root privileges
- partclone
- sfdisk
- gzip
## Installation
You can put the script files in /usr/local/sbin or any other directory you want. 
## Usage
Inserrt the card to be saved or restored in a card reader on your system.
### backupCard.sh device directory
- device - the device to save. Supported are devices /dev/sdX and /dev/mmcblkX
- directory  
  will be created to store the backup
### restoreCard.sh device directory
- device - the device to be restored
- the directory containing the backup
## Caveats
The scripts can **destroy data** by design. Please be careful! We cannot be held reliable for any damage or data loss caused b the provided scipts.

**partclone version**: The procedures require partclone version > v0.3 (check with partclone.restore -v). Versions v0.2.x won't work.

It can be a good idea to **shrink the root partition** to make it fit to a card with smaller size before performing the backup (actual size of e.g. a 32G card can vary by manufacturer). It's not a good idea to bypass size checking with partclone -C when restoring the card. This will probably not work. Shrinking can easily be done with gparted. However, this comes with a **pitfall**: gparted changes the PARTUUID without notice and unfortunately the Pi system refers to the PARTUUID in both /boot/cmdline.txt and /etc/fstab. Either you change the the PARTUUID in the these files to the new value or you change the PARTUUID of the card to the old value, Changing the PARTUUID can be done with fdisk (expert functions:x rename:i). This has to be done before performing the backup. 
