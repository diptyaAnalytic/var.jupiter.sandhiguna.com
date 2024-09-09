Content-Type: multipart/mixed; boundary="===============9082803396151227987=="
MIME-Version: 1.0
Number-Attachments: 6

--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/cloud-config; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config"

#cloud-config
system_info:
    default_user:
    distro: fedora
    paths:
        cloud_dir: /var/lib/cloud
        templates_dir: /etc/cloud/templates
    ssh_svcname: sshd

ssh_pwauth: false
disable_root: false
manage_etc_hosts: true

network:
    config: disabled


--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/cloud-boothook; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="resolver-fix"

#!/bin/sh -x
# DigitalOcean resolver fixup script
[ -f /etc/systemd/resolved.conf ] || exit 0
logger -t DigitalOcean 'writing resolvers  to /etc/systemd/resolved.conf.d/DigitalOcean.conf'
mkdir -p /etc/systemd/resolved.conf.d
printf "[Resolve]\nDNS=67.207.67.2 67.207.67.3\n" > /etc/systemd/resolved.conf.d/DigitalOcean.conf
systemctl try-reload-or-restart systemd-resolved


--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/cloud-boothook; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="entropy-seed"

#!/bin/sh -x
# DigitalOcean Entropy Seed script
logger -t DigitalOcean 'adding random seed to /dev/urandom'
(base64 -d <<EOE
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

EOE
) > /dev/urandom 


--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/cloud-boothook; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="digitalocean_fixups"

#!/bin/sh

# These are udev rules and scripts that are placed here for the sake of readability 
# later in this script.
no_systemd_mount_rules=$(cat <<'EOM'
# Only try to automount DO block volumes.
SUBSYSTEM!="block", GOTO="do_automount_end"
ENV{ID_VENDOR}!="DO", GOTO="do_automount_end"
ENV{ID_MODEL}!="Volume", GOTO="do_automount_end"
# Only automount on the "add" action.
ACTION!="add", GOTO="do_automount_end"
# Only try to automount filesystems we know about.
ENV{ID_FS_TYPE}!="ext4|xfs", GOTO="do_automount_end"

# Create a temporary mountpoint and temporary location for the first-mount script.
IMPORT{program}="/bin/sh -c 'echo TMP_MOUNT_DIR=$(mktemp -d -p /mnt .do-first-mount-XXXXXXXXX)'"
# Handle temporary mountpoint creation failure.
ENV{TMP_MOUNT_DIR}=="", GOTO="do_automount_end"
IMPORT{program}="/bin/sh -c 'echo TMP_SCRIPT=$(mktemp -t .do-first-mount-XXXXXXXXX.sh)'"
# Handle temporary script location creation failure.
ENV{TMP_SCRIPT}=="", PROGRAM="/bin/sh -c '/bin/rmdir %E{TMP_MOUNT_DIR} || exit 0'", GOTO="do_automount_end"

# Mount the volume at the temp mountpoint and copy the script off, then unmount.
RUN{program}+="/bin/mount -o ro /dev/%k %E{TMP_MOUNT_DIR}"
RUN{program}+="/bin/sh -c '/bin/cp %E{TMP_MOUNT_DIR}/.first-mount.sh %E{TMP_SCRIPT} || exit 0'"
RUN{program}+="/bin/umount %E{TMP_MOUNT_DIR}"
RUN{program}+="/bin/rmdir %E{TMP_MOUNT_DIR}"

# Run the first-mount script. If it didn't exist this will be a no-op.
RUN{program}+="/bin/sh %E{TMP_SCRIPT} '%E{ID_SERIAL}' '%E{ID_FS_TYPE}' '%E{ID_SERIAL_SHORT}' '%E{ID_FS_UUID}' '%E{ID_FS_LABEL}'"

# Clean up.
RUN{program}+="/bin/rm %E{TMP_SCRIPT}"

# Finally, try and mount the volume. On first mount this will fail, but that's
# OK because the volume was already mounted by the first-mount script.
RUN{program}+="/bin/sh -c '/bin/mount /dev/%k || exit 0'"

LABEL="do_automount_end"
EOM
)

