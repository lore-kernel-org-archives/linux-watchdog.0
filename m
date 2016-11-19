Return-path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1479571803.22212.47.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] intel-mid_wdt: make sure watchdog is not running
 at startup
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, mika.westerberg@linux.intel.com
Date: Sat, 19 Nov 2016 18:10:03 +0200
In-Reply-To: <265e4708-7658-d45f-7036-f2804e12e585@roeck-us.net>
References: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
	 <265e4708-7658-d45f-7036-f2804e12e585@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, 2016-11-19 at 07:55 -0800, Guenter Roeck wrote:
> On 11/18/2016 06:50 AM, Andy Shevchenko wrote:
> > Make sure that the watchdog is not running after loading
> > and before it is started by opening /dev/watchdog.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

> 
> I don't really like turning off the watchdog, but I guess it is the
> only
> remedy we have if it doesn't tell us if it is running.

That is my understanding based on current documentation and driver
implementation we have.

> 
> Guenter
> 
> > ---
> >  drivers/watchdog/intel-mid_wdt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/watchdog/intel-mid_wdt.c
> > b/drivers/watchdog/intel-mid_wdt.c
> > index db36d12..ff099a3 100644
> > --- a/drivers/watchdog/intel-mid_wdt.c
> > +++ b/drivers/watchdog/intel-mid_wdt.c
> > @@ -151,6 +151,9 @@ static int mid_wdt_probe(struct platform_device
> > *pdev)
> >  		return ret;
> >  	}
> > 
> > +	/* Make sure the watchdog is not running */
> > +	wdt_stop(wdt_dev);
> > +
> >  	ret = watchdog_register_device(wdt_dev);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "error registering watchdog
> > device\n");
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
