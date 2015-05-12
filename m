Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 05/12] watchdog: st_wdt: Update IP layout information to include Clocksource
Date: Tue, 12 May 2015 13:58:13 +0100
Message-Id: <1431435500-22899-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Initial submission adding support for this IP only included Watchdog and
the Real-Time Clock.  Now the third (and final) device is enabled this
trivial patch is required to update the comment in the Watchdog driver
to encompass Clocksource.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
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