systemd_mount_rules=$(cat <<'EOM'
# Only try to automount DO block volumes.
SUBSYSTEM!="block", GOTO="do_automount_end"
ENV{ID_VENDOR}!="DO", GOTO="do_automount_end"
ENV{ID_MODEL}!="Volume", GOTO="do_automount_end"

# Only automount on "add" or "change" actions.
ACTION!="add|change", GOTO="do_automount_end"
# Only try to automount filesystems we know about.
ENV{ID_FS_TYPE}!="ext4|xfs", GOTO="do_automount_end"

# Create a temporary location for the first-mount script.
IMPORT{program}="/bin/sh -c 'echo TMP_SCRIPT=$$(mktemp -t .do-first-mount-XXXXXXXXX.sh)'"
# Handle temporary script location creation failure.
ENV{TMP_SCRIPT}=="", GOTO="do_automount_end"

RUN{program}+="/var/lib/cloud/scripts/per-instance/systemd_automount.sh %k %E{TMP_SCRIPT} '%E{ID_SERIAL}' '%E{ID_FS_TYPE}' '%E{ID_SERIAL_SHORT}' '%E{ID_FS_UUID}' '%E{ID_FS_LABEL}'"

LABEL="do_automount_end"
EOM
)

systemd_mount_script=$(cat <<'EOM'
#!/bin/bash

DEVICE=$1
TMP_SCRIPT=$2
ID_SERIAL=$3
ID_FS_TYPE=$4
ID_SERIAL_SHORT=$5
ID_FS_UUID=$6
ID_FS_LABEL=$7

function cleanup() {
   if [ -f "${TMP_SCRIPT}" ]; then
      rm -f "${TMP_SCRIPT}"
   fi
}

trap cleanup EXIT

# If device is blank or unset exit. Can happen on first start
if [ -z "$DEVICE" ]; then
    exit 0
fi

devpath="/dev/${DEVICE}"

# New first-mount approach
magic_size=14
size=$(( 512 * $(cat /sys/block/${DEVICE}/size) ))
offset=$(( ${size} - ${magic_size} ))
magic=$(dd if="${devpath}" bs=${magic_size} count=1 skip=${offset} iflag=skip_bytes 2>/dev/null | tr -d '\000')

if [ "${magic}" == "DO_FIRST_MOUNT" ]; then
   logger -t digitalocean-automount "detected first mount magic"

   # Clear magic so this script won't trigger again
   dd if=/dev/zero of="${devpath}" bs=${magic_size} count=1 seek=${offset} oflag=seek_bytes 2>/dev/null

   # First mount trailer format:
   # <script body>
   # <metadata>
   # <script size - 7 bytes>
   # <metadata size - 6 bytes>
   # DO_FIRST_MOUNT
   # <end-of-disk>

   # Metadata is a list of key=value pairs separated by ';'
   # Available metadata keys:
   # fs=<string>      - filesystem type [required]
   # md5=<string>     - script md5 schecksum
   
   md_header_size=6
   script_header_size=7
   
   # DO_FIRST_MOUNT (14 bytes)
   offset=$(( ${size} - ${magic_size} - ${md_header_size} ))
   
   # Metadata size (6 bytes)
   md_size=$(dd if="${devpath}" bs=${md_header_size} count=1 skip=${offset} iflag=skip_bytes 2>/dev/null | tr -d '\000')
   offset=$((${offset} - ${script_header_size}))
   
   # Script size (7 bytes)
   script_size=$(dd if="${devpath}" bs=${script_header_size} count=1 skip=${offset} iflag=skip_bytes 2>/dev/null | tr -d '\000')
   offset=$((${offset} - ${md_size}))
   
   # Metadata
   md=$(dd if="${devpath}" bs="${md_size}" count=1 skip=${offset} iflag=skip_bytes 2>/dev/null | tr -d '\000')
   offset=$((${offset} - ${script_size}))
   
   # Script
   script=$(dd if="${devpath}" bs="${script_size}" count=1 skip=${offset} iflag=skip_bytes 2>/dev/null | tr -d '\000')
   
   # Parse metadata
   md_fs=""
   md_md5=""
   
   IFS=';' read -ra MD <<< "${md}"
   for i in "${MD[@]}"; do
      key=$(echo "${i}" | cut -f1 -d'=')
      value=$(echo "${i}" | cut -f2 -d'=')
   
      case ${key} in
         fs)
            md_fs=$value
            ;;
         md5)
            md_md5=$value
            ;;
         *)
            export "DO_FIRST_MOUNT_${key}=${value}"
      esac
   done
   
   if [ -z "${md_fs}" ]; then
      logger -t digitalocean-automount -p user.err "required metadata key not set: fs"
      exit 1
   fi
   
   # Verify script checksum if provided
   if [ -n "${md_md5}" ]; then
      script_md5=$(echo "${script}" | md5sum | cut -f1 -d" ")
   
      if [ "${script_md5}" != "${md_md5}" ]; then
         logger -t digitalocean-automount -p user.err "script checksum mismatch: ${script_md5} (actual) != ${md_md5} (expected)"
         exit 1;
      else
         logger -t digitalocean-automount "script checksum verified"
      fi
   fi
   
   # Copy script to a temporary location
   echo "${script}" > "${TMP_SCRIPT}"
   chmod 755 "${TMP_SCRIPT}"
   
   # Execute first mount script
   if [ $(command -v systemd-run) ]; then
      systemd-run -G --no-block --scope /bin/sh "${TMP_SCRIPT}" "${ID_SERIAL}" "${md_fs}" "${ID_SERIAL_SHORT}" "${ID_FS_UUID}" "${ID_FS_LABEL}"
   else
      /bin/sh "${TMP_SCRIPT}" "${ID_SERIAL}" "${md_fs}" "${ID_SERIAL_SHORT}" "${ID_FS_UUID}" "${ID_FS_LABEL}"
   fi
