Return-Path: <groeck7@gmail.com>
Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@arm.linux.org.uk>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 4/6] watchdog: moxart: Register restart handler with restart notifier
Date: Mon, 30 Jun 2014 12:11:37 -0700
Message-Id: <1404155499-21177-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The kernel now provides an API to trigger a system restart.
Register with it instead of setting arm_pm_restart.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/moxart_wdt.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 4aa3a8a..9a862bf 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -15,12 +15,12 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 
-#include <asm/system_misc.h>
-
 #define REG_COUNT			0x4
 #define REG_MODE			0x8
 #define REG_ENABLE			0xC
@@ -35,13 +35,20 @@ static struct moxart_wdt_dev *moxart_restart_ctx;
 
 static int heartbeat;
 
-static void moxart_wdt_restart(enum reboot_mode reboot_mode, const char *cmd)
+static int moxart_restart_notify(struct notifier_block *this, unsigned long mode,
+				 void *cmd)
 {
 	writel(1, moxart_restart_ctx->base + REG_COUNT);
 	writel(0x5ab9, moxart_restart_ctx->base + REG_MODE);
 	writel(0x03, moxart_restart_ctx->base + REG_ENABLE);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block moxart_restart_notifier = {
+	.notifier_call = moxart_restart_notify,
+};
+
 static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
@@ -137,7 +144,9 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 		return err;
 
 	moxart_restart_ctx = moxart_wdt;
-	arm_pm_restart = moxart_wdt_restart;
+	err = register_restart_notifier(&moxart_restart_notifier);
+	if (err)
+		dev_err(dev, "cannot register reset notifier (err=%d)\n", err);
 
 	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
 		moxart_wdt->dev.timeout, nowayout);
@@ -149,9 +158,8 @@ static int moxart_wdt_remove(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
 
-	arm_pm_restart = NULL;
+	unregister_restart_notifier(&moxart_restart_notifier);
 	moxart_wdt_stop(&moxart_wdt->dev);
-	watchdog_unregister_device(&moxart_wdt->dev);
 
 	return 0;
 }
-- 
1.9.1
