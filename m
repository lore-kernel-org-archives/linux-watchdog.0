Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43239 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbECS4H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 May 2015 14:56:07 -0400
Date: Sun, 3 May 2015 20:56:01 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core
 extensions
Message-ID: <20150503185601.GD25193@pengutronix.de>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
> Use the new watchdog core extensions to let watchdog core take over
> boot time watchdog behavior. The difference is that early-timeout-sec
> device tree property becomes available for this driver and a running
> watchdog is not stopped unless the core decides to stop it.
> 
> Omap watchdog is running by default in the boot up but bootloader
> might have stopped it. Therefore we fill the WDOG_HW_RUNNING_AT_BOOT
> bit depending on the actual watchdog state so that the watchdog core
> can act properly.
> 
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
>  drivers/watchdog/omap_wdt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index bbaf39a..7164f2e 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -78,6 +78,13 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
>  	/* reloaded WCRR from WLDR */
>  }
>  
> +static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
> +{
> +	void __iomem *base = wdev->base;
> +
> +	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
> +}
This isn't reliable. The sequence needed to enable the watchdog is
	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
	writel(0x4444, base + OMAP_WATCHDOG_SPR);

The sequence to stop is:
	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
	writel(0x5555, base + OMAP_WATCHDOG_SPR);

But:

barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
44e35048: 00005555                                           UU..
barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
44e35048: 00004444                                           DD..

So the register contains 0x4444 but the timer doesn't run. So at best
testing for 0x4444 is a good heuristic.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
