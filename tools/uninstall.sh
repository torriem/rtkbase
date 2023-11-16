#!/bin/bash

BASEDIR=$(dirname "$0")

#removing services
for service_name in str2str_tcp.service \
                    str2str_ntrip_A.service \
                    str2str_ntrip_B.service \
                    str2str_local_ntrip_caster \
                    str2str_rtcm_svr.service \
                    str2str_rtcm_serial.service \
                    str2str_file.service \
                    rtkbase_web \
                    rtkbase_archive.service \
                    rtkbase_archive.timer \
                    modem_public_ip.service \
                    modem_public_ip.timer
do
    echo 'Deleting ' "${service_name}"
    systemctl stop "${service_name}"
    systemctl disable "${service_name}"
    rm /etc/systemd/system/"${service_name}"
    rm /usr/lib/systemd/system/"${service_name}" 
    systemctl daemon-reload
    systemctl reset-failed
done

#removing rtklib binaries
echo 'Deleting RTKLib binaries'
rm /usr/bin/str2str
rm /usr/bin/conv2bin
rm /usr/bin/rtkrcv

#removing Python modules
# Too dangerous without running RTKBase in a venv ?

#removing rtkbase folder
echo 'Deleting rtkbase directory'
rtkbase_dir=$(builtin cd "${BASEDIR}"/.. ; pwd)
echo 'Deleting ' "${rtkbase_dir}"
read -p 'Are you sure ? (yes or no) : ' useranswer
if [[ $useranswer == 'yes' ]]
then
 echo 'Deleting ' "${rtkbase_dir}"
 rm -rf "${rtkbase_dir}"
fi
echo '====================='
echo 'RTKBase uninstalled!'
echo 'I hope you enjoyed it'