fi
EOM
)

# Disable the locale warning: by default imported cloud-images check the default
# local and give a warning about invalid locales. The following line disable
# the warning.

# do not assume that /etc/skel exists
if [ -d /etc/skel ]; then
    touch /etc/skel/.cloud-locale-test.skip
fi
touch /root/.cloud-locale-test.skip

# Disable Ubuntu MOTD
if [ -f /etc/default/motd-news ]; then
    sed -e "s/ENABLED=1/ENABLED=0/g" \
        -i /etc/default/motd-news
fi

# Fix buggy cloud-init routes for IPv6
r6c="/etc/sysconfig/network-scripts/route6-eth0"
if [ -f "${r6c}" ]; then
    sed -e "s|::/::|default|g" -i "${r6c}"
    awk '/default via/{system("ip -6 route add default via "$NF" dev eth0")}' "${r6c}"
elif [ -d "/etc/sysconfig/network-scripts" -a -f "/etc/network/interfaces" ]; then
    # This deals with a bug in Fedora 27 where the network interface is not set
    # properly by Cloud-init.
    i6gw=$(egrep -A3 'iface eth0:1 inet6 static' /etc/network/interfaces | awk '/gateway/{print$NF}')
    if [ -n "${i6gw}" ]; then
        ip -6 route add default via ${i6gw} dev eth0
        cat > ${r6c} <<EOM
# DigitalOcean: written by ConfigDrive customization.
default via ${i6gw}
EOM
    fi
fi

# Fix screwy file permmissions on the system resolvers.
chmod 0644 /etc/resolv.conf

# Support automatic disk resizing per boot.
# Only update /etc/hosts once per instance.
mkdir -p /etc/cloud/cloud.cfg.d
cat > /etc/cloud/cloud.cfg.d/90-digitalocean.cfg <<EOM
####
# DigitalOcean: this file was written via cloud-init and composed from /etc/cloud/cloud.cfg
#               In order to support resize events, 'growpart' and 'resizefs' are run each boot.
#               'update_etc_hosts' will be run only once per instance. To see the differences, run
#               'diff -u /etc/cloud/cloud.cfg /etc/cloud/cloud.cfg.d/90-digitalocean.cfg'.
#
#               This file was written to support Droplet $(</sys/devices/virtual/dmi/id/product_serial) on $(date +%Y-%m-%d)
####

EOM
sed -e "s/- growpart$/- [ growpart, always ]/g" \
    -e "s/- resizefs$/- [ resizefs, always ]/g" \
    -e "s/- update_etc_hosts$/- [ update_etc_hosts, once-per-instance ]/g" \
    /etc/cloud/cloud.cfg >> /etc/cloud/cloud.cfg.d/90-digitalocean.cfg

# Fix for machine-id's being dubiously present
cat > /var/lib/cloud/scripts/per-instance/machine_id.sh <<EOM
#!/bin/bash
CT=\$(date +%s);
FT=\$(stat /etc/machine-id -c %Y);
DIFF=\$(expr \$CT - \$FT)
# record timestamp on machine-id for testing
# If /etc/machine_id is over 10m old on first-boot, delete it
if [ -f /etc/machine-id ]; then
    if [ \$DIFF -lt 600 ]; then
        exit 0
    fi
rm -rf /etc/machine-id
fi

# systemd will use dbus uudigen if its there
# we need to reset this for Debain 9.
if which dbus-uuidgen &> /dev/null; then
    rm -rf /var/lib/dbus/machine-id
    dbus-uuidgen --ensure=/var/lib/dbus/machine-id
fi

if which systemd-machine-id-setup &> /dev/null; then
    rm -rf /etc/machine-id
    systemd-machine-id-setup
fi
EOM
chmod 0700 /var/lib/cloud/scripts/per-instance/machine_id.sh

