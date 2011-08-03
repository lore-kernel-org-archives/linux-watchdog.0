Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:54910 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753866Ab1HCJ4J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2011 05:56:09 -0400
Date: Wed, 3 Aug 2011 11:56:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC PATCH] watchdog: ep93xx: Use the WatchDog Timer Driver
	Core.
Message-ID: <20110803095606.GR4227@infomag.iguana.be>
References: <201108011357.24745.hartleys@visionengravers.com> <20110802091640.GF13218@intel.com> <ADE657CA350FB648AAC2C43247A983F001F3882B8535@AUSP01VMBX24.collaborationhost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3882B8535@AUSP01VMBX24.collaborationhost.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> >> @@ -24,11 +24,9 @@
> >>   */
> >>  
> >>  #include <linux/module.h>
> >> -#include <linux/fs.h>
> >>  #include <linux/miscdevice.h>
> >
> > Is the above header still needed?
> 
> I think so due to the MODULE_ALIAS_MISCDEV() at the end of the file.  But,
> I'm not sure if that is really needed... Wim?

Yes it's till needed. Both MODULE_ALIAS_MISCDEV() and WATCHDOG_MINOR are defined in miscdevice.h .

> >> @@ -210,43 +126,31 @@ static int __init ep93xx_wdt_init(void)
> >>  {
> >>  	int err;
> >>  
> >> -	err = misc_register(&ep93xx_wdt_miscdev);
> >> +	ep93xx_wdd.bootstatus = readl(EP93XX_WDT_WATCHDOG);
> >> +	ep93xx_wdd.timeout = timeout;
> >
> > Should you check that the given timeout is in valid range here, like it is
> > done in the original driver?
> 
> I thought the core would handle that.  If not maybe it should validate the
> timeout based on the min/max values.  Wim?

The core doesn't handle that.
What happens is: We set the parameter normally the same as the default value.
The user can change this when loading the module by another value.
We then normally need to check if this value makes any sense for the hardware.
If not we reset it back to the default value.

The core is however not aware of the default value.
Several solutions are possible:
1) we add a timeout_default value into the struct (waste of space imho)
2) we set it to timeout_max if out of range
3) we set it to timeout_min if less then timeout_min or timeout_max if bigger then timeout_max
4) we can add an operation to handle this so that the driver can decide

For now I would leave the check in. In parallel we could indeed adopt a common behaviour and add it to the core.

Kind regards,
Wim.

PS: Congratulations with your first child!

