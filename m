Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44768 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755387AbdCJR1B (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Mar 2017 12:27:01 -0500
Message-ID: <1489166817.20145.201.camel@linux.intel.com>
Subject: Re: [PATCH v2] watchdog: intel-mid_wdt: Keep watchdog running
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Fri, 10 Mar 2017 19:26:57 +0200
In-Reply-To: <20170310171633.GA26960@roeck-us.net>
References: <20170310165138.53825-1-andriy.shevchenko@linux.intel.com>
         <1489165549.20145.197.camel@linux.intel.com>
         <20170310171633.GA26960@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2017-03-10 at 09:16 -0800, Guenter Roeck wrote:
> On Fri, Mar 10, 2017 at 07:05:49PM +0200, Andy Shevchenko wrote:
> > On Fri, 2017-03-10 at 18:51 +0200, Andy Shevchenko wrote:

> > > +	/*
> > > +	 * Make sure the watchdog is serviced.
> > > +	 *
> > > +	 * The firmware followed by U-Boot leaves the watchdog
> > > running
> > > +	 * with the default threshold 60 seconds. Our default
> > > timeout
> > > is
> > > +	 * 90 seconds, but internal worker divides it by two,
> > > which
> > > is
> > > +	 * 45 seconds and should be enough (less by 15 seconds
> > > than
> > > +	 * threshold).
> > > +	 */
> > > +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
> > 
> > Giving one more thought here perhaps more robust will be to start
> > watchdog unconditionally here?
> 
> Yes, that would be another option, and it sounds like a good idea.
> Let me know if you want to do that.

Yes, I prefer it over the rest of solutions.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
