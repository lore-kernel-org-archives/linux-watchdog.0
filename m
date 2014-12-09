Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] watchdog: da9063: Add restart handler support
Date: Tue,  9 Dec 2014 12:22:46 +0100
Message-Id: <1418124169-7123-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

Register a restart handler for the da9063 watchdog.  System restart is
triggered by sending the shutdown command to the PMIC.
As more-suitable restart handlers may exist, the priority of the
watchdog restart handler is set to 128.

The actual restart method was inspired by a platform-specific patch from
the BSP by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on r8a7791/koelsch
---
 drivers/watchdog/da9063_wdt.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 2cd6b2c2dd2a6980..e2fe2ebdebd4d6bb 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 /*
@@ -38,6 +39,7 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
+	struct notifier_block restart_handler;
 };
 
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
@@ -119,6 +121,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
+static int da9063_wdt_restart_handler(struct notifier_block *this,
+				      unsigned long mode, void *cmd)
+{
+	struct da9063_watchdog *wdt = container_of(this,
+						   struct da9063_watchdog,
+						   restart_handler);
+	int ret;
+
+	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+			   DA9063_SHUTDOWN);
+	if (ret)
+		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
+			  ret);
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_info da9063_watchdog_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = "DA9063 Watchdog",
@@ -163,14 +182,25 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, wdt);
 
 	ret = watchdog_register_device(&wdt->wdtdev);
+	if (ret)
+		return ret;
 
-	return ret;
+	wdt->restart_handler.notifier_call = da9063_wdt_restart_handler;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret)
+		dev_err(wdt->da9063->dev,
+			"Failed to register restart handler (err = %d)\n", ret);
+
+	return 0;
 }
 
 static int da9063_wdt_remove(struct platform_device *pdev)
 {
 	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
 
+	unregister_restart_handler(&wdt->restart_handler);
+
 	watchdog_unregister_device(&wdt->wdtdev);
 
 	return 0;
-- 
1.9.1
