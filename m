Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1943 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab3K2VVE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Nov 2013 16:21:04 -0500
From: "Markus Mayer" <markus.mayer@linaro.org>
To: "Guenter Roeck" <linux@roeck-us.net>,
	"Wim Van Sebroeck" <wim@iguana.be>
cc: "Linux Watchdog List" <linux-watchdog@vger.kernel.org>,
	"Markus Mayer" <markus.mayer@linaro.org>
Subject: [RFC 2/2] watchdog: bcm281xx: Support for timer resolution
 ioctls
Date: Fri, 29 Nov 2013 13:20:30 -0800
Message-ID: <1385760030-24264-3-git-send-email-markus.mayer@linaro.org>
In-Reply-To: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
References: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This change makes use of the watchdog timer resolution support that is
present in the watchdog framework. It depends on the following patch series:
http://www.spinics.net/lists/linux-watchdog/msg03328.html

A userland application can set or retrieve the watchdog timer's
resolution using code like this:

	/* Set the watchdog timer resolution */
	resolution = ... ;
	printf("setting watchdog timer resolution to %d\n", resolution);
	ret = ioctl(fd, WDIOC_SETRESOLUTION, &resolution);
	if (ret < 0)
		fprintf(stderr, "%s: ioctl failed -- %s\n", prg,
						strerror(errno));

	/* Retrieve the watchdog timer resolution */
	ret = ioctl(fd, WDIOC_GETRESOLUTION, &resolution);
	if (ret < 0)
		fprintf(stderr, "%s: ioctl failed -- %s\n", prg,
						strerror(errno));
	else
		printf("resolution: %d\n",resolution);
	break;
---
 drivers/watchdog/bcm_kona_wdt.c |   57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 9fe174b..30e4e9b 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -54,7 +54,6 @@ struct bcm_kona_wdt {
 	 * us a maximum of about 18 hours and 12 minutes before the watchdog
 	 * times out.
 	 */
-	int resolution;
 	spinlock_t lock;
 #ifdef CONFIG_BCM_KONA_WDT_DEBUG
 	struct dentry *debugfs;
@@ -104,9 +103,10 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 {
 	int ctl_val, cur_val, ret;
 	unsigned long flags;
-	struct bcm_kona_wdt *wdt = s->private;
+	struct watchdog_device *wdd = s->private;
+	struct bcm_kona_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	if (!wdt)
+	if (!wdd || !wdt)
 		return seq_puts(s, "No device pointer\n");
 
 	spin_lock_irqsave(&wdt->lock, flags);
@@ -122,13 +122,13 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 		ctl = ctl_val & SECWDOG_COUNT_MASK;
 		res = (ctl_val & SECWDOG_RES_MASK) >> SECWDOG_CLKS_SHIFT;
 		cur = cur_val & SECWDOG_COUNT_MASK;
-		ctl_sec = TICKS_TO_SECS(ctl, wdt);
-		cur_sec = TICKS_TO_SECS(cur, wdt);
+		ctl_sec = TICKS_TO_SECS(ctl, wdd);
+		cur_sec = TICKS_TO_SECS(cur, wdd);
 		ret = seq_printf(s, "Resolution: %d / %d\n"
 				"Control: %d s / %d (%#x) ticks\n"
 				"Current: %d s / %d (%#x) ticks\n"
 				"Busy count: %lu\n", res,
-				wdt->resolution, ctl_sec, ctl, ctl, cur_sec,
+				wdd->resolution, ctl_sec, ctl, ctl, cur_sec,
 				cur, cur, busy_count);
 	}
 
@@ -156,7 +156,7 @@ static struct dentry *bcm_kona_wdt_debugfs_init(struct bcm_kona_wdt *wdt,
 	if (IS_ERR_OR_NULL(dir))
 		return NULL;
 
-	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
+	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdd,
 				&bcm_kona_dbg_operations))
 		return dir;
 
@@ -195,13 +195,14 @@ static int bcm_kona_wdt_ctrl_reg_modify(struct bcm_kona_wdt *wdt,
 	return ret;
 }
 
