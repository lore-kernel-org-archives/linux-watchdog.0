Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:44488 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759473Ab2FHPMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 11:12:49 -0400
Message-ID: <4FD2166E.7040604@parallels.com>
Date: Fri, 8 Jun 2012 19:12:46 +0400
From: Tony Zelenoff <antonz@parallels.com>
MIME-Version: 1.0
To: Hans de Goede <hdegoede@redhat.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [RFC 0/3] watchdog: do not allow reboot without CAP_SYS_BOOT
 set
References: <1339160997-160581-1-git-send-email-antonz@parallels.com> <4FD20BF4.7010607@redhat.com>
In-Reply-To: <4FD20BF4.7010607@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

8/06/12 6:28 PM, Hans de Goede =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>
> On 06/08/2012 03:09 PM, Tony Zelenoff wrote:
>> The CAP_SYS_BOOT capability required to reboot hardware node. But watc=
hdog
>> writers are not checked for this capability. So, the process may reboo=
t
>> hardware node even if it has no any capabilities to do it.
>
> Hmm, I can imagine people explicitly doing a chown on /dev/watchdog, to=
 allow
> some non root running, critical from a service availability pov, proces=
s to
> open it and ping it.
>
> The suggest change would mean for most standard linux distributions, th=
at
> a process opening /dev/watchdog now must run as root, even if the right=
s
> of /dev/watchdog allow a process to open it.
Hmm. I've missed it ) The patches may be modified to skip capabilities ch=
eck
when watchdog opened from non root user.


> Also since you add the check on open, not on specific syscalls you are
> adding extra security checks to the open path. Now users are trained wh=
en
> open() fails with -EPERM to check
> 1: Standard unix file rights
> 2: For selinux denials
>
> Adding a third way to make open() fail with -EPERM is not going to make
> sysadmins very happy, esp. since this will not have any special logging
> to make the cause clear (unlike selinux).
Add log message is not problem too. The EPERM error got from other places=
,
where this capability checked. May be you can suggest better error code?

> Moreover, since you add the check to open, what does it buy us over
> normal file-permissions? We already have a perfectly fine way to limit
> access to the watchdog device, namely standard unix file permissions,
> needing to fiddle with both file permissions and capabilities to allow
> a non root process to open /dev/watchdog is not making things easier,
> while at the same time not adding any value, since no extra granularity
> wrt security is gained.
Hm, so for what capabilities were created if standard permissions are=20
good enough? Reason of this patchset is to guard one more way to reboot=20
hardware node in same manner as it does in other places, because now=20
root process without this capability set can write something to watchdog=20
device and after some timeout the hardware reboots. May be my way is=20
wrong, but this looks like a small security hole when non authorized=20
process do things that it should not be able to do.


> Last, but not least, this will break userspace ABI compatibility, which=
 is
> a very strong "thy shall never do that" scenario.
> So all in all, a strong nack from me.


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
