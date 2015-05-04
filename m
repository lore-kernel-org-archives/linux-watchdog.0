Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50926 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbEDQJR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 12:09:17 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YpIvk-001Q2d-KE
	for linux-watchdog@vger.kernel.org; Mon, 04 May 2015 16:09:16 +0000
Date: Mon, 4 May 2015 09:08:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core
 extensions
Message-ID: <20150504160812.GC9602@roeck-us.net>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
 <20150503185601.GD25193@pengutronix.de>
 <55470AA7.9050605@offcode.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55470AA7.9050605@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 04, 2015 at 08:59:03AM +0300, Timo Kokkonen wrote:
> Hi, 03.05.2015 21:56, Uwe Kleine-König wrote:
> >Hello,
> >
> >On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
> >>Use the new watchdog core extensions to let watchdog core take over
> >>boot time watchdog behavior. The difference is that early-timeout-sec
> >>device tree property becomes available for this driver and a running
> >>watchdog is not stopped unless the core decides to stop it.
> >>
> >>Omap watchdog is running by default in the boot up but bootloader
> >>might have stopped it. Therefore we fill the WDOG_HW_RUNNING_AT_BOOT
> >>bit depending on the actual watchdog state so that the watchdog core
> >>can act properly.
> >>
> >>Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> >>---
> >>  drivers/watchdog/omap_wdt.c | 28 +++++++++++++++++++++++++++-
> >>  1 file changed, 27 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> >>index bbaf39a..7164f2e 100644
> >>--- a/drivers/watchdog/omap_wdt.c
> >>+++ b/drivers/watchdog/omap_wdt.c
> >>@@ -78,6 +78,13 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
> >>  	/* reloaded WCRR from WLDR */
> >>  }
> >>
> >>+static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
> >>+{
> >>+	void __iomem *base = wdev->base;
> >>+
> >>+	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
> >>+}
> >This isn't reliable. The sequence needed to enable the watchdog is
> >	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
> >	writel(0x4444, base + OMAP_WATCHDOG_SPR);
> >
> >The sequence to stop is:
> >	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
> >	writel(0x5555, base + OMAP_WATCHDOG_SPR);
> >
> >But:
> >
> >barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
> >44e35048: 00005555                                           UU..
> >barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
> >barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
> >44e35048: 00004444                                           DD..
> >
> >So the register contains 0x4444 but the timer doesn't run. So at best
> >testing for 0x4444 is a good heuristic.
> 
> Yeah.. I don't think we can get any better than that. Unless we start
> checking the counter register and see whether it really counts or not, and I
> think that's a bit overkill.. So I'd say we should be safe when assuming

You sure ? I would prefer Uwe's suggestion to check the counter

> bootloader is doing things correctly. Although, we could add a comment to

... because I don't really trust the bootloader that much. If people are not
happy with the resulting 4ms added boot time, they should fix the hardware.

Otherwise we'll have to deal with people submitting bug reports because their
system experiences "unexpected" resets, and I don't really want to have to deal
with this.

Guenter
