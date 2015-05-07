Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34056 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbbEGNjA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:39:00 -0400
Received: by wgic8 with SMTP id c8so17343265wgi.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:38:59 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/12] watchdog: st_wdt: Update IP layout information to include Clocksource
Date: Thu,  7 May 2015 14:38:37 +0100
Message-Id: <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Initial submission adding support for this IP only included Watchdog and
the Real-Time Clock.  Now the third (and final) device is enabled this
trivial patch is required to update the comment in the Watchdog driver
to encompass Clocksource.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/watchdog/st_lpc_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index f32be15..6785afd 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -197,7 +197,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* LPC can either run in RTC or WDT mode */
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
 	if (mode != ST_LPC_MODE_WDT)
 		return -ENODEV;
 
-- 
1.9.1

