Return-path: <j.uzycki@elproma.com.pl>
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 3/6] stmp3xxx_rtc_wdt: Add suspend/resume PM support
Date: Mon, 22 Sep 2014 22:55:47 +0200
Message-Id: <1411419350-1297-3-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
List-ID: <linux-watchdog@vger.kernel.org>

There is no conflict with rtc/rtc-stmp3xxx.c parent
because modified registers in PM functions of stmp3xxx_rtc_wdt
are different.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index b4d6b34..77936b6 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -95,9 +95,33 @@ static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdd = &stmp3xxx_wdd;
+
+	if (watchdog_active(wdd))
+		return wdt_stop(wdd);
+
+	return 0;
+}
+
+static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdd = &stmp3xxx_wdd;
+
+	if (watchdog_active(wdd))
+		return wdt_start(wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
+			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
+
 static struct platform_driver stmp3xxx_wdt_driver = {
 	.driver = {
 		.name = "stmp3xxx_rtc_wdt",
+		.pm = &stmp3xxx_wdt_pm_ops,
 	},
 	.probe = stmp3xxx_wdt_probe,
 	.remove = stmp3xxx_wdt_remove,
-- 
1.7.11.3
