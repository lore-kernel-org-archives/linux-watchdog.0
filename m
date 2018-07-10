Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeGJHG7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 03:06:59 -0400
Date: Tue, 10 Jul 2018 09:06:43 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
Message-ID: <20180710070643.gyxk2oc6qvo7fnk3@pengutronix.de>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
 <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
 <20180709161924.GA4595@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709161924.GA4595@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

adding Wolfram to Cc who authored the watchdog bits in the rtc driver.

On Mon, Jul 09, 2018 at 09:19:24AM -0700, Guenter Roeck wrote:
> On Mon, Jul 09, 2018 at 10:30:41AM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Sat, Jun 09, 2018 at 08:43:13AM +0200, Uwe Kleine-König wrote:
> > > As pointed out in the added comment resetting the rtc also stops the
> > > included watchdog. This is bad if the bootloader started the watchdog to
> > > secure the boot process. So don't reset if the watchdog is running.
> > 
> > I didn't get any feedback for this patch yet. Assuming my patch is
> > considered ok, my expectation would be that the watchdog people ack it
> > and that then it goes in via the rtc tree.
> > 
> 
> Guess there was a good reason for not passing an accessor via regmap ?

I don't know the details, but maybe this concept wasn't picked because
just passing a single function for setting the timeout was considered
simpler. Also given that the registers for wdg and rtc are not separated
cleanly giving the wdg driver a regmap isn't "nice" IMHO.

Last time I worked on this driver I wondered if it would be cleaner to
merge both drivers into drivers/rtc as the relevant functionality
(stmp3xxx_wdt_set_timeout()) is in that driver anyhow and
drivers/watchdog/stmp3xxx_rtc_wdt.c mostly contains stuff to handle the
separation. Oh, and there is a reboot notifier that looks strange where
I wonder if it is really needed.

> Either case, stmp_reset_block() is also called from resume, meaning the
> watchdog, if running, will likely be disabled by a suspend/resume cycle.

Yeah, that's right. The watchdog driver has the corresponding callbacks
and restarts the timer on resume though.

> I have no idea why the rtc block is reset in the first place;
> one would assume that there was a reason for that.

The usual reason is to ensure a clean hardware state. I wouldn't expect
a deeper reason here. (And if there is one, and removing it really
breaks something, the right way forward is to reintroduce the reset with
an explaining comment and think about how to fix the watchdog issue I
fixed in another way.)

> The associated watchdog driver does not support telling the watchdog
> core that the watchdog is running. As such, a watchdog running at boot
> will only be handled if the watchdog daemon is started before the
> watchdog times out. I assume this is understood and acceptable.

Yeah, that's the use case we have.

> Given all that, and taking no responsibility for the actual impact
> of the changes, I can only confirm that the patch looks syntactically
> correct.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
