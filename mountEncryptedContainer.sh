#! /bin/bash
for i in "$@"
do
    case $i in
        -c=*|--container=*)
        containerFile="${i#*=}"
        shift
        ;;
        -p=*|--map=*)
        mapperName="${i#*=}"
        shift
        ;;
        -m=*|--mountpoint=*)
        mountPoint="${i#*=}"
        shift
        ;;
        *)
        #Unknown option
        ;;
    esac
done

#containerFile="./test"
#mapperName="test"
#mountPoint="/home/umesh/test"

loopa=`sudo losetup -f`
echo -e "\n\e[1mSetting up loop device \"$loopa\" for container file \"$containerFile\"...\e[21m"
losetup $loopa $containerFile

echo -e "\e[1mMapping container file...\e[21m"
cryptsetup luksOpen $loopa $mapperName

loopb=`sudo losetup -f`
echo -e "\e[1mSetting up loop device \"$loopb\" for mapped container file...\e[21m"
losetup $loopb /dev/mapper/$mapperName

echo -e "\e[1mMounting..."
mount $loopb $mountPoint

echo -e "\nDone :)\n\e[21m"
# vim: set nu expandtab ai ts=4 sw=4: #
