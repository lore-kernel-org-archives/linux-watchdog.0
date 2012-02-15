Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51582 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392Ab2BONyX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Feb 2012 08:54:23 -0500
Date: Wed, 15 Feb 2012 14:54:13 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 2/3] i2c: Add Congatec CGEB I2C driver
Message-ID: <20120215135413.GD3852@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-3-git-send-email-s.hauer@pengutronix.de>
 <20120207101016.GB2539@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120207101016.GB2539@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 07, 2012 at 11:10:16AM +0100, Wolfram Sang wrote:
> Hi Sascha,
> 
> > +config I2C_CONGATEC_CGEB
> > +	tristate "Congatec CGEB I2C driver"
> > +	depends on MFD_CONGATEC_CGEB
> > +	help
> > +	  This driver provides support for the I2C busses accssable via
> > +	  the Congatec CGEB interface found on Congatec boards.
> > +
> 
> Please keep the sorting (eg20t is wrong and will be fixed).
> 
> > +		ret = cgeb_call(priv->board, &fps, CgebI2CTransfer);
> > +		if (ret) {
> > +			ret = -EREMOTEIO;
> > +			goto out;
> > +		}
> 
> -EREMOTEIO is not present in Documentation/i2c/fault-codes. Please use
> one from that file.

-EIO?

> 
> > +	ret = cgeb_i2c_set_speed(priv, 400000);
> > +	if (ret)
> > +		/*
> > +		 * not a critical error, we can continue with the default speed.
> > +		 */
> > +		dev_warn(&pdev->dev, "Could not set speed to 400KHz\n");
> 
> Is it possible to make this configurable? Not all I2C devices support
> 400KHz, 100KHz is OK.

Yes, it is. The problem is more *how* it should be configurable.
Exposing it via sysfs is the only reasonable option I can think
of.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
