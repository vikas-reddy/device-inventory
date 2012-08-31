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

dbname="device_inventory"
dbuser="epocrates"
dbpasswd="epocrates123"
dump_name="device-inventory-$(date +'%Y-%m-%d-%H%M').xz"
save_path="${HOME}/DeviceInventory/db-dumps"

dump_path="${save_path}/${dump_name}"

# Dump
mysqldump -u "${dbuser}" -p"${dbpasswd}" \
    "${dbname}" | xz > "${dump_path}";
