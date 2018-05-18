Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
Date: Fri, 18 May 2018 14:12:56 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, support.opensource@diasemi.com,
	fzuuzf@googlemail.com, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v4] watchdog: da9063: Fix setting/changing timeout
Message-ID: <20180518121256.uuhtq3pp3t6gki4z@pengutronix.de>
References: <20180517093710.808-1-m.felsch@pengutronix.de>
 <7febc00f-24fb-441a-54fa-6bd7e36364c9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7febc00f-24fb-441a-54fa-6bd7e36364c9@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 18-05-17 19:28, Guenter Roeck wrote:
> On 05/17/2018 02:37 AM, Marco Felsch wrote:
> > If the timeout value is set more than once the DA9063 watchdog triggers
> > a reset signal which reset the system.
> > 
> > To update the timeout value we have to disable the watchdog, clear the
> > watchdog counter value and write the new timeout value to the watchdog.
> > Clearing the counter value is a feature to be on the safe side because the
> > data sheet doesn't describe the behaviour of the watchdog counter value
> > after a watchdog disabling-enable-sequence.
> > 
> > The patch is based on Philipp Zabel's previous patch.
> > 
> > Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >   drivers/watchdog/da9063_wdt.c | 35 +++++++++++++++++++++++++++++++++--
> >   1 file changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> > index b17ac1bb1f28..06fcc662673e 100644
> > --- a/drivers/watchdog/da9063_wdt.c
> > +++ b/drivers/watchdog/da9063_wdt.c
> > @@ -45,8 +45,40 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
> >   	return DA9063_TWDSCALE_MAX;
> >   }
> > +/*
> > + * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog counter
> > + * value.
> > + */
> > +static int _da9063_wdt_reset_timer(struct da9063 *da9063)
> > +{
> > +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> > +			    DA9063_WATCHDOG);
> > +}
> > +
> >   static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
> >   {
> > +	int ret;
> > +
> > +	/*
> > +	 * The watchdog triggers a reboot if a timeout value is already
> > +	 * programmed. The reason for this is that the timeout value
> > +	 * combines two functions in one: indicating the counter limit and
> > +	 * starting the watchdog. The watchdog must be disabled to be able to
> > +	 * change the timeout value if the watchdog is already running. Then
> > +	 * we can set the new timeout value which enables the watchdog again.
> 
> This is problematic. The watchdog may be stopped when this is called. If setting
> the timeout starts it, we'll need more complex code only doing this if the
> watchdog is running.

I agree with you but the da9062 does it same way. Setting the timeout
and start the watchdog calls the same subroutine
'da9062_wdt_update_timeout_register()'. So it will disable the watchdog
too.

Anyway, would it be better to buffer the timeout to a variable and
'set & turn-on' only during wdt_start()?

> > +	 */
> > +	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> > +	if (ret)
> > +		dev_warn(da9063->dev,
> > +			 "Failed to disable watchdog before setting new timeout\n");
> > +
> 
> It might be simpler to just call da9063_wdt_stop() for the above.

Yes, I will change that.

> > +	usleep_range(150, 300);
> > +
> > +	ret = _da9063_wdt_reset_timer(da9063);
> 
> Is this necessary even though the watchdog is stopped at this point ?
> 

My template was again the da9062 driver. There is a reset during
updating the timeout value too. I only changed the place where the reset
happens because I didn't understood the reaseon to reset the watchdog
timer and disable it afterwards.

Anyway, I think the reset isn't needed because the watchdog will reset
the counter after a disable-enable sequence. Since there is no register
to retrieve the current watchdog counter I wrote a small script to test
the behaviour in Barebox:
 1) disbale the watchdog
 2) reset the watchdog
 3) set the timeout to 60sec
 4) sleep 30s
 5) disable the watchdog
 6) set the timeout to 10sec
 7) check the watchdog triggers after 10sec and not before.

Can you confirm that Steve?

thanks,
Marco

> Guenter
> 
> > +	if (ret)
> > +		dev_warn(da9063->dev, "Failed to reset watchdog counter\n");
> > +
> >   	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> >   				  DA9063_TWDSCALE_MASK, regval);
> >   }
> > @@ -85,8 +117,7 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
> >   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
> >   	int ret;
> > -	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> > -			   DA9063_WATCHDOG);
> > +	ret = _da9063_wdt_reset_timer(da9063);
> >   	if (ret)
> >   		dev_alert(da9063->dev, "Failed to ping the watchdog (err = %d)\n",
> >   			  ret);
> > 
> 
> 
