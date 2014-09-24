Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:19904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751020AbaIXCYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Sep 2014 22:24:19 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] watchdog: imx2_wdt: Add power management support.
Date: Wed, 24 Sep 2014 02:24:15 +0000
Message-ID: <2f682a54aa71439bb8e4d04ff10ce49d@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1411475513-2576-1-git-send-email-Li.Xiubo@freescale.com>
 <20140923160957.GB20591@roeck-us.net>
In-Reply-To: <20140923160957.GB20591@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,


[...]
> > +#ifdef CONFIG_PM_SLEEP
> > +/* Disable watchdog if it is active or non-active but still running */
> > +static int imx2_wdt_suspend(struct device *dev)
> > +{
> > +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> > +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> > +
> > +	imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> > +	imx2_wdt_ping(wdog);
> 
> I am a bit concerned about this one. Why ping the watchdog if it is
> not running ? Shouldn't this only be done if the watchdog is running ?
>

Since the IMX2 watchdog will be always alive once started until power down
it.

Even not running, these code doesn't make any sense actually, and When probe,
the clock has been enabled, so we can feel safe of doing this.


> > +
> > +	/* Watchdog has been stopped but IP block is still running */
> > +	if (!watchdog_active(wdog) && imx2_wdt_is_running(wdev))
> > +		del_timer_sync(&wdev->timer);
> > +
> > +	/* If PM will be supported using imx2_wdt, please
> > +	 * make sure that the wdev->clk could disable the
> > +	 * watchdog's counter input clock source or can mask
> > +	 * watchdog's reset request to the core.
> > +	 */
> 
> As far as I know, the watchdog subsystem uses standard multi-line comments.
> 
Okay, I will revise this.

> I am not sure if such a comment in the code will help. People don't usually
> read code to find out why the watchdog resets the board in suspend even
> if it should not.
> 
> Can you detect this condition programmatically (presumably that the clock
> was stopped if I understand correctly) to ensure that it is met ?
> 

IMO, all the SoCs using this watchdog didn't support PM for now through the
watchdog reference manual document and the current driver, because once started,
we couldn't stop the counter decreasing down to zero without disabling the counter
clock. 

What we actually care about is disabling the input clock source for counter, if
We cannot disable this, the watchdog will reset the core when sleeping. Or if we
can gate the reset signal to the cores is also one good choice.
But these cannot be programmatically to be ensured using one common way for all
SoCs.


> > +	clk_disable_unprepare(wdev->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Enable watchdog and configure it if necessary */
> > +static int imx2_wdt_resume(struct device *dev)
> > +{
> > +	struct watchdog_device *wdog = dev_get_drvdata(dev);
> > +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> > +
> > +	clk_prepare_enable(wdev->clk);
> > +
> > +	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
> > +		/* If watchdog is still used by consumers and
> > +		 * resumes from deep sleep state, need to
> > +		 * restart the watchdog again.
> > +		 */
> > +		imx2_wdt_setup(wdog);
> > +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> > +		imx2_wdt_ping(wdog);
> > +	} else if (imx2_wdt_is_running(wdev)) {
> > +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> > +		imx2_wdt_ping(wdog);
> > +		/* If watchdog has started --> stopped by the
> > +		 * consumers and resumes from non-deep sleep state,
> > +		 * then start the timer again.
> > +		 */
> > +		if (!watchdog_active(wdog))
> > +			mod_timer(&wdev->timer,
> > +				  jiffies + wdog->timeout * HZ / 2);
> > +	} else {
> > +		/* If watchdog has been started --> stopped by
> > +		 * the consumers and resumes from deep sleep state,
> > +		 * will do nothing. The watchdog will be restarted
> > +		 * by consumers next time to be used.
> > +		 */
> 
> I really dislike the notion of an else case just for a comment.
> It should be obvious that nothing needs to be done here if the watchdog
> is not running.
> 
Yes, I will remove this.


Thanks,

BRs
Xiubo


> > +	}
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
> > +			 imx2_wdt_resume);
> > +
> >  static const struct of_device_id imx2_wdt_dt_ids[] = {
> >  	{ .compatible = "fsl,imx21-wdt", },
> >  	{ /* sentinel */ }
> > @@ -307,6 +372,7 @@ static struct platform_driver imx2_wdt_driver = {
> >  	.driver		= {
> >  		.name	= DRIVER_NAME,
> >  		.owner	= THIS_MODULE,
> > +		.pm     = &imx2_wdt_pm_ops,
> >  		.of_match_table = imx2_wdt_dt_ids,
> >  	},
> >  };
> > --
> > 2.1.0.27.g96db324
> >