-static int bcm_kona_wdt_set_resolution_reg(struct bcm_kona_wdt *wdt)
+static int bcm_kona_wdt_set_resolution(struct watchdog_device *wdog,
+	unsigned r)
 {
-	if (wdt->resolution > SECWDOG_MAX_RES)
-		return -EINVAL;
+	struct bcm_kona_wdt *wdt = watchdog_get_drvdata(wdog);
 
+	wdog->resolution = r;
 	return bcm_kona_wdt_ctrl_reg_modify(wdt, SECWDOG_RES_MASK,
-					wdt->resolution << SECWDOG_CLKS_SHIFT);
+					r << SECWDOG_CLKS_SHIFT);
 }
 
 static int bcm_kona_wdt_set_timeout_reg(struct watchdog_device *wdog,
@@ -210,7 +211,7 @@ static int bcm_kona_wdt_set_timeout_reg(struct watchdog_device *wdog,
 	struct bcm_kona_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	return bcm_kona_wdt_ctrl_reg_modify(wdt, SECWDOG_COUNT_MASK,
-					SECS_TO_TICKS(wdog->timeout, wdt) |
+					SECS_TO_TICKS(wdog->timeout, wdog) |
 					watchdog_flags);
 }
 
@@ -234,7 +235,7 @@ static unsigned int bcm_kona_wdt_get_timeleft(struct watchdog_device *wdog)
 	if (val < 0)
 		return val;
 
-	return TICKS_TO_SECS(val & SECWDOG_COUNT_MASK, wdt);
+	return TICKS_TO_SECS(val & SECWDOG_COUNT_MASK, wdog);
 }
 
 static int bcm_kona_wdt_start(struct watchdog_device *wdog)
@@ -252,16 +253,17 @@ static int bcm_kona_wdt_stop(struct watchdog_device *wdog)
 }
 
 static struct watchdog_ops bcm_kona_wdt_ops = {
-	.owner =	THIS_MODULE,
-	.start =	bcm_kona_wdt_start,
-	.stop =		bcm_kona_wdt_stop,
-	.set_timeout =	bcm_kona_wdt_set_timeout,
-	.get_timeleft =	bcm_kona_wdt_get_timeleft,
+	.owner =		THIS_MODULE,
+	.start =		bcm_kona_wdt_start,
+	.stop =			bcm_kona_wdt_stop,
+	.set_timeout =		bcm_kona_wdt_set_timeout,
+	.get_timeleft =		bcm_kona_wdt_get_timeleft,
+	.set_resolution =	bcm_kona_wdt_set_resolution,
 };
 
 static struct watchdog_info bcm_kona_wdt_info = {
-	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
-			WDIOF_KEEPALIVEPING,
+	.options =	WDIOF_SETTIMEOUT | WDIOF_SETRESOLUTION |
+			WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity =	"Broadcom Kona Watchdog Timer",
 };
 
@@ -271,6 +273,9 @@ static struct watchdog_device bcm_kona_wdt_wdd = {
 	.min_timeout =	1,
 	.max_timeout =	SECWDOG_MAX_COUNT >> SECWDOG_DEFAULT_RESOLUTION,
 	.timeout =	SECWDOG_MAX_COUNT >> SECWDOG_DEFAULT_RESOLUTION,
+	.min_resolution = 0,
+	.max_resolution = SECWDOG_MAX_RES,
+	.resolution = SECWDOG_DEFAULT_RESOLUTION
 };
 
 static void bcm_kona_wdt_shutdown(struct platform_device *pdev)
@@ -294,17 +299,17 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return -ENODEV;
 
-	wdt->resolution = SECWDOG_DEFAULT_RESOLUTION;
-	ret = bcm_kona_wdt_set_resolution_reg(wdt);
+	spin_lock_init(&wdt->lock);
+	platform_set_drvdata(pdev, wdt);
+	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
+
+	ret = bcm_kona_wdt_set_resolution(&bcm_kona_wdt_wdd,
+				bcm_kona_wdt_wdd.resolution);
 	if (ret) {
 		dev_err(dev, "Failed to set resolution (error: %d)", ret);
 		return ret;
 	}
 
-	spin_lock_init(&wdt->lock);
-	platform_set_drvdata(pdev, wdt);
-	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
-
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
 		dev_err(dev, "Failed set watchdog timeout");
-- 
1.7.9.5


