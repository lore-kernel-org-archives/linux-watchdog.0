Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60297 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753494AbeFDOA4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Jun 2018 10:00:56 -0400
Date: Mon, 4 Jun 2018 16:00:52 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] watchdog: da9063: remove duplicated timeout_to_sel
 calls
Message-ID: <20180604140052.5celibdfa7jee2uc@pengutronix.de>
References: <20180604094241.30937-1-m.felsch@pengutronix.de>
 <20180604094241.30937-3-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB701941AD20F@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941AD20F@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18-06-04 12:27, Steve Twiss wrote:
> Hi Marco,
> 
> On 04 June 2018 10:43, Marco Felsch wrote,
> > Subject: [PATCH 2/2] watchdog: da9063: remove duplicated timeout_to_sel calls
> > 
> > Every time da9063_wdt_update_timeout() gets called a timeout_to_sel() is
> > made because the timeout argument of update_timeout() is the raw
> > register value. Moving the second<->raw-value translation into
> > da9063_wdt_update_timeout() removes duplicated code.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/watchdog/da9063_wdt.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> > index 760aa9bca81b..8007839fb3c0 100644
> > --- a/drivers/watchdog/da9063_wdt.c
> > +++ b/drivers/watchdog/da9063_wdt.c
> > @@ -64,8 +64,9 @@ static int da9063_wdt_disable_timer(struct da9063 *da9063)
> >  				  DA9063_TWDSCALE_DISABLE);
> >  }
> > 
> > -static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int
> > regval)
> > +static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int
> > timeout)
> >  {
> > +	unsigned int regval;
> >  	int ret;
> > 
> >  	/*
> > @@ -81,6 +82,7 @@ static int da9063_wdt_update_timeout(struct da9063
> > *da9063, unsigned int regval)
> >  		return ret;
> > 
> >  	usleep_range(150, 300);
> > +	regavl = da9063_wdt_timeout_to_sel(timeout);

Sorry for that stupid failure, I will fix it and adapt the cover-letter
too to reference the used git tree in a v2.

> >  	return regmap_update_bits(da9063->regmap,
> > DA9063_REG_CONTROL_D,
> >  				  DA9063_TWDSCALE_MASK, regval);
> > @@ -89,11 +91,9 @@ static int da9063_wdt_update_timeout(struct da9063
> > *da9063, unsigned int regval)
> >  static int da9063_wdt_start(struct watchdog_device *wdd)
> >  {
> >  	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
> > -	unsigned int selector;
> >  	int ret;
> > 
> > -	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
> > -	ret = da9063_wdt_update_timeout(da9063, selector);
> > +	ret = da9063_wdt_update_timeout(da9063, wdd->timeout);
> >  	if (ret)
> >  		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
> >  			ret);
> > @@ -132,11 +132,8 @@ static int da9063_wdt_set_timeout(struct
> > watchdog_device *wdd,
> >  				  unsigned int timeout)
> >  {
> >  	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
> > -	unsigned int selector;
> >  	int ret = 0;
> > 
> > -	selector = da9063_wdt_timeout_to_sel(timeout);
> > -
> >  	/*
> >  	 * There are two cases when a set_timeout() will be called:
> >  	 * 1. The watchdog is off and someone wants to set the timeout for the
> > @@ -148,13 +145,13 @@ static int da9063_wdt_set_timeout(struct
> > watchdog_device *wdd,
> >  	 * enabling the watchdog, so the timeout must be buffered by the driver.
> >  	 */
> >  	if (watchdog_active(wdd))
> > -		ret = da9063_wdt_update_timeout(da9063, selector);
> > +		ret = da9063_wdt_update_timeout(da9063, timeout);
> > 
> >  	if (ret)
> >  		dev_err(da9063->dev, "Failed to set watchdog timeout (err =
> > %d)\n",
> >  			ret);
> >  	else
> > -		wdd->timeout = wdt_timeout[selector];
> > +		wdd->timeout =
> > wdt_timeout[da9063_wdt_timeout_to_sel(timeout)];
> > 
> >  	return ret;
> >  }
> > @@ -220,10 +217,7 @@ static int da9063_wdt_probe(struct platform_device
> > *pdev)
> > 
> >  	/* Change the timeout to the default value if the watchdog is running */
> >  	if (da9063_wdt_is_running(da9063)) {
> > -		unsigned int timeout;
> > -
> > -		timeout =
> > da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
> > -		da9063_wdt_update_timeout(da9063, timeout);
> > +		da9063_wdt_update_timeout(da9063, DA9063_WDG_TIMEOUT);
> >  		set_bit(WDOG_HW_RUNNING, &wdd->status);
> >  	}
> > 
> > --
> > 2.17.1
> 
> It's a similar output for this [2/2] patch as [1/2]
> 
> patching file drivers/watchdog/da9063_wdt.c
> Hunk #1 FAILED at 64.
> Hunk #2 FAILED at 81.
> Hunk #3 succeeded at 54 (offset -35 lines).
> Hunk #4 FAILED at 130.
> Hunk #5 FAILED at 146.
> Hunk #6 FAILED at 218.
> 5 out of 6 hunks FAILED -- saving rejects to file drivers/watchdog/da9063_wdt.c.rej
> 
> Perhaps the patches are based upon a different tree than v4.17, or maybe stale files
> have crept in?
> 
> Regards,
> Steve
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
