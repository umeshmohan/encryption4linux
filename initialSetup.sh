#!/bin/bash
apt-get install aespipe cryptsetup cryptmount
#
modprobe cryptoloop
modprobe aes
modprobe anubis
modprobe arc4
modprobe blkcipher
modprobe blowfish
modprobe cast5
modprobe cast6
modprobe cbc
modprobe crc32c
modprobe crypto_algapi
modprobe crypto_hash
modprobe cryptomgr
modprobe crypto_null
modprobe deflate
modprobe des
modprobe ecb
modprobe gf128mul
modprobe hmac
modprobe khazad
modprobe lrw
modprobe md4
modprobe md5
modprobe michael_mic
modprobe serpent
modprobe sha1
modprobe sha256
modprobe sha512
modprobe tea
modprobe tgr192
modprobe twofish_common
modprobe twofish
modprobe wp512
modprobe xcbc
#**# dm_mod should give you dm_snapshot, dm_zero and dm_mirror?**
modprobe dm_mod
modprobe dm_crypt
