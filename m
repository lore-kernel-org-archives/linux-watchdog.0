Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phycard.de ([217.6.246.34]:55942 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860AbcGENYv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:51 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 6/6] watchdog: da9063_wdt: add schedule-free and race-free restart handler
Date: Tue, 5 Jul 2016 15:22:23 +0200
Message-Id: <1467724943-13416-7-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/watchdog/da9063_wdt.c | 87 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index a32f2cd..b9feef9 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
 #include <linux/reboot.h>
@@ -41,6 +42,7 @@ struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
 	struct notifier_block restart_handler;
+	struct notifier_block reboot_notifier;
 	struct delayed_work ping_work;
 	unsigned long j_time_stamp;
 };
@@ -188,19 +190,83 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
+static int da9063_wdt_reboot_notifier(struct notifier_block *this, unsigned long val, void *v)
+{
+	struct da9063_watchdog *wdt = container_of(this,
+						   struct da9063_watchdog,
+						   reboot_notifier);
+	struct i2c_adapter *adap = wdt->da9063->i2c->adapter;
+
+	/*
+	 * First block the I2C bus for other drivers. Other consumers are not
+	 * allowed to access the bus now.
+	 */
+	adap->blocked = true;
+
+	/*
+	 * Then acquire adapter lock. This will wait until all other consumers
+	 * have finished.  After that no more writes are possible for other
+	 * drivers.
+	 */
+	i2c_lock_adapter(adap);
+
+	/*
+	 * Now the I2C adapter can be used in contexts that are not allowed to
+	 * wait for locks or call schedule() because there is no other
+	 * consumer.
+	 */
+	return NOTIFY_DONE;
+}
+
 static int da9063_wdt_restart_handler(struct notifier_block *this,
 				      unsigned long mode, void *cmd)
 {
 	struct da9063_watchdog *wdt = container_of(this,
 						   struct da9063_watchdog,
 						   restart_handler);
-	int ret;
+	int ret, i;
+	struct i2c_adapter *adap = wdt->da9063->i2c->adapter;
+	unsigned char data[3] = {DA9063_REG_CONTROL_F,
+				 DA9063_SHUTDOWN,
+				 0x0};
+	struct i2c_msg msg = { .addr = wdt->da9063->i2c->addr,
+			       .flags = 0,
+			       .len = sizeof(data),
+			       .buf = data };
+
+	/* Very special calling context:
+	 *  - other CPU cores already stopped
+	 *  - But tasks on first cpu still running
+	 *  - Other tasks may have acquired locks that will never be released
+	 *  - Cleanup doesn't matter anymore. Execution may stop at any
+	 *    instruction now.
+	 *  - Current task can stall the CPU. Not to worried about
+	 *    concurrent access from other tasks or CPUs.
+	 *  - You have to avoid any kernel internal function which calls
+	 *     schedule().  Otherwise other tasks will run and interfere.
+	 */
 
-	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
-			   DA9063_SHUTDOWN);
-	if (ret)
-		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
-			  ret);
+	if (!adap->algo->master_xfer_blocking) {
+		printk("%s: I2C adapter does not support blocking transfer. Cannot use it!",
+				__func__);
+		return NOTIFY_DONE;
+	}
+
+
+	for (i = 0; i < 3; i++) {
+		ret = adap->algo->master_xfer_blocking(adap, &msg, 1);
+		if (ret == 0)
+			break;
+
+		printk("%s: blocking i2c transfer failed, ret =%d\n", __func__, ret);
+		if (ret != -EAGAIN) /* dont' retry, some other error */
+			break;
+
+		udelay(100);
+		printk("%s: try %d failed. Retry!\n", __func__, i);
+	}
+
+	udelay(500); /* wait for reset to assert... */
 
 	return NOTIFY_DONE;
 }
@@ -253,6 +319,13 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	wdt->reboot_notifier.notifier_call = da9063_wdt_reboot_notifier;
+	wdt->reboot_notifier.priority = 0; /* be the last notifier */
+	ret = register_reboot_notifier(&wdt->reboot_notifier);
+	if (ret)
+		dev_err(wdt->da9063->dev,
+			"Failed to register reboot notifier (err = %d)\n", ret);
+
 	wdt->restart_handler.notifier_call = da9063_wdt_restart_handler;
 	wdt->restart_handler.priority = 128;
 	ret = register_restart_handler(&wdt->restart_handler);
@@ -272,6 +345,8 @@ static int da9063_wdt_remove(struct platform_device *pdev)
 	/* Wait for delayed worker to finish. */
 	cancel_delayed_work_sync(&wdt->ping_work);
 
+	unregister_reboot_notifier(&wdt->reboot_notifier);
+
 	unregister_restart_handler(&wdt->restart_handler);
 
 	watchdog_unregister_device(&wdt->wdtdev);
-- 
1.9.1

