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
