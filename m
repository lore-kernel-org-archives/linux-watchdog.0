Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:41320 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbCBH4q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Mar 2015 02:56:46 -0500
Received: by widex7 with SMTP id ex7so12652868wid.0
        for <linux-watchdog@vger.kernel.org>; Sun, 01 Mar 2015 23:56:45 -0800 (PST)
Date: Mon, 2 Mar 2015 07:56:41 +0000
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH v3 5/8] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
Message-ID: <20150302075641.GA17486@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-6-git-send-email-lee.jones@linaro.org>
 <20150223102526.GB14142@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223102526.GB14142@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Mon, 23 Feb 2015, Peter Griffin wrote:

> Hi Lee,

I noticed you sent another version, but I didn't see a reply on this point below.

As your now doing a re-spin for Pauls comments, I thought I would send a reminder
just in case you hadn't seen it.

regards,

Peter.

> 
> <snip>
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static int st_wdog_suspend(struct device *dev)
> > +{
> > +	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
> > +
> > +	if (watchdog_active(&st_wdog_dev))
> > +		st_wdog_stop(&st_wdog_dev);
> > +
> > +	st_wdog_setup(st_wdog, false);
> 
> I was expecting the suspend / resume callbacks would be disabling / enabling
> the IP clock.
> 
> Is there a reason why it doesn't?
> 
> From looking at the code by this point the watchdog has already been disabled so gating
> the IP seems reasonable.
> 
> regards,
> 
> Peter
