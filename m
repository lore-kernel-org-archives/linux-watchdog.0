Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58690 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbHEUVw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 16:21:52 -0400
Message-ID: <55C27059.50808@roeck-us.net>
Date: Wed, 05 Aug 2015 13:21:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Teigland <teigland@redhat.com>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <20150805171349.GA15472@redhat.com> <55C24ADF.7010605@roeck-us.net> <20150805175158.GB15472@redhat.com> <55C25D92.8020609@roeck-us.net> <20150805195125.GA20863@redhat.com>
In-Reply-To: <20150805195125.GA20863@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi David,

On 08/05/2015 12:51 PM, David Teigland wrote:
> On Wed, Aug 05, 2015 at 12:01:38PM -0700, Guenter Roeck wrote:
>> I think I can understand why Wim was reluctant to accept your patch;
>> I must admit I don't understand your use case either.
>
> Very breifly, sanlock is a shared storage based lease manager, and the
> expiration of a lease is tied to the expiration of the watchdog.  I have
> to ensure that the watchdog expires at or before the time that the lease
> expires.  This means that I cannot allow a watchdog heartbeat apart from a
> corresponding lease renewal on the shared storage.  Otherwise, the
> calculation by other hosts of the time of the hard reset will be wrong,
> and the data on shared storage could be corrupted.
>
>> I wonder if you are actually mis-using the watchdog subsystem to generate
>> hard resets.
>
> I am indeed using it to generate hard resets.
>
So there is no concern that the hard reset may corrupt some data ? Interesting.
Hope you don't use any SSDs - some of those don't like that.

>> After all, you could avoid the unexpected close situation with
>> an exit handler in your application. That handler could catch anything but
>> SIGKILL, but anyone using SIGKILL doesn't really deserve better.
>
> I avoid the unexpected close situation by prematurely closing the device
> to generate the heartbeat from close, and then reopening if needed.  That
> covers the SIGKILL case.  So, I have a work around, but the patch would
> still be nice.
>
Sounds messy....

>> If the intent is to reset the system after the application closes,
>> executing "/sbin/restart -f" might be a safer approach than just killing
>> the watchdog.
>
> I need to reset the system if the application crashes, or if the
> application is running but can't renew its lease.  In the former case,
> executing something doesn't work.  In the later case, I have done similar

Maybe you could have the system monitor (systemd or whatever it is) the
application and run /sbin/restart if it crashes. Essentially monitor
the application from the outside.

> (with /proc/sysrq-trigger), but it doesn't always apply and I'd still want
> the hardware reset as redundancy.
>
>> In addition to that, I don't think it is a good idea to rely on the assumption
>> that the watchdog will expire exactly after the configured timeout.
>> Many watchdog drivers implement a soft timeout on top of the hardware timeout,
>> and thus already implement the internal heartbeat. Most of those drivers
>> will stop sending internal heartbeats if user space did not send a heartbeat
>> within the configured timeout period. The actual reset will then occur later,
>> after the actual hardware watchdog timed out. This can be as much as the
>> hardware timeout period, which may be substantial.
>
> OK, thanks, I'll look into this in more detail.  Is there a way I can
> identify which cases these are, or do you know an example I can look at?
> In the worst case I'd have to extend the lease expiration time by a full
> timeout period when the dubious drivers are used.
>

git grep mod_timer drivers/watchdog | cut -f1 -d: | sort -u

gives you the following list:

alim7101_wdt.c
at91sam9_wdt.c
bcm47xx_wdt.c
bcm63xx_wdt.c
cpu5wdt.c
dw_wdt.c
ep93xx_wdt.c
gpio_wdt.c
imx2_wdt.c
machzwd.c
mixcomwd.c
mpc8xxx_wdt.c
mtx-1_wdt.c
nuc900_wdt.c
pcwd.c
pika_wdt.c
rdc321x_wdt.c
sbc60xxwdt.c
sc520_wdt.c
shwdt.c
softdog.c
via_wdt.c
w83877f_wdt.c

Those would be the immediate candidates to look out for. Note that this situation
will actually improve with my patch set, since it tries to tie the actual expiry
to the configured timeout. This will only work if the driver(s) are converted
to use the new infrastructure, of course.

Still, the ABI guarantees that "the hardware watchdog will reset the system
(causing a reboot) after the timeout occurs", but that doesn't mean that it
will reset the system immediately. I think the only safe guarantee is that
it won't reset the system as long as the timeout did _not_ occur. Extending
the lease expiration in your application by a timeout period will help,
but there is still no _guarantee_ that the reset will occur within
"expiration time + timeout".

I am not even sure if all watchdog drivers which don't implement a soft timer
will always timeout exactly after "timeout" seconds. It will be "at least
timeout" seconds, but I would not bet that it is always the exact time.

Guenter

