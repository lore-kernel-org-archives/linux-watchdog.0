Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242Ab2FHO1y (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 10:27:54 -0400
Message-ID: <4FD20BF4.7010607@redhat.com>
Date: Fri, 08 Jun 2012 16:28:04 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Tony Zelenoff <antonz@parallels.com>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [RFC 0/3] watchdog: do not allow reboot without CAP_SYS_BOOT
 set
References: <1339160997-160581-1-git-send-email-antonz@parallels.com>
In-Reply-To: <1339160997-160581-1-git-send-email-antonz@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 06/08/2012 03:09 PM, Tony Zelenoff wrote:
> The CAP_SYS_BOOT capability required to reboot hardware node. But watchdog
> writers are not checked for this capability. So, the process may reboot
> hardware node even if it has no any capabilities to do it.

Hmm, I can imagine people explicitly doing a chown on /dev/watchdog, to allow
some non root running, critical from a service availability pov, process to
open it and ping it.

The suggest change would mean for most standard linux distributions, that
a process opening /dev/watchdog now must run as root, even if the rights
of /dev/watchdog allow a process to open it.

Also since you add the check on open, not on specific syscalls you are
adding extra security checks to the open path. Now users are trained when
open() fails with -EPERM to check
1: Standard unix file rights
2: For selinux denials

Adding a third way to make open() fail with -EPERM is not going to make
sysadmins very happy, esp. since this will not have any special logging
to make the cause clear (unlike selinux).

Moreover, since you add the check to open, what does it buy us over
normal file-permissions? We already have a perfectly fine way to limit
access to the watchdog device, namely standard unix file permissions,
needing to fiddle with both file permissions and capabilities to allow
a non root process to open /dev/watchdog is not making things easier,
while at the same time not adding any value, since no extra granularity
wrt security is gained.

Last, but not least, this will break userspace ABI compatibility, which is
a very strong "thy shall never do that" scenario.

So all in all, a strong nack from me.

Regards,

Hans
