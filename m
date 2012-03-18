Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43894 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab2CRLKp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 18 Mar 2012 07:10:45 -0400
Received: by lbbgm6 with SMTP id gm6so2771164lbb.19
        for <linux-watchdog@vger.kernel.org>; Sun, 18 Mar 2012 04:10:43 -0700 (PDT)
Date: Sun, 18 Mar 2012 13:09:52 +0200
From: Mika Westerberg <mika.westerberg@iki.fi>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, rmallon@gmail.com,
	hsweeten@visionengravers.com
Subject: Re: watchdog: Convert ep93xx driver to watchdog core
Message-ID: <20120318110952.GA27808@mwesterb-mobl.ger.corp.intel.com>
References: <201203141031.50746.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201203141031.50746.hartleys@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 14, 2012 at 10:31:50AM -0700, H Hartley Sweeten wrote:
> Convert the ep93xx_wdt driver to the watchdog framework API.
> 
> Also, use the dev_<fmt> functions instead of pr_<fmt> for logging.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

While testing this I noticed that you missed to set the initial timeout of the
wdt device. Otherwise doing WDIOC_GETTIMEOUT fails.

With that fixed,

Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Tested-by: Mika Westerberg <mika.westerberg@iki.fi>

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 414ce8f..29575f8 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -139,6 +139,7 @@ static int __devinit ep93xx_wdt_probe(struct platform_device *pdev)
 
 	val = readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
+	ep93xx_wdt_wdd.timeout = timeout;
 
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
 
