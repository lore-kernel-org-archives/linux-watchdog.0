Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759538Ab2FHUmE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 16:42:04 -0400
Message-ID: <4FD263A6.4020800@redhat.com>
Date: Fri, 08 Jun 2012 22:42:14 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Tony Zelenoff <antonz@parallels.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [RFC 0/3] watchdog: do not allow reboot without CAP_SYS_BOOT
 set
References: <1339160997-160581-1-git-send-email-antonz@parallels.com> <4FD20BF4.7010607@redhat.com> <4FD2166E.7040604@parallels.com>
In-Reply-To: <4FD2166E.7040604@parallels.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/08/2012 05:12 PM, Tony Zelenoff wrote:
> 8/06/12 6:28 PM, Hans de Goede =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi,
>>
>> On 06/08/2012 03:09 PM, Tony Zelenoff wrote:
>>> The CAP_SYS_BOOT capability required to reboot hardware node. But wat=
chdog
>>> writers are not checked for this capability. So, the process may rebo=
ot
>>> hardware node even if it has no any capabilities to do it.
>>
>> Hmm, I can imagine people explicitly doing a chown on /dev/watchdog, t=
o allow
>> some non root running, critical from a service availability pov, proce=
ss to
>> open it and ping it.
>>
>> The suggest change would mean for most standard linux distributions, t=
hat
>> a process opening /dev/watchdog now must run as root, even if the righ=
ts
>> of /dev/watchdog allow a process to open it.
> Hmm. I've missed it ) The patches may be modified to skip capabilities =
check
> when watchdog opened from non root user.

That makes no sense, if you add a capability check you should *always*
check that capability.

>
>
>> Also since you add the check on open, not on specific syscalls you are
>> adding extra security checks to the open path. Now users are trained w=
hen
>> open() fails with -EPERM to check
>> 1: Standard unix file rights
>> 2: For selinux denials
>>
>> Adding a third way to make open() fail with -EPERM is not going to mak=
e
>> sysadmins very happy, esp. since this will not have any special loggin=
g
>> to make the cause clear (unlike selinux).
> Add log message is not problem too. The EPERM error got from other plac=
es,
> where this capability checked. May be you can suggest better error code=
?
>

The error code is fine, if we are going to add a capability check
logging if things fail on it is probably a very good idea.

>> Moreover, since you add the check to open, what does it buy us over
>> normal file-permissions? We already have a perfectly fine way to limit
>> access to the watchdog device, namely standard unix file permissions,
>> needing to fiddle with both file permissions and capabilities to allow
>> a non root process to open /dev/watchdog is not making things easier,
>> while at the same time not adding any value, since no extra granularit=
y
>> wrt security is gained.
> Hm, so for what capabilities were created if standard permissions are g=
ood enough?

Because a lot of actions require a process to have root rights, and the w=
hole
idea of capabilities is to allow a process to do something like
say build raw network packets (ie ping) without requiring full root, ie
normally ping will be:
-rwsr-xr-x. 1 root root 40912 Jan 25 20:52 /usr/bin/ping

However with capabilities ping will be:
[hans@shalem ~]$ ls -l /usr/bin/ping
-rwxr-xr-x. 1 root root 40912 Jan 25 20:52 /usr/bin/ping
[hans@shalem ~]$ getcap /usr/bin/ping
/usr/bin/ping =3D cap_net_raw+ep

So if as a normal user you now run ping, the ping process does not get
elevated to the full privileges of root (note it is not suid root),
the only privilege elevation it gets is gaining the CAP_NET_RAW
capability.

 > Reason of this patchset is to guard one more way to reboot hardware no=
de in same manner as it does in other places, because now root process wi=
thout this capability set can write something to watchdog device and afte=
r some timeout the hardware reboots. May be my way is wrong, but this loo=
ks like a small security hole when non authorized process do things that =
it should not be able to do.

I can see where you're coming from, but having a process run as root,
but with some capabilites removed, is not how capabilities are normally
used. The whole idea is not to run the process as root as all, and instea=
d
only give it the capabilities it needs. Also note that even with stripped
capabilities running as root pretty much means full system access anyways=
,
ie a program as root can do the following without needing any special
capabilities (AFAIK): create a copy of /bin/sh (the copy will be owned by
root), make it suid (this is allowed since the file is owned by the same
uid as the process setting the suid bit), execute it -> full root.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
