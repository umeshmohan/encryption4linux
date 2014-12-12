encryption4linux
================

shell scripts to create, mount &amp; unmount encrypted file containers under linux.
(LUKS AES 256 volume in XTS mode)

https://github.com/t-d-k/doxbox/blob/master/docs/Linux_examples__LUKS.md#level_3_heading_6


## Usage
All commands are to be run as root (sudo)
```
initialSetup.sh
```
```
createEncryptedContainer.sh -c=test.container -s=10 -p=test -m=/home/user/test
```
You will be asked to enter passphrase thrice - twice while setting up the encryption and once more while mounting it to zero the whole file.
```
mountEncryptedContainer.sh -c=test.container -p=test -m=/home/user/test
```
```
umountEncryptedContainer.sh -p=test
```
