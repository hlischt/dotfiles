#!/bin/sh

drive="virtio"
net="virtio"

case "$1" in
	-d)
	    drive="ide"
	    shift 1
	    ;;
	-n)
	    net="rtl8139"
	    shift 1
	    ;;
esac

qemu="${HOME}/Código/qemu-3.0.0-rc2/x86_64-softmmu/qemu-system-x86_64"
disco="$1"
shift 1

exec "$qemu" \
-enable-kvm \
-m 2048M \
-rtc base=localtime \
-net nic,model="${net}" \
-net user \
-soundhw hda \
-cpu host \
-smp 2 \
-drive if="virtio",cache=none,file="$disco" "$@"

# -net user,smb=/home/hlischt/share \

# -netdev user,id=vmnic \
# -device virtio-net,netdev=vmnic \

# echo "disco = ${disco}"
# for i in $@
# do
# 	echo lo demás = "$i"
# done
