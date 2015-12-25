# KCIFS
Keep CIFS shares mounted + Auto-Recovery

## Usage
1. Copy the kcifs.bash script somewhere
2. Edit user= to what user should touch the files
3. Edit data= to where the temp file and monitor list should be
4. [OPTIONAL] Put the full path names of mount points you want to monitor (that are in fstab), YOU DO NOT HAVE TO DO THIS it will automaticly create this file when you run it the first time.
5. Create a cron job for every minute, command: bash <path to script>/kcifs.bash, run as: root (for mount rights, unless you have them)

## Testing
1. Run it manualy to make you get "[OK]"
2. umount a mount points
3. Run again and make sure under disconnected you get "[ OK - OK ]"

## Help
### Connected mount point says [FAIL]
This means that it could not see the touched file, check permissions
### Disconnected mount point says...
#### [ OK -FAIL]
The file no longer - File is not there: Did not mount, do it manualy to see whats wrong
#### [FAIL- OK ]
File is stil there - File is still there: Something wrong, check it
#### [FAIL-FAIL]
File did not delete - File is not there: somethings wrong, check it