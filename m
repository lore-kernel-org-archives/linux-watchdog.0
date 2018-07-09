Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34969 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbeGIQT2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jul 2018 12:19:28 -0400
Date: Mon, 9 Jul 2018 09:19:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
Message-ID: <20180709161924.GA4595@roeck-us.net>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
 <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 09, 2018 at 10:30:41AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jun 09, 2018 at 08:43:13AM +0200, Uwe Kleine-König wrote:
> > As pointed out in the added comment resetting the rtc also stops the
> > included watchdog. This is bad if the bootloader started the watchdog to
> > secure the boot process. So don't reset if the watchdog is running.
> 
> I didn't get any feedback for this patch yet. Assuming my patch is
> considered ok, my expectation would be that the watchdog people ack it
> and that then it goes in via the rtc tree.
> 

Guess there was a good reason for not passing an accessor via regmap ?

Either case, stmp_reset_block() is also called from resume, meaning the
watchdog, if running, will likely be disabled by a suspend/resume cycle.

I have no idea why the rtc block is reset in the first place;
one would assume that there was a reason for that.

The associated watchdog driver does not support telling the watchdog
core that the watchdog is running. As such, a watchdog running at boot
will only be handled if the watchdog daemon is started before the
watchdog times out. I assume this is understood and acceptable.

Given all that, and taking no responsibility for the actual impact
of the changes, I can only confirm that the patch looks syntactically
correct.

Acked-by: Guenter Roeck <linux@roeck-us.net>

I would suggest, however, that it might make more sense to have someone
who knows the chip and the systems using it confirm that the change
is appropriate and will not cause any problems.

Thanks,
Guenter

> Best regards
> Uwe
> 
> > diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> > index d578e40d5a50..b76318fd5bb0 100644
> > --- a/drivers/rtc/rtc-stmp3xxx.c
> > +++ b/drivers/rtc/rtc-stmp3xxx.c
> > @@ -288,10 +288,22 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, rtc_data);
> >  
> > -	err = stmp_reset_block(rtc_data->io);
> > -	if (err) {
> > -		dev_err(&pdev->dev, "stmp_reset_block failed: %d\n", err);
> > -		return err;
> > +	/*
> > +	 * Resetting the rtc stops the watchdog timer that is potentially
> > +	 * running. So (assuming it is running on purpose) don't reset if the
> > +	 * watchdog is enabled.
> > +	 */
> > +	if (readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
> > +	    STMP3XXX_RTC_CTRL_WATCHDOGEN) {
> > +		dev_info(&pdev->dev,
> > +			 "Watchdog is running, skip resetting rtc\n");
> > +	} else {
> > +		err = stmp_reset_block(rtc_data->io);
> > +		if (err) {
> > +			dev_err(&pdev->dev, "stmp_reset_block failed: %d\n",
> > +				err);
> > +			return err;
> > +		}
> >  	}
> >  
> >  	/*
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
