Return-Path: <neidhard.kim@lge.com>
Return-path: <neidhard.kim@lge.com>
From: Jongsung Kim <neidhard.kim@lge.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>,
	Jongsung Kim <neidhard.kim@lge.com>
Subject: [PATCH v2] watchdog: sp805: add restart handler
Date: Wed,  2 May 2018 16:59:39 +0900
Message-Id: <1525247979-23156-1-git-send-email-neidhard.kim@lge.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add restart handler for SP805 watchdog so that the driver can be
used to reboot the system.

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp805_wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 03805bc..969369e 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -121,6 +121,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 	return div_u64(load, rate);
 }
 
+static int
+wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
+{
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	writel_relaxed(0, wdt->base + WDTCONTROL);
+	writel_relaxed(0, wdt->base + WDTLOAD);
+	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
+
+	return 0;
+}
+
 static int wdt_config(struct watchdog_device *wdd, bool ping)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -197,6 +209,7 @@ static const struct watchdog_ops wdt_ops = {
 	.ping		= wdt_ping,
 	.set_timeout	= wdt_setload,
 	.get_timeleft	= wdt_timeleft,
+	.restart	= wdt_restart,
 };
 
 static int
-- 
2.7.4
