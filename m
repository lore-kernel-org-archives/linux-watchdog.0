Return-path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1479490602.22212.33.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] intel-mid_wdt: make sure watchdog is not running
 at startup
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, mika.westerberg@linux.intel.com
Date: Fri, 18 Nov 2016 19:36:42 +0200
In-Reply-To: <1a10bf0f-963c-c603-9e47-2e667191d3c8@roeck-us.net>
References: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
	 <1a10bf0f-963c-c603-9e47-2e667191d3c8@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, 2016-11-18 at 07:50 -0800, Guenter Roeck wrote:
> On 11/18/2016 06:50 AM, Andy Shevchenko wrote:
> > Make sure that the watchdog is not running after loading
> > and before it is started by opening /dev/watchdog.

@@ -151,6 +151,9 @@ static int mid_wdt_probe(struct platform_device

> > +	/* Make sure the watchdog is not running */
> > +	wdt_stop(wdt_dev);
> > +
> >  	ret = watchdog_register_device(wdt_dev);

> This leaves the system exposed. Why not just tell the core if the
> watchdog
> is running and let it handle the ping until the device is opened ?
> Is it not possible to detect if the watchdog is running ?

It would be nice to have, but...

Just checked all documents I have access to. They even didn't describe a
content of watchdog IPC command!

So, we may just assume it's enabled by firmware until it is proven not
to. 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
