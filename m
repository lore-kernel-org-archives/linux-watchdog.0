Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44586 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab2BONlb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Feb 2012 08:41:31 -0500
Date: Wed, 15 Feb 2012 14:41:22 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/3] watchdog: Add Congatec CGEB watchdog driver
Message-ID: <20120215134122.GC3852@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-4-git-send-email-s.hauer@pengutronix.de>
 <20120207150856.GI2539@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120207150856.GI2539@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2012 at 04:08:56PM +0100, Wolfram Sang wrote:
> Hi Sascha,
> 
> > +struct cgeb_watchdog_stage {
> > +	unsigned long timeout;
> > +	unsigned long event;
> > +};
> > +
> > +struct cgeb_watchdog_config {
> > +	unsigned long size;
> > +	unsigned long timeout; /* not used in staged mode */
> > +	unsigned long delay;
> > +	unsigned long mode;
> > +	/* optional parameters for staged watchdog */
> > +	unsigned long op_mode;
> > +	unsigned long stage_count;
> > +	struct cgeb_watchdog_stage stages[CGOS_WDOG_EVENT_MAX_STAGES];
> > +};
> > +
> 
> There is some unused stuff in here.

It's the hardware, or more precisely the BIOS that dictates the layout
of this structure. Given that, the members should be u32 rather than
unsigned long.

> 
> > +struct cgeb_watchdog_priv {
> > +	struct cgeb_board_data	*board;
> > +	struct watchdog_device	wdd;
> > +	unsigned int		timeout_s;
> 
> Is wdd->timeout not sufficent?

I wasn't aware such a field exists. Yes, that should work

> 
> > +	int unit;
> > +};
> > +
> > +static int cgeb_watchdog_set_timeout(struct watchdog_device *wdd,
> > +		unsigned int timeout_s)
> > +{
> > +	struct cgeb_watchdog_priv *priv = watchdog_get_drvdata(wdd);
> > +
> > +	if (!timeout_s)
> > +		return -EINVAL;
> 
> Is this possible? You have min_timeout = 1.

Nope, I think we can remove this line.

> 
> > +static int __devinit cgeb_watchdog_probe(struct platform_device *pdev)
> > +{
> > +	struct cgeb_watchdog_priv *priv;
> > +	struct cgeb_pdata *pdata = pdev->dev.platform_data;
> > +	int ret;
> > +
> > +	dev_info(&pdev->dev, "registering\n");
> 
> "registered" on success would be more useful?
> 
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->wdd.ops = &cgeb_watchdog_ops;
> > +	priv->wdd.info = &cgeb_wdd_info;
> > +	priv->wdd.min_timeout = 1;
> > +	priv->wdd.max_timeout = 3600;
> > +	priv->board = pdata->board;
> > +	priv->unit = pdata->unit;
> > +
> > +	watchdog_set_drvdata(&priv->wdd, priv);
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	ret = watchdog_register_device(&priv->wdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> return watchdog_register_device();

These comments are mutually exclusive ;)

I'll move the dev_info to here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
