---
title: 'go get github.comjessevdkgo-assets解决记录'
date: 2021-03-19 12:31:23
categories: 
- Tool
- Linux
tags: 
- GoLang
- Git
- Clone

---

在我的Cenos服务器上无法获取go-assets，结果如下：  
```
MRYQULAX> go get github.com/jessevdk/go-assets
# cd .; git clone -- https://github.com/jessevdk/go-assets /users/mryqu/go/src/github.com/jessevdk/go-assets
Cloning into '/users/mryqu/go/src/github.com/jessevdk/go-assets'...
fatal: unable to access 'https://github.com/jessevdk/go-assets/': SSL connect error
package github.com/jessevdk/go-assets: exit status 128
```

看了一下我的git版本是1.7.1，先升级一下试试吧。
```
export VER="2.31.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz
tar -xvf v${VER}.tar.gz
rm -f v${VER}.tar.gz
cd git-*
make configure
sudo ./configure --prefix=/usr
sudo make
sudo make install
```
升级完成后，还是无法获取go-assets。  

调试一下ssh方式：  
```
racerd1520570> ssh -vT git@github.com
OpenSSH_5.3p1, OpenSSL 1.0.0-fips 29 Mar 2010
debug1: Reading configuration data /users/scnydq/.ssh/config
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Applying options for *
debug1: Connecting to github.com [140.82.113.3] port 22.
debug1: Connection established.
debug1: identity file /users/scnydq/.ssh/identity type -1
debug1: identity file /users/scnydq/.ssh/id_rsa type 1
debug1: identity file /users/scnydq/.ssh/id_dsa type -1
debug1: Remote protocol version 2.0, remote software version babeld-8514a139
debug1: no match: babeld-8514a139
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_5.3
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-ctr hmac-sha1 none
debug1: kex: client->server aes128-ctr hmac-sha1 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<2048<8192) sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host 'github.com' is known and matches the RSA host key.
debug1: Found key in /users/scnydq/.ssh/known_hosts:543
debug1: ssh_rsa_verify: signature correct
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey
debug1: Next authentication method: publickey
debug1: Trying private key: /users/scnydq/.ssh/identity
debug1: Offering public key: /users/scnydq/.ssh/id_rsa
debug1: Authentications that can continue: publickey
debug1: Trying private key: /users/scnydq/.ssh/id_dsa
debug1: No more authentication methods to try.
Permission denied (publickey).
```
发现没有去查找我的github key文件。  

在~/.ssh/config文件中添加：  
```
host *github.com
       Protocol 2
       User mryqu
       IdentityFile ~/.ssh/github_rsa
```

再次测试：  
```
racerd1520570> ssh -vT git@github.com
OpenSSH_5.3p1, OpenSSL 1.0.0-fips 29 Mar 2010
debug1: Reading configuration data /users/scnydq/.ssh/config
debug1: Applying options for *github.com
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Applying options for *
debug1: Connecting to github.com [140.82.112.4] port 22.
debug1: Connection established.
debug1: identity file /users/scnydq/.ssh/github_rsa type 1
debug1: Remote protocol version 2.0, remote software version babeld-8514a139
debug1: no match: babeld-8514a139
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_5.3
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-ctr hmac-sha1 none
debug1: kex: client->server aes128-ctr hmac-sha1 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<2048<8192) sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host 'github.com' is known and matches the RSA host key.
debug1: Found key in /users/scnydq/.ssh/known_hosts:543
debug1: ssh_rsa_verify: signature correct
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey
debug1: Next authentication method: publickey
debug1: Offering public key: /users/scnydq/.ssh/github_rsa
debug1: Server accepts key: pkalg ssh-rsa blen 277
debug1: read PEM private key done: type RSA
debug1: Authentication succeeded (publickey).
debug1: channel 0: new [client-session]
debug1: Entering interactive session.
debug1: Sending environment.
debug1: Sending env LANG = en_US.UTF-8
debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
Hi mryqu! You've successfully authenticated, but GitHub does not provide shell access.
debug1: channel 0: free: client-session, nchannels 1
Transferred: sent 2352, received 2496 bytes, in 0.1 seconds
Bytes per second: sent 38618.7, received 40983.2
debug1: Exit status 1
```

在~/.gitconfig中添加如下内容：  
```
[url "git@github.com:"]
        insteadOf = https://github.com

[remote "origin"]
        proxy =

[http]
        sslVerify = false
        sslBackend = openssl
```

现在一切顺利！  
```
MRYQULAX>go get -u github.com/jessevdk/go-assets
```