# DigitalOcean updated the vendor-data to better support various distributions.
# This script makes it so older snapshots will work by restoring the default behavior
# of cloud-init.
if [ -e /etc/cloud/cloud.cfg.disabled ]; then
    mv /etc/cloud/cloud.cfg /etc/cloud/cloud.cfg.d/99-digitalocean.cfg
    mv /etc/cloud/cloud.cfg.disabled /etc/cloud/cloud.cfg
    logger -t DigitalOcean "restored default cloud-init behavior by renaming /etc/cloud/cloud.cfg.disabled to /etc/cloud/cloud.cfg"
fi

# Newer versions of systemd-udevd behave badly when trying to run the original udev rules.
# Using mount in udev is highly discouraged and behaves poorly when systemd-mount is available
# The script enforces serialization of commands without changing udev settings
# See BLOCK-1832
if [ -d /etc/udev/rules.d ]; then
    if command -v systemd-mount > /dev/null 2>&1 && command -v systemd-umount > /dev/null 2>&1; then
        # Add udev rules to automount block storage volumes using systemd-mount.
        /bin/echo "$systemd_mount_rules" > /etc/udev/rules.d/99-digitalocean-automount.rules
        /bin/echo "$systemd_mount_script" > /var/lib/cloud/scripts/per-instance/systemd_automount.sh
        chmod 0700 /var/lib/cloud/scripts/per-instance/systemd_automount.sh
    else
        # Add udev rules to automount block storage volumes.
        /bin/echo "$no_systemd_mount_rules" > /etc/udev/rules.d/99-digitalocean-automount.rules
    fi

    # Some versions of systemd-udevd end up in a weird state when we add and
    # trigger rules on-the-fly, as below. Restarting the service seems to
    # resolve things. See BLOCK-1435 for details.
    if command -v systemctl > /dev/null 2>&1; then
        systemctl restart systemd-udevd.service
    fi

    # Load the newly-added udev rules and then manually trigger them to catch
    # any automount volumes that were attached at boot.
    if command -v udevadm > /dev/null 2>&1; then
        udevadm control -R
        if command -v systemd-mount > /dev/null 2>&1 && command -v systemd-umount > /dev/null 2>&1; then
            udevadm trigger --action=change --subsystem-match=block
        else
            udevadm trigger --action=add --subsystem-match=block
        fi
    fi
fi


--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/x-shellscript; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="install-dotty-agent"

#!/bin/sh
#
# This is a wrapper that ensures that the agent is only installed _once_ automatically
# via cloud-init. Cloud-init 0.7.8 and earlier re-execute included URL's each boot.
# This script ensures that the agent is only ever installed once.

i_file=https://repos-droplet.digitalocean.com/install.sh
s_path="/var/lib/cloud/instance/sem"
s_file="${s_path}/dotty_agent"
download_timeout=20 # maximum allowed time for downloading the install script, in seconds

mkdir -p ${s_path}

test -f ${s_file} && exit 0

logger -t DOTTY-Agent "fetching and installing DOTTY agent"

if command -v wget &>/dev/null; then
  n=0
  until [ "$n" -ge 5 ]; do
    wget --timeout=${download_timeout} -O ${s_file} ${i_file} && break
    n=$((n + 1))
    sleep 2
  done
elif command -v curl &>/dev/null; then
  n=0
  until [ "$n" -ge 5 ]; do
    curl --max-time ${download_timeout} -SL --output ${s_file} ${i_file} && break
    n=$((n + 1))
    sleep 2
  done
else
  echo "Neither wget nor curl is supported"
  exit 1
fi

if [ ! -f ${s_file} ] || [ ! -s ${s_file} ]; then
  echo "failed to download DOTTY agent install script"
  exit 1
fi

chmod 0755 ${s_file}

if test -x ${s_file}; then
  exec ${s_file} || logger -t DOTTY-Agent "failed to install DOTTY agent"
fi


--===============9082803396151227987==
MIME-Version: 1.0
Content-Type: text/x-shellscript; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="install-do-agent"

#!/bin/sh
#
# This is a wrapper that ensures that the agent is only installed _once_ automatically
# via cloud-init. Cloud-init 0.7.8 and earlier re-execute included URL's each boot.
# This script ensures that the agent is only ever installed once.

i_file="https://insights.nyc3.cdn.digitaloceanspaces.com/install.sh"
s_path="/var/lib/cloud/instance/sem"
s_file="${s_path}/do_agent"

mkdir -p ${s_path}

test -f ${s_file} && exit 0

logger -t DigitalOcean-Agent "fetching and installing DigitalOcean monitoring agent"

wget --quiet -O ${s_file} ${i_file} ||
    curl -sSL --output ${s_file} ${i_file}

chmod 0755 ${s_file}

if test -x ${s_file}; then
    exec ${s_file} || logger -t DigitalOcean-Agent "failed to install DigitalOcean monitoring agent"
fi

--===============9082803396151227987==--
