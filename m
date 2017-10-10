Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from m12-12.163.com ([220.181.12.12]:50121 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755919AbdJJN3d (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 09:29:33 -0400
From: "winton.liu" <18502523564@163.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux@roeck-us.net
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, "winton.liu" <18502523564@163.com>
Subject: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Date: Tue, 10 Oct 2017 21:12:52 +0800
Message-Id: <1507641172-6099-1-git-send-email-18502523564@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
in suspend mode, watchdog is still working but no daemon
patting the watchdog. The system will reboot if timeout.

Add support suspend/resume for watchdog.
suspend: disable the watchdog
resume: disable existing watchdog, reload watchdog timer, enable watchdog

Signed-off-by: winton.liu <18502523564@163.com>
---
 drivers/rtc/rtc-ds1374.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 38a2e9e..642e31d 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -437,6 +437,29 @@ static void ds1374_wdt_ping(void)
 		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
 }
 
+static void ds1374_wdt_resume(void)
+{
+	int ret = -ENOIOCTLCMD;
+	int cr;
+
+	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
+
+	/* Disable any existing watchdog/alarm before setting the new one */
+	cr &= ~DS1374_REG_CR_WACE;
+
+	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
+
+	/* Reload watchdog timer */
+	ds1374_wdt_ping();
+
+	/* Enable watchdog timer */
+	cr |= DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
+	cr &= ~DS1374_REG_CR_AIE;
+
+	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
+
+}
+
 static void ds1374_wdt_disable(void)
 {
 	int ret = -ENOIOCTLCMD;
@@ -690,6 +713,10 @@ static int ds1374_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+#ifdef CONFIG_RTC_DRV_DS1374_WDT
+	ds1374_wdt_disable();
+#endif
+
 	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
 	return 0;
@@ -699,6 +726,10 @@ static int ds1374_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+#ifdef CONFIG_RTC_DRV_DS1374_WDT
+	ds1374_wdt_resume();
+#endif
+
 	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 	return 0;
-- 
1.9.1


