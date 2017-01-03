Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37285 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761110AbdACUGB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 15:06:01 -0500
Date: Tue, 3 Jan 2017 10:59:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH v3 2/2] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Message-ID: <20170103185909.GA10864@roeck-us.net>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-3-git-send-email-rasmus.villemoes@prevas.dk>
 <02c2de88-fa70-39ee-b9e3-89e0dee5523c@roeck-us.net>
 <c74b9968-65c5-61ea-c233-7dc66b39d903@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74b9968-65c5-61ea-c233-7dc66b39d903@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 03, 2017 at 04:52:14PM +0100, Rasmus Villemoes wrote:
> On 2017-01-02 16:22, Guenter Roeck wrote:
> >On 12/14/2016 05:37 AM, Rasmus Villemoes wrote:
> >>+config WATCHDOG_OPEN_TIMEOUT
> >>+    int "Default timeout value for opening watchdog device (seconds)"
> >>+    default 0
> >>+    help
> >>+      If a watchdog driver indicates to the framework that the
> >>+      hardware watchdog is running, the framework takes care of
> >>+      pinging the watchdog until userspace opens
> >>+      /dev/watchdogN. This value (overridden by the device's
> >>+      "open-timeout" property if present) sets an upper bound for
> >>+      how long the kernel does this - thus, if userspace hasn't
> >>+      opened the device within the timeout, the board reboots. A
> >>+      value of 0 means there is no timeout.
> >>+
> >>+
> >
> >Dual empty line. Also, as mentioned before, I am not a friend of such
> >configuration variables. It forces distribution vendors to make the
> >decision
> >for everyone.
> 
> Well, unless the distribution can guarantee that something opens the
> watchdog device in a timely manner, the only sensible decision is to keep
> the default infinite timeout, so I don't see how this is in any way a burden
> for general distributions.
> 
> >Please consider defining a command line parameter such as
> >watchdog_open_timeout.
> 
> I'd be happy to, and that was exactly what I did in the original proposal,
> where it could also be tweaked after boot via sysfs. But I'd still like the
> default value of that command line parameter to be settable via Kconfig.
> That's a lot easier to maintain than having to do parts of the kernel
> configuration in u-boot or whatever bootloader one uses.
> 
A sysfs attribute is a bit different to a command line parameter.

> >>diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> >>index 35a4d81..a89a293 100644
> >>--- a/include/linux/watchdog.h
> >>+++ b/include/linux/watchdog.h
> >>@@ -76,6 +76,11 @@ struct watchdog_ops {
> >>  * @max_hw_heartbeat_ms:
> >>  *        Hardware limit for maximum timeout, in milli-seconds.
> >>  *        Replaces max_timeout if specified.
> >>+ * @open_timeout:
> >>+ *              The maximum time for which the kernel will ping the
> >>+ *              device after registration.
> >>+ * @open_deadline:
> >>+ *              Set to jiffies + @open_timeout at registration.
> >>  * @reboot_nb:    The notifier block to stop watchdog on reboot.
> >>  * @restart_nb:    The notifier block to register a restart function.
> >>  * @driver_data:Pointer to the drivers private data.
> >>@@ -107,6 +112,8 @@ struct watchdog_device {
> >>     unsigned int max_timeout;
> >>     unsigned int min_hw_heartbeat_ms;
> >>     unsigned int max_hw_heartbeat_ms;
> >>+    unsigned int open_timeout;
> >>+    unsigned long open_deadline;
> >
> >None of those need to be visible in drivers. I don't see why the
> >variables should be
> >defined here and not in struct watchdog_core_data.
> 
> I completely agree, these values have nothing to do with individual drivers,
> but as I tried to convince you, they also, IMO, have nothing to do with
> individual devices.
> 

This is not about device vs. driver, it is about variable visibility.
The variables are only used in and by the watchdog core and thus only need
to be visible there. As for devices vs. system property, that really depends
on the means to set the variables. If there ever is a devicetree property,
it might well be per device (unless the property is, for example, attached
to the 'chosen' node), and might well be different for different watchdog
devices in the same system (just like two watchdogs in the same system can
have different timeouts).

Ultimately I would not mind to define the variables as static in the watchdog
core. What I object to is to have the variables in struct watchdog_device.

> So, since
> 
> > New devicetree properties need to be documented and approved by
> > devicetree maintainers.
> 
> I'd like to start with implementing this _just_ as a command line parameter
> (if I can't convince you to accept the Kconfig part we can always maintain
> that trivial addition internally).  If anyone down the road feels strongly
> about the possibility of setting the deadline via a device property, it can
> be added later if they do that work.
> 

Fine with me, though as I mentioned before, you'll have to convince Wim,
not me, to accept a Kconfig parameter.

Thanks,
Guenter
