Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:36992 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755306Ab1KVSKE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Nov 2011 13:10:04 -0500
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id C86BADCA2FC
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Nov 2011 19:16:23 +0100 (CET)
Date: Tue, 22 Nov 2011 19:09:49 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: w.sang@pengutronix.de
Cc: Wim@vger.kernel.org, wim@iguana.be, Welte@vger.kernel.org,
	Van@vger.kernel.org, Sebroeck@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	HaraldWelte@viatech.com, Harald@vger.kernel.org
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <4ecbe56d.0B7WEVDKkK1s88MJ%marc.vertes@sigfox.com>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
 <20111122112212.GD2734@pengutronix.de>
 <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com>
 <20111122173029.GA14349@pengutronix.de>
In-Reply-To: <20111122173029.GA14349@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wolfram Sang <w.sang@pengutronix.de> wrote:

> > +	dev_info(&pdev->dev, "VIA Chipset watchdog MMIO: %x\n", mmio);
> > +	if (mmio == 0) {
> > +		dev_err(&pdev->dev, "watchdog timer is not enabled in BIOS\n");
> > +		return -ENODEV;
> > +	}
>
> What about
>
> 	if (mmio != 0) {
> 		dev_info("VIA Chipset...")
> 	} else {
> 		dev_err()
> 		return -ENODEV;
> 	}
>
> to only have the needed printouts.
>
Ok.

> > +	ret = watchdog_register_device(&wdt_dev);
> > +	if (ret)
> > +		return ret;
>
> You need to iounmap in the error-case.
Yes. Good catch.

>
> > +	watchdog_set_drvdata(&wdt_dev, wdt_mem);
> > +	if (readl(wdt_mem) & VIA_WDT_FIRED) {
> > +		wdt_dev.bootstatus |= WDIOF_CARDRESET;
> > +		dev_notice(&pdev->dev, "restarted by expired watchdog\n");
>
> Skip the printout. This can be detected using CARDRESET.
>
Ok.

> > +/*
> > + * The driver has not been tested yet on CX700 and VX800.
> > + */
>
> Then, I'd rather skip this comment and the IDs. Or if you are sure enough it
> works, leave them in ;) Best option would be testers showing up.
>
Then I take the risk and remove the comments ;). This is stable stuff inherited
from old models...

> Regards,
>
>    Wolfram
>
Thanks for your comments, I'm preparing an update.
--
Marc
