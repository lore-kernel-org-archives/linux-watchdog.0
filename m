Return-path: <groeck@chromium.org>
From: Guenter Roeck <groeck@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	Grant Grundler <grundler@chromium.org>
Subject: [PATCH] watchdog: qcom: Report reboot reason
Date: Mon,  4 Apr 2016 17:37:46 -0700
Message-Id: <1459816666-87185-1-git-send-email-groeck@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

The Qualcom watchdog timer block reports if the system was reset by the
watchdog. Pass the information to user space.

Cc: Grant Grundler <grundler@chromium.org>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
---
 drivers/watchdog/qcom-wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 20563cc..a043fa4 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -21,6 +21,7 @@
 
 #define WDT_RST		0x38
 #define WDT_EN		0x40
+#define WDT_STS		0x44
 #define WDT_BITE_TIME	0x5C
 
 struct qcom_wdt {
@@ -108,7 +109,8 @@ static const struct watchdog_ops qcom_wdt_ops = {
 static const struct watchdog_info qcom_wdt_info = {
 	.options	= WDIOF_KEEPALIVEPING
 			| WDIOF_MAGICCLOSE
-			| WDIOF_SETTIMEOUT,
+			| WDIOF_SETTIMEOUT
+			| WDIOF_CARDRESET,
 	.identity	= KBUILD_MODNAME,
 };
 
@@ -171,6 +173,9 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
 	wdt->wdd.parent = &pdev->dev;
 
+	if (readl(wdt->base + WDT_STS) & 1)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
 	 * default, unless the max timeout is less than 30 seconds, then use
-- 
2.8.0.rc3.226.g39d4020
