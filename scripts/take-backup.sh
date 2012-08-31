#!/bin/bash
#
#    Vikas Reddy <vikas.r@imaginea.com>
#
# Take mysql dumps of the device-inventory database and save
# it somewhere on the disk. Also, copy it over to my desktop
# machine.
#
# Dumps are compressed with XZ. Run `xz -d file.xz` to 
# decompress.
#
# To be run at 0010 hrs daily, from crontab
#
#

# Database credentials
dbname="device_inventory"
dbuser="epocrates"
dbpasswd="epocrates123"

# FTP credentials
ftphost="ftp.xxxxxxx.xxx"
ftpuser="xxxxxxxxx"
ftppasswd="xxxxxxxxxxxx"
ftpbasedir="DeviceInventory/db-dumps"

# Local file path
dump_name="device-inventory-$(date +'%Y-%m-%d-%H%M').sql.xz"
save_path="${HOME}/DeviceInventory/db-dumps"
dump_path="${save_path}/${dump_name}"

# MySQL dump
# -p$dbpasswd if $dbpasswd?
mysqldump \
    -u "${dbuser}" \
    $( [[ -n "${dbpasswd}" ]] && echo "-p${dbpasswd}" ) \
    "${dbname}" | xz > "${dump_path}";

if [[ $? -eq 0 ]]; then

    # Upload to FTP
    lftp \
        -e "cd ${ftpbasedir} && put '${dump_name}' && exit" \
        -u "${ftpuser}","${ftppasswd}" \
        "${ftphost}" \
        1>&2 2> /dev/null; # No output and errors, please!

fi
