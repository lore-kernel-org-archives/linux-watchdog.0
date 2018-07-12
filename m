Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:55069 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeGLJjm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Jul 2018 05:39:42 -0400
Date: Thu, 12 Jul 2018 11:30:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
Message-ID: <20180712093045.GB16084@piout.net>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
 <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/07/2018 10:30:41+0200, Uwe Kleine-König wrote:
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

I actually applied it a while ago and forgot to say so. I've included
Guenter's ack now.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
