Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34180 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdGQRMe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 13:12:34 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: asm9260_wdt: don't round closest with get_timeleft
Date: Mon, 17 Jul 2017 19:12:24 +0200
Message-Id: <20170717171224.13444-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We should never return more time left than there actually is. So, switch
to a plain divider instead of DIV_ROUND_CLOSEST.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This is similar to a patch for the renesas-rwdt[1]. I think it makes sense to
remove this pattern from the whole subsystem, if we can agree on the behaviour
stated in the patch description. So, this is the other driver using
DIV_ROUND_CLOSEST.

Note: This driver and the lpc18xx_wdt.c extremly likely drive the same IP core.
They would ideally be merged.

[1] https://patchwork.kernel.org/patch/9845459/

 drivers/watchdog/asm9260_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 53da001f0838ee..f40dd71c904bef 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -82,7 +82,7 @@ static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wdd)
 
 	counter = ioread32(priv->iobase + HW_WDTV);
 
-	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
+	return counter / priv->wdt_freq;
 }
 
 static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
-- 
2.11.0

