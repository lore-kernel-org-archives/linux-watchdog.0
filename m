Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45418 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbdLXVEf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:35 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by hardware
Date: Sun, 24 Dec 2017 13:04:16 -0800
Message-Id: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the watchdog control register indicates that the watchdog hardware
is disabled even after we tried to enable it, there is no point to
instantiate the driver.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 8 +++++++-
 drivers/watchdog/sp5100_tco.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index bb6c4608c1c0..23246cb40598 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -273,14 +273,20 @@ static int sp5100_tco_setupdevice(struct device *dev,
 	/* Setup the watchdog timer */
 	tco_timer_enable();
 
-	/* Check that the watchdog action is set to reset the system */
 	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
+	if (val & SP5100_WDT_DISABLED) {
+		dev_err(dev, "Watchdog hardware is disabled\n");
+		ret = -ENODEV;
+		goto unreg_region;
+	}
+
 	/*
 	 * Save WatchDogFired status, because WatchDogFired flag is
 	 * cleared here.
 	 */
 	if (val & SP5100_WDT_FIRED)
 		wdd->bootstatus = WDIOF_CARDRESET;
+	/* Set watchdog action to reset the system */
 	val &= ~SP5100_WDT_ACTION_RESET;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
index ca0721c8d879..008b2094bd13 100644
--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -19,6 +19,7 @@
 #define SP5100_WDT_START_STOP_BIT	BIT(0)
 #define SP5100_WDT_FIRED		BIT(1)
 #define SP5100_WDT_ACTION_RESET		BIT(2)
+#define SP5100_WDT_DISABLED		BIT(3)
 #define SP5100_WDT_TRIGGER_BIT		BIT(7)
 
 #define SP5100_PM_IOPORTS_SIZE		0x02
-- 
2.7.4

