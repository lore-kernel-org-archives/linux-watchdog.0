Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45717 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbdCJRQh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Mar 2017 12:16:37 -0500
Date: Fri, 10 Mar 2017 09:16:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: intel-mid_wdt: Keep watchdog running
Message-ID: <20170310171633.GA26960@roeck-us.net>
References: <20170310165138.53825-1-andriy.shevchenko@linux.intel.com>
 <1489165549.20145.197.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1489165549.20145.197.camel@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 10, 2017 at 07:05:49PM +0200, Andy Shevchenko wrote:
> On Fri, 2017-03-10 at 18:51 +0200, Andy Shevchenko wrote:
> > Firmware followed by bootloader leaves watchdog running.
> > 
> > Keep it running in the driver.
> > 
> > User will not need any additional options to reboot in case of panic
> > during boot.
> 
> > -	/* Make sure the watchdog is not running */
> > -	wdt_stop(wdt_dev);
> > +	/*
> > +	 * Make sure the watchdog is serviced.
> > +	 *
> > +	 * The firmware followed by U-Boot leaves the watchdog
> > running
> > +	 * with the default threshold 60 seconds. Our default timeout
> > is
> > +	 * 90 seconds, but internal worker divides it by two, which
> > is
> > +	 * 45 seconds and should be enough (less by 15 seconds than
> > +	 * threshold).
> > +	 */
> > +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
> 
> Giving one more thought here perhaps more robust will be to start
> watchdog unconditionally here?
> 
Yes, that would be another option, and it sounds like a good idea.
Let me know if you want to do that.

Thanks,
Guenter

> In that case it will be no matter how it's configured in firmware and/or
> boot loader.
> 
> >  
> >  	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
> >  	if (ret) {
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
