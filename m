Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59050 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaIGRrD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 7 Sep 2014 13:47:03 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XQg7H-0038C2-QS
	for linux-watchdog@vger.kernel.org; Sun, 07 Sep 2014 17:19:07 +0000
Message-ID: <540C9383.9050307@roeck-us.net>
Date: Sun, 07 Sep 2014 10:18:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog: WatchDog Timer Driver Core: ping a hardware watchdog
 in kernel's space
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl>
In-Reply-To: <54088996.4040500@elproma.com.pl>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/04/2014 08:47 AM, Janusz U¿ycki wrote:
> Hi,
>
> Some applications require to start watchdog before userspace software. This patch enables such feature. Only WATCHDOG_KERNEL_PING flag is necessary to enable it (attached example for stmp3xxx_rtc_wdt.c). Moreover kernel's ping is re-enabled when userspace software closed watchdog using the magic character. The features improves kernel's reliable if hardware watchdog is available.
> * Can you comment the proposed patch?
> * Shoud dynamic or static timer_list be used (small structure...)?
> * I also added wdd->ops->ref/unref calls but I'm afraid that even original code is buggy in watchdog_dev.c. Is any driver that uses the pointers? In my opinion watchdog_open() should call wdd->ops->ref() before watchdog_start() and watchdog_release() should call wdd->ops->unref() before module_put(). Otherwise fault is possible if watchdog module is unloaded.
> * I noticed that current watchdog core does not support suspend/resume case. If you want to use suspend without the patch you need to close a watchdog in userspace using the magic character before suspend command. With the patch you must to use WDIOC_SETOPTIONS ioctl and WDIOS_DISABLECARD/WDIOS_ENABLECARD. Is there any other method to suspend with watchdog?
>
> best regards
> Janusz Uzycki
>
I like the basic idea. Couple of comments.

Please read and follow Documentation/SubmittingPatches.
Long lines as above are discouraged, as is sending patches
as attachment. As you can see, the patch disappears in the
reply, making it very hard to comment on it.

I would suggest to just modify the timer to half the timeout value,
and then just ping the watchdog unconditionally whenever the callback
runs. The timer should stop when the watchdog is opened, so there
should not be a need to check its open status in the callback.

I don't think there is a need to manipulate the driver reference
count when the kernel timer starts and stops. You already run
module_get and module_put during registration / unregistration.

I would not call this "kernel ping". We'll need to find a better
name. Proposals welcome. Something indicating the status, ie something
indicating that the wdt is always running and can not be stopped.

You would not update the status in the affected driver(s) by
setting the flag in the probe function. You can use the status
flag initialization for that purpose. Also, we'll need to know if
the driver you changed is always affected or only in your system.
Either case, driver patches need to be submitted separately.

We'll need to tie this functionality with parallel efforts
to add similar code into individual drivers. There is one patch
along that line pending right now [1], and I think there is similar
support in other drivers. dw_wdt is one example where the wdt can
not be stopped after it was started, of_xilinx_wdt is another.

Given that, there are two use states to consider: WDT is always running,
and WDT can not be stopped after it was started once. We should cover
both cases.

The feature should have DT support from the beginning if possible,
though it should be added as a separate patch in case there is
a hiccup with the DT folks.

It might be worthwhile exploring if the same mechanism can be used
to augment user space pinging with kernel ping if the maximum timeout
is too short to be handled by user space alone. That should be a
separate patch, but we need to keep this use case in mind.

Guenter

---
[1] http://patchwork.roeck-us.net/patch/1890/
