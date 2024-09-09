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
