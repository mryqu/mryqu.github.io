---
title: '[C++] 使用ldd'
date: 2015-12-07 06:05:11
categories: 
- Tool
- C++
tags: 
- ldd
- gcc
- cpp
---
[ldd](https://linux.die.net/man/1/ldd)是用来查看共享库依赖的Shell脚本命令。下面来看一下[ldd](https://linux.die.net/man/1/ldd)命令的参数。
![[C++] 使用ldd](/images/2015/12/0026uWfMzy79Uk3Gwmkc8.png)
- -v：显示所有信息，例如包括符号版本信息。
- -u：显示没有使用的直接依赖。
- -d：执行重新定位，报告任何缺失对象（仅针对ELF）
- -r：对数据对象和函数执行重新定位，报告任何缺失对象或函数（仅针对ELF）

[Oracle - Linker and Libraries Guide - Relocations](http://docs.oracle.com/cd/E19120-01/open.solaris/819-0690/6n33n7fa3/index.html)介绍了重新定位技术的来龙去脉，也介绍了ldd命令的相关使用。
#### ldd练习
```
hadoop@node51054:/usr/bin$ ldd curl
    linux-vdso.so.1 =>  (0x00007ffefe989000)
    libcurl.so.4 => /usr/lib/x86_64-linux-gnu/libcurl.so.4 (0x00007fb86cf8f000)
    libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fb86cd76000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fb86cb58000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb86c790000)
    libidn.so.11 => /usr/lib/x86_64-linux-gnu/libidn.so.11 (0x00007fb86c55d000)
    librtmp.so.0 => /usr/lib/x86_64-linux-gnu/librtmp.so.0 (0x00007fb86c343000)
    libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007fb86c0e4000)
    libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007fb86bd08000)
    libgssapi_krb5.so.2 => /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 (0x00007fb86bac1000)
    liblber-2.4.so.2 => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 (0x00007fb86b8b2000)
    libldap_r-2.4.so.2 => /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 (0x00007fb86b661000)
    /lib64/ld-linux-x86-64.so.2 (0x00007fb86d1f6000)
    libgnutls.so.26 => /usr/lib/x86_64-linux-gnu/libgnutls.so.26 (0x00007fb86b3a2000)
    libgcrypt.so.11 => /lib/x86_64-linux-gnu/libgcrypt.so.11 (0x00007fb86b122000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fb86af1e000)
    libkrb5.so.3 => /usr/lib/x86_64-linux-gnu/libkrb5.so.3 (0x00007fb86ac53000)
    libk5crypto.so.3 => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 (0x00007fb86aa24000)
    libcom_err.so.2 => /lib/x86_64-linux-gnu/libcom_err.so.2 (0x00007fb86a820000)
    libkrb5support.so.0 => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 (0x00007fb86a615000)
    libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007fb86a3fa000)
    libsasl2.so.2 => /usr/lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007fb86a1df000)
    libgssapi.so.3 => /usr/lib/x86_64-linux-gnu/libgssapi.so.3 (0x00007fb869fa1000)
    libtasn1.so.6 => /usr/lib/x86_64-linux-gnu/libtasn1.so.6 (0x00007fb869d8d000)
    libp11-kit.so.0 => /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 (0x00007fb869b4b000)
    libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007fb869946000)
    libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007fb869742000)
    libheimntlm.so.0 => /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 (0x00007fb869539000)
    libkrb5.so.26 => /usr/lib/x86_64-linux-gnu/libkrb5.so.26 (0x00007fb8692b1000)
    libasn1.so.8 => /usr/lib/x86_64-linux-gnu/libasn1.so.8 (0x00007fb869010000)
    libhcrypto.so.4 => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4 (0x00007fb868ddd000)
    libroken.so.18 => /usr/lib/x86_64-linux-gnu/libroken.so.18 (0x00007fb868bc8000)
    libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007fb8689c0000)
    libwind.so.0 => /usr/lib/x86_64-linux-gnu/libwind.so.0 (0x00007fb868797000)
    libheimbase.so.1 => /usr/lib/x86_64-linux-gnu/libheimbase.so.1 (0x00007fb868589000)
    libhx509.so.5 => /usr/lib/x86_64-linux-gnu/libhx509.so.5 (0x00007fb868340000)
    libsqlite3.so.0 => /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 (0x00007fb868087000)
    libcrypt.so.1 => /lib/x86_64-linux-gnu/libcrypt.so.1 (0x00007fb867e4e000)
```
#### ldd -u练习
![[C++] 使用ldd](/images/2015/12/0026uWfMzy79Ulxyghu5c.png)
#### ldd -v练习
```
hadoop@node51054:/usr/bin$ ldd -v curl
linux-vdso.so.1 =>  (0x00007ffef2be1000)
libcurl.so.4 => /usr/lib/x86_64-linux-gnu/libcurl.so.4 (0x00007fe38e414000)
libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fe38e1fb000)
libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fe38dfdd000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fe38dc15000)
libidn.so.11 => /usr/lib/x86_64-linux-gnu/libidn.so.11 (0x00007fe38d9e2000)
librtmp.so.0 => /usr/lib/x86_64-linux-gnu/librtmp.so.0 (0x00007fe38d7c8000)
libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007fe38d569000)
libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007fe38d18d000)
libgssapi_krb5.so.2 => /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 (0x00007fe38cf46000)
liblber-2.4.so.2 => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 (0x00007fe38cd37000)
libldap_r-2.4.so.2 => /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 (0x00007fe38cae6000)
/lib64/ld-linux-x86-64.so.2 (0x00007fe38e67b000)
libgnutls.so.26 => /usr/lib/x86_64-linux-gnu/libgnutls.so.26 (0x00007fe38c827000)
libgcrypt.so.11 => /lib/x86_64-linux-gnu/libgcrypt.so.11 (0x00007fe38c5a7000)
libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fe38c3a3000)
libkrb5.so.3 => /usr/lib/x86_64-linux-gnu/libkrb5.so.3 (0x00007fe38c0d8000)
libk5crypto.so.3 => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 (0x00007fe38bea9000)
libcom_err.so.2 => /lib/x86_64-linux-gnu/libcom_err.so.2 (0x00007fe38bca5000)
libkrb5support.so.0 => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 (0x00007fe38ba9a000)
libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007fe38b87f000)
libsasl2.so.2 => /usr/lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007fe38b664000)
libgssapi.so.3 => /usr/lib/x86_64-linux-gnu/libgssapi.so.3 (0x00007fe38b426000)
libtasn1.so.6 => /usr/lib/x86_64-linux-gnu/libtasn1.so.6 (0x00007fe38b212000)
libp11-kit.so.0 => /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 (0x00007fe38afd0000)
libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007fe38adcb000)
libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007fe38abc7000)
libheimntlm.so.0 => /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 (0x00007fe38a9be000)
libkrb5.so.26 => /usr/lib/x86_64-linux-gnu/libkrb5.so.26 (0x00007fe38a736000)
libasn1.so.8 => /usr/lib/x86_64-linux-gnu/libasn1.so.8 (0x00007fe38a495000)
libhcrypto.so.4 => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4 (0x00007fe38a262000)
libroken.so.18 => /usr/lib/x86_64-linux-gnu/libroken.so.18 (0x00007fe38a04d000)
libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007fe389e45000)
libwind.so.0 => /usr/lib/x86_64-linux-gnu/libwind.so.0 (0x00007fe389c1c000)
libheimbase.so.1 => /usr/lib/x86_64-linux-gnu/libheimbase.so.1 (0x00007fe389a0e000)
libhx509.so.5 => /usr/lib/x86_64-linux-gnu/libhx509.so.5 (0x00007fe3897c5000)
libsqlite3.so.0 => /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 (0x00007fe38950c000)
libcrypt.so.1 => /lib/x86_64-linux-gnu/libcrypt.so.1 (0x00007fe3892d3000)

Version information:
./curl:
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.17) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libcurl.so.4 (CURL_OPENSSL_3) => /usr/lib/x86_64-linux-gnu/libcurl.so.4
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
/usr/lib/x86_64-linux-gnu/libcurl.so.4:
libldap_r-2.4.so.2 (OPENLDAP_2.4_2) => /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2
libgssapi_krb5.so.2 (gssapi_krb5_2_MIT) => /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2
liblber-2.4.so.2 (OPENLDAP_2.4_2) => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libidn.so.11 (LIBIDN_1.0) => /usr/lib/x86_64-linux-gnu/libidn.so.11
libssl.so.1.0.0 (OPENSSL_1.0.1) => /lib/x86_64-linux-gnu/libssl.so.1.0.0
libssl.so.1.0.0 (OPENSSL_1.0.0) => /lib/x86_64-linux-gnu/libssl.so.1.0.0
libc.so.6 (GLIBC_2.15) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.16) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.17) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libcrypto.so.1.0.0 (OPENSSL_1.0.0) => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
/lib/x86_64-linux-gnu/libz.so.1:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libpthread.so.0:
ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libc.so.6:
ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
/usr/lib/x86_64-linux-gnu/libidn.so.11:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/librtmp.so.0:
libgnutls.so.26 (GNUTLS_1_4) => /usr/lib/x86_64-linux-gnu/libgnutls.so.26
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libgcrypt.so.11 (GCRYPT_1.2) => /lib/x86_64-linux-gnu/libgcrypt.so.11
/lib/x86_64-linux-gnu/libssl.so.1.0.0:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libcrypto.so.1.0.0 (OPENSSL_1.0.1d) => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
libcrypto.so.1.0.0 (OPENSSL_1.0.1) => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
libcrypto.so.1.0.0 (OPENSSL_1.0.0) => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
/lib/x86_64-linux-gnu/libcrypto.so.1.0.0:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2:
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libk5crypto.so.3 (k5crypto_3_MIT) => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3
libkrb5support.so.0 (krb5support_0_MIT) => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0
libkrb5.so.3 (krb5_3_MIT) => /usr/lib/x86_64-linux-gnu/libkrb5.so.3
/usr/lib/x86_64-linux-gnu/liblber-2.4.so.2:
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2:
libgcrypt.so.11 (GCRYPT_1.2) => /lib/x86_64-linux-gnu/libgcrypt.so.11
libresolv.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libresolv.so.2
libgssapi.so.3 (HEIMDAL_GSS_2.0) => /usr/lib/x86_64-linux-gnu/libgssapi.so.3
libgnutls.so.26 (GNUTLS_1_4) => /usr/lib/x86_64-linux-gnu/libgnutls.so.26
libpthread.so.0 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libpthread.so.0
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libsasl2.so.2 (SASL2) => /usr/lib/x86_64-linux-gnu/libsasl2.so.2
libc.so.6 (GLIBC_2.12) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
liblber-2.4.so.2 (OPENLDAP_2.4_2) => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2
/usr/lib/x86_64-linux-gnu/libgnutls.so.26:
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libtasn1.so.6 (LIBTASN1_0_3) => /usr/lib/x86_64-linux-gnu/libtasn1.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libgcrypt.so.11 (GCRYPT_1.2) => /lib/x86_64-linux-gnu/libgcrypt.so.11
/lib/x86_64-linux-gnu/libgcrypt.so.11:
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.15) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libdl.so.2:
ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libkrb5.so.3:
libresolv.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libresolv.so.2
libresolv.so.2 (GLIBC_2.9) => /lib/x86_64-linux-gnu/libresolv.so.2
libk5crypto.so.3 (k5crypto_3_MIT) => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3
libkrb5support.so.0 (krb5support_0_MIT) => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0
libkeyutils.so.1 (KEYUTILS_1.0) => /lib/x86_64-linux-gnu/libkeyutils.so.1
libkeyutils.so.1 (KEYUTILS_0.3) => /lib/x86_64-linux-gnu/libkeyutils.so.1
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.16) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libk5crypto.so.3:
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libkrb5support.so.0 (krb5support_0_MIT) => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0
/lib/x86_64-linux-gnu/libcom_err.so.2:
ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.17) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libkrb5support.so.0:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libresolv.so.2:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libsasl2.so.2:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.15) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libgssapi.so.3:
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libheimntlm.so.0 (HEIMDAL_NTLM_1.0) => /usr/lib/x86_64-linux-gnu/libheimntlm.so.0
libasn1.so.8 (HEIMDAL_ASN1_1.0) => /usr/lib/x86_64-linux-gnu/libasn1.so.8
libhcrypto.so.4 (HEIMDAL_CRYPTO_1.0) => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libkrb5.so.26 (HEIMDAL_KRB5_2.0) => /usr/lib/x86_64-linux-gnu/libkrb5.so.26
/usr/lib/x86_64-linux-gnu/libtasn1.so.6:
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libp11-kit.so.0:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.16) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libgpg-error.so.0:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libkeyutils.so.1:
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libheimntlm.so.0:
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libkrb5.so.26 (HEIMDAL_KRB5_2.0) => /usr/lib/x86_64-linux-gnu/libkrb5.so.26
libhcrypto.so.4 (HEIMDAL_CRYPTO_1.0) => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libkrb5.so.26:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libcrypt.so.1 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libcrypt.so.1
libhcrypto.so.4 (HEIMDAL_CRYPTO_1.0) => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4
libwind.so.0 (HEIMDAL_WIND_1.0) => /usr/lib/x86_64-linux-gnu/libwind.so.0
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libpthread.so.0 (GLIBC_2.3.2) => /lib/x86_64-linux-gnu/libpthread.so.0
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libheimbase.so.1 (HEIMDAL_BASE_1.0) => /usr/lib/x86_64-linux-gnu/libheimbase.so.1
libc.so.6 (GLIBC_2.15) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libasn1.so.8 (HEIMDAL_ASN1_1.0) => /usr/lib/x86_64-linux-gnu/libasn1.so.8
libhx509.so.5 (HEIMDAL_X509_1.2) => /usr/lib/x86_64-linux-gnu/libhx509.so.5
/usr/lib/x86_64-linux-gnu/libasn1.so.8:
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libhcrypto.so.4:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libasn1.so.8 (HEIMDAL_ASN1_1.0) => /usr/lib/x86_64-linux-gnu/libasn1.so.8
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libc.so.6 (GLIBC_2.7) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libroken.so.18:
libresolv.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libresolv.so.2
libcrypt.so.1 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libcrypt.so.1
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.15) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libffi.so.6:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libwind.so.0:
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libheimbase.so.1:
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libhx509.so.5:
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libheimbase.so.1 (HEIMDAL_BASE_1.0) => /usr/lib/x86_64-linux-gnu/libheimbase.so.1
libwind.so.0 (HEIMDAL_WIND_1.0) => /usr/lib/x86_64-linux-gnu/libwind.so.0
libroken.so.18 (HEIMDAL_ROKEN_1.0) => /usr/lib/x86_64-linux-gnu/libroken.so.18
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.8) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
libasn1.so.8 (HEIMDAL_ASN1_1.0) => /usr/lib/x86_64-linux-gnu/libasn1.so.8
libhcrypto.so.4 (HEIMDAL_CRYPTO_1.0) => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4
/usr/lib/x86_64-linux-gnu/libsqlite3.so.0:
libdl.so.2 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libdl.so.2
libpthread.so.0 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libpthread.so.0
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.3.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.4) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
/lib/x86_64-linux-gnu/libcrypt.so.1:
libc.so.6 (GLIBC_2.14) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_PRIVATE) => /lib/x86_64-linux-gnu/libc.so.6
libc.so.6 (GLIBC_2.2.5) => /lib/x86_64-linux-gnu/libc.so.6
```
#### ld-Linux.so
ldd显示可执行模块的dependency的工作原理，其实质是通过ld-Linux.so（elf动态库的装载器）来实现的。我们知道，ld-linux.so模块会先于executable模块程序工作，并获得控制权，因此当上述的那些环境变量被设置时，ld-linux.so选择了显示可执行模块的dependency。
直接执行ld-Linux.so命令也可获得共享库的依赖关系：
```
hadoop@node51054:/usr/bin$ /lib64/ld-linux-x86-64.so.2 --list ./curl
```
