Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:56925 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab2FIP2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jun 2012 11:28:42 -0400
Message-ID: <4FD36BA3.4090607@parallels.com>
Date: Sat, 9 Jun 2012 19:28:35 +0400
From: Tony Zelenoff <antonz@parallels.com>
MIME-Version: 1.0
To: Hans de Goede <hdegoede@redhat.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [RFC 0/3] watchdog: do not allow reboot without CAP_SYS_BOOT
 set
References: <1339160997-160581-1-git-send-email-antonz@parallels.com> <4FD20BF4.7010607@redhat.com> <4FD2166E.7040604@parallels.com> <4FD263A6.4020800@redhat.com>
In-Reply-To: <4FD263A6.4020800@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed explanation. Ok, let all stay as is, you are=20
right :)

9/06/12 12:42 AM, Hans de Goede =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> The CAP_SYS_BOOT capability required to reboot hardware node. But wa=
tchdog
>>>> writers are not checked for this capability. So, the process may reb=
oot
>>>> hardware node even if it has no any capabilities to do it.
>>>
>>> Hmm, I can imagine people explicitly doing a chown on /dev/watchdog, =
to allow
>>> some non root running, critical from a service availability pov, proc=
ess to
>>> open it and ping it.
>>>
>>> The suggest change would mean for most standard linux distributions, =
that
>>> a process opening /dev/watchdog now must run as root, even if the rig=
hts
>>> of /dev/watchdog allow a process to open it.
>> Hmm. I've missed it ) The patches may be modified to skip capabilities=
 check
>> when watchdog opened from non root user.
>
> That makes no sense, if you add a capability check you should *always*
> check that capability.
>
>>
>>
>>> Also since you add the check on open, not on specific syscalls you ar=
e
>>> adding extra security checks to the open path. Now users are trained =
when
>>> open() fails with -EPERM to check
>>> 1: Standard unix file rights
>>> 2: For selinux denials
>>>
>>> Adding a third way to make open() fail with -EPERM is not going to ma=
ke
>>> sysadmins very happy, esp. since this will not have any special loggi=
ng
>>> to make the cause clear (unlike selinux).
>> Add log message is not problem too. The EPERM error got from other pla=
ces,
>> where this capability checked. May be you can suggest better error cod=
e?
>>
>
> The error code is fine, if we are going to add a capability check
> logging if things fail on it is probably a very good idea.
>
>>> Moreover, since you add the check to open, what does it buy us over
>>> normal file-permissions? We already have a perfectly fine way to limi=
t
>>> access to the watchdog device, namely standard unix file permissions,
>>> needing to fiddle with both file permissions and capabilities to allo=
w
>>> a non root process to open /dev/watchdog is not making things easier,
>>> while at the same time not adding any value, since no extra granulari=
ty
>>> wrt security is gained.
>> Hm, so for what capabilities were created if standard permissions are =
good enough?
>
> Because a lot of actions require a process to have root rights, and the=
 whole
> idea of capabilities is to allow a process to do something like
> say build raw network packets (ie ping) without requiring full root, ie
> normally ping will be:
> -rwsr-xr-x. 1 root root 40912 Jan 25 20:52 /usr/bin/ping
>
> However with capabilities ping will be:
> [hans@shalem ~]$ ls -l /usr/bin/ping
> -rwxr-xr-x. 1 root root 40912 Jan 25 20:52 /usr/bin/ping
> [hans@shalem ~]$ getcap /usr/bin/ping
> /usr/bin/ping =3D cap_net_raw+ep
>
> So if as a normal user you now run ping, the ping process does not get
> elevated to the full privileges of root (note it is not suid root),
> the only privilege elevation it gets is gaining the CAP_NET_RAW
> capability.
>
>   > Reason of this patchset is to guard one more way to reboot hardware=
 node in same manner as it does in other places, because now root process=
 without this capability set can write something to watchdog device and a=
fter some timeout the hardware reboots. May be my way is wrong, but this =
looks like a small security hole when non authorized process do things th=
at it should not be able to do.
>
> I can see where you're coming from, but having a process run as root,
> but with some capabilites removed, is not how capabilities are normally
> used. The whole idea is not to run the process as root as all, and inst=
ead
> only give it the capabilities it needs. Also note that even with stripp=
ed
> capabilities running as root pretty much means full system access anywa=
ys,
> ie a program as root can do the following without needing any special
> capabilities (AFAIK): create a copy of /bin/sh (the copy will be owned =
by
> root), make it suid (this is allowed since the file is owned by the sam=
e
> uid as the process setting the suid bit), execute it -> full root.
>
> Regards,
>
> Hans
>


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
