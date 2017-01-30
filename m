Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46574 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdA3UKY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 15:10:24 -0500
Date: Mon, 30 Jan 2017 11:31:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Hartley Sweeten <HartleyS@visionengravers.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] watchdog: ep93xx_wdt: cleanup and let the core
 handle the heartbeat
Message-ID: <20170130193118.GD11199@roeck-us.net>
References: <20170130165548.40965-1-hsweeten@visionengravers.com>
 <20170130165548.40965-2-hsweeten@visionengravers.com>
 <20170130185529.GA11199@roeck-us.net>
 <SN1PR0101MB1565196AC721B7FD3247E581D04B0@SN1PR0101MB1565.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR0101MB1565196AC721B7FD3247E581D04B0@SN1PR0101MB1565.prod.exchangelabs.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 30, 2017 at 07:09:55PM +0000, Hartley Sweeten wrote:
> On Monday, January 30, 2017 11:55 AM, Guenter Roeck wrote:
> > On Mon, Jan 30, 2017 at 09:55:47AM -0700, H Hartley Sweeten wrote:
> >> Cleanup this driver and remove the 200ms heartbeat timer. The core now
> >> has the ability to handle the heartbeat.
> >> 
> >> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >> Cc: Wim Van Sebroeck <wim@iguana.be>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> 
> Hi Guenter,
> 
> I wasn't sure this patch was going to get delivered correctly. I got an "Undeliverable"
> bounce due to possible spoofing. I am trying to figure out why right now.
> 
Interesting. If you find out, please let me know. Either case, I am subscribed
to the watchdog mailing list, so should get all e-mail sent to it. I also have
a patchwork instance running, so I see it there as well if the watchdog mailing
list is copied.

> Anyway...
> 
> <snip>
> 
> >> -#define WDT_VERSION	"0.4"
> >> -
> >> -/* default timeout (secs) */
> >> -#define WDT_TIMEOUT 30
> >> -
> >
> > Personally I like those constants, even if used only once (I know, it is a good
> > candidate for bikeshedding). Two reasons: 1) It is already there, and 2) It
> > helps seeing the default without having to dig into the code.
> 
> I assume the WDT_VERSION can go away...
> 
Yes, that is pretty much useless.

> As far as the WDT_TIMEOUT, I have no problem leaving it. I was just trying to remove
> some cruft.
> 
> >>  static bool nowayout = WATCHDOG_NOWAYOUT;
> >>  module_param(nowayout, bool, 0);
> >>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
> >>  
> >> -static unsigned int timeout = WDT_TIMEOUT;
> >> -module_param(timeout, uint, 0);
> >> -MODULE_PARM_DESC(timeout,
> >> -	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
> >> -				__MODULE_STRING(WDT_TIMEOUT) ")");
> >> -
> >
> > Are you sure you want to take away the means to set the timeout with
> > a module parameter ? You could easily retain the module parameter
> > and call watchdog_init_timeout(wdd, timeout, dev). The parameter should
> > then be initialized with 0, though, to have the watchdog core take the
> > timeout from devicetree if provided.
> 
> Again, I have no problem leaving this. I personally don't use it but someone else
> might. I'm not sure if the ep93xx will ever get converted to devicetree but I
> might figure it one eventually.
> 

Thinking more about it, we should really leave the module parameter in.
As you say, someone else may be using it, and we should not change the
interface to user space. Using watchdog_init_timeout() is useful to check
the range (not that it really matters here); that it reads a value from
devicetree is an additional benefit.

Thanks,
Guenter
