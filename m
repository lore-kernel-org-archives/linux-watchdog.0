Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38289 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbEGNjD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:39:03 -0400
Received: by wiun10 with SMTP id n10so60268551wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:39:02 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/12] rtc: st: Update IP layout information to include Clocksource
Date: Thu,  7 May 2015 14:38:39 +0100
Message-Id: <1431005924-21777-8-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Initial submission adding support for this IP only included Watchdog and
the Real-Time Clock.  Now the third (and final) device is enabled this
trivial patch is required to update the comment in the RTC driver to
encompass Clocksource.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/rtc/rtc-st-lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 3f9d0ac..74c0a33 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -208,7 +208,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* LPC can either run in RTC or WDT mode */
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
 	if (mode != ST_LPC_MODE_RTC)
 		return -ENODEV;
 
-- 
1.9.1

