#! /bin/bash
for i in "$@"
do
    case $i in
        -c=*|--container=*)
        containerFile="${i#*=}"
        shift
        ;;
        -s=*|--size=*)
        size="${i#*=}"
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
#size=1000
#mapperName="test"
#mountPoint="/home/umesh/test"
blks="1M"

echo -e "\e[1m\nCreating empty container file...\e[21m"
( dd if=/dev/zero of=$containerFile bs=$blks count=$size ) > /dev/null 2>&1

loopa=`sudo losetup -f`
echo -e "\e[1mSetting up loop device \"$loopa\" for container file \"$containerFile\"...\e[21m"
losetup $loopa $containerFile

echo -e "\e[1mSetting up encryption...\e[21m"
cryptsetup -qy -c aes-xts-plain64 -s 512 luksFormat $loopa

echo -e "\e[1mMapping container file...\e[21m"
cryptsetup luksOpen $loopa $mapperName

echo -e "\e[1mDumping header info...\e[21m"
cryptsetup luksDump $loopa > $containerFile".headerInfo"

loopb=`sudo losetup -f`
echo -e "\e[1mSetting up loop device \"$loopb\" for mapped container file...\e[21m"
losetup $loopb /dev/mapper/$mapperName

echo -e "\e[1mFormatting as ext4...\e[21m"
( mkfs.ext4 $loopb ) > /dev/null 2>&1

echo -e "\e[1mCreating(?) mount point \"$mountPoint\"...\e[21m"
mkdir -p $mountPoint

echo -e "\e[1mMounting...\e[21m"
mount $loopb $mountPoint

echo -e "\e[1mFilling with max size zero file...\e[21m"
( dd if=/dev/zero of=$mountPoint/zero bs=$blks count=$size ) > /dev/null 2>&1

echo -e "\e[1mDeleting zero file...\e[21m"
rm $mountPoint/zero

echo -e "\e[1m\n5 Seconds wait...\n\e[21m"
sleep 5

echo -e "\e[1mUnmounting...\e[21m"
umount $loopb

echo -e "\e[1mDeleting loop \"$loopb\" for mapped container file...\e[21m"
losetup -d $loopb

echo -e "\e[1mRemoving map for container file...\e[21m"
cryptsetup close $mapperName

echo -e "\e[1mDeleting loop \"$loopa\" for container file \"$containerFile\"...\e[21m"
losetup -d $loopa

echo -e "\e[1m\nDone :)\n\e[21m"
# vim: set nu expandtab ai ts=4 sw=4: #
