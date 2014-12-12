#! /bin/bash
for i in "$@"
do
    case $i in
        -p=*|--map=*)
        mapperName="${i#*=}"
        shift
        ;;
        *)
        #Unknown option
        ;;
    esac
done

#mapperName="test"

tt=`sudo cryptsetup status $mapperName | grep "device:"`
loopa=${tt#*:}
tt=`sudo losetup -j /dev/mapper/$mapperName`
loopb=${tt%%:*}
echo -e "\n\e[1mLoop devices are:"
echo -e "\t$loopa : container file loop"
echo -e "\t$loopb : mapped container file loop"

echo -e "Unmounting \"$loopb\"..."
umount $loopb

echo -e "Deleting loop \"$loopb\"..."
losetup -d $loopb

echo -e "Unmounting \"/dev/mapper/$mapperName\" (in case it is mounted)..."
umount /dev/mapper/$mapperName

echo -e "Removing map for container file..."
cryptsetup close $mapperName

echo -e "Deleting loop \"$loopa\"..."
losetup -d $loopa

echo -e "\nDone :)\n\e[21m"
# vim: set nu expandtab ai ts=4 sw=4: #
