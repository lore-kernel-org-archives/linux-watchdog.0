Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:47249 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbbJCVyi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Oct 2015 17:54:38 -0400
From: Harald Geyer <harald@ccbib.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: rtc-linux@googlegroups.com, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>,
	Fabio Estevam <festevam@gmail.com>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Date: Sat,  3 Oct 2015 21:54:18 +0000
Message-Id: <1443909258-24914-1-git-send-email-harald@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When the watchdog is enabled, we set a persitent bit. After booting
we query the bit and see if the system was reset by the watchdog.

This is somewhat similar to what the legacy driver from freescale
does. However we use STMP3XXX_RTC_PERSISTENT2 instead of
STMP3XXX_RTC_PERSISTENT1. I tried that first, but it seems I can't
clear the bit there once it is set. I didn't find any documentation
what this register does - only vague hints that it is meant to
control the boot ROM.

Part of the code from the legacy driver touching this register
is still included. Maybe this is stale, but this patch doesn't
touch any of it because I don't know what it really does or is
meant to do.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Changes since v1:
* make code formatting more consistent with the rest of the driver
* Cc some people who might have better documentation then I do

Changes since initially posting this patch on 08/04/2015:
* fix a spelling error in the commit message
* rebase to a recent version

 drivers/rtc/rtc-stmp3xxx.c          |   23 +++++++++++++++++++++++
 drivers/watchdog/stmp3xxx_rtc_wdt.c |   34 +++++++++++++++++++++++++++++++++-
 include/linux/stmp3xxx_rtc_wdt.h    |    2 ++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index ca54d03..4ab0aeb 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/stmp_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/watchdog.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
@@ -62,6 +63,9 @@
 /* missing bitmask in headers */
 #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
 
+#define STMP3XXX_RTC_PERSISTENT2		0x80
+#define STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE	0x00000001
+
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
@@ -83,6 +87,14 @@ struct stmp3xxx_rtc_data {
  * registers is atomic.
  */
 
+static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
+{
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+
+	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+	       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR);
+}
+
 static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
@@ -93,16 +105,22 @@ static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
 		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
 		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
 		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_SET);
+		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_SET);
 	} else {
 		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
 		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
 		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_CLR);
+		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR);
 	}
 }
 
 static struct stmp3xxx_wdt_pdata wdt_pdata = {
 	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
+	.wdt_clear_bootstatus = stmp3xxx_wdt_clear_bootstatus,
+	.bootstatus = 0,
 };
 
 static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
@@ -110,6 +128,8 @@ static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 	struct platform_device *wdt_pdev =
 		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
 
+	stmp3xxx_wdt_clear_bootstatus(&rtc_pdev->dev);
+
 	if (wdt_pdev) {
 		wdt_pdev->dev.parent = &rtc_pdev->dev;
 		wdt_pdev->dev.platform_data = &wdt_pdata;
@@ -357,6 +377,9 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (readl(STMP3XXX_RTC_PERSISTENT2 + rtc_data->io) &
+			 STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE)
+		wdt_pdata.bootstatus |= WDIOF_CARDRESET;
 	stmp3xxx_wdt_register(pdev);
 	return 0;
 }
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 3ee6128..7609f78 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
 #define STMP3XXX_DEFAULT_TIMEOUT 19
@@ -50,7 +52,8 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned new_timeout)
 }
 
 static const struct watchdog_info stmp3xxx_wdt_ident = {
-	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+		WDIOF_CARDRESET,
 	.identity = "STMP3XXX RTC Watchdog",
 };
 
@@ -69,14 +72,39 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 };
 
+static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
+			  void *unused)
+{
+	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
+
+	switch (code) {
+	case SYS_DOWN:	/* keep enabled, system might crash while going down */
+		pdata->wdt_clear_bootstatus(dev->parent);
+		break;
+	case SYS_HALT:  /* allow the system to actually halt */
+	case SYS_POWER_OFF:
+		wdt_stop(&stmp3xxx_wdd);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call  = wdt_notify_sys,
+};
+
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
 	stmp3xxx_wdd.parent = &pdev->dev;
+	stmp3xxx_wdd.bootstatus = pdata->bootstatus;
 
 	ret = watchdog_register_device(&stmp3xxx_wdd);
 	if (ret < 0) {
@@ -84,6 +112,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (register_reboot_notifier(&wdt_notifier))
+		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
+
 	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
 			stmp3xxx_wdd.timeout);
 	return 0;
@@ -91,6 +122,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
+	unregister_reboot_notifier(&wdt_notifier);
 	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
diff --git a/include/linux/stmp3xxx_rtc_wdt.h b/include/linux/stmp3xxx_rtc_wdt.h
index 1dd12c9..62dd9e6 100644
--- a/include/linux/stmp3xxx_rtc_wdt.h
+++ b/include/linux/stmp3xxx_rtc_wdt.h
@@ -10,6 +10,8 @@
 
 struct stmp3xxx_wdt_pdata {
 	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
+	void (*wdt_clear_bootstatus)(struct device *dev);
+	unsigned int bootstatus;
 };
 
 #endif /* __LINUX_STMP3XXX_RTC_WDT_H */
-- 
1.7.10.4

