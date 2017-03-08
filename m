Return-path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1488985870.20145.137.camel@linux.intel.com>
Subject: Re: [PATCH v1] watchdog: intel-mid_wdt: Keep watchdog running
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Date: Wed, 08 Mar 2017 17:11:10 +0200
In-Reply-To: <846f18ec-e41c-364e-c867-fa6b3dbc18d4@roeck-us.net>
References: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
	 <846f18ec-e41c-364e-c867-fa6b3dbc18d4@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, 2017-03-08 at 06:21 -0800, Guenter Roeck wrote:
> Hi Andy,
> 
> On 03/08/2017 03:10 AM, Andy Shevchenko wrote:
> > Firmware followed by bootloader leaves watchdog running.
> > 
> 
> Is that always the case ?

Yes if no-one patched boot loader specifically to avoid this.

>  If not, does it hurt if the watchdog is pinged
> while not active ?
> 
> Also, this assumes that its default timeout is in the default range
> configured by the driver, ie not (much) lower than 30 seconds.

Correct. It is hard coded in SCU firmware (60 seconds IIRC). U-Boot for
now doesn't change it.

> Not objecting, but it would help to have comments in the code
> explaining
> the context in some more detail.

Last time you were not satisfied by the line which stops the running
watchdog [1]. I found a way how to keep it running gracefully, which I
proposed to do at that time (assuming boot loader doesn't stop it) [2].

I'm confused now what is preferable way to do the things?

P.S. I suppose previously we missed the chance to do this better and I
perhaps have to add Fixes: tag as well.

[1] https://www.spinics.net/lists/linux-watchdog/msg10386.html
[2] https://www.spinics.net/lists/linux-watchdog/msg10377.html

> 
> Thanks,
> Guenter
> 
> > Keep it running in the driver.
> > 
> > User will not need any additional options to reboot in case of
> > panic.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/watchdog/intel-mid_wdt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/intel-mid_wdt.c
> > b/drivers/watchdog/intel-mid_wdt.c
> > index 45e4d02221b5..a128ccb085b0 100644
> > --- a/drivers/watchdog/intel-mid_wdt.c
> > +++ b/drivers/watchdog/intel-mid_wdt.c
> > @@ -147,8 +147,8 @@ static int mid_wdt_probe(struct platform_device
> > *pdev)
> >  		return ret;
> >  	}
> > 
> > -	/* Make sure the watchdog is not running */
> > -	wdt_stop(wdt_dev);
> > +	/* Make sure the watchdog is serviced */
> > +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
> > 
> >  	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
> >  	if (ret) {
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
