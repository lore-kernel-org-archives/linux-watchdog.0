Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35279 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbHGKIC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 06:08:02 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v1 4/5] watchdog: mpc8xxx: use dynamic memory for device specific data
Date: Fri,  7 Aug 2015 12:07:46 +0200
Message-Id: <1438942067-1654-5-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of relying on global static memory dynamically allocate the
needed data. This has the benefit of some saved bytes if the driver is
not in use and making it possible to bind more than one device (even
though this has no known use case).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c | 82 ++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index a6790fcfa69b..a36ced9c95e4 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -50,7 +50,12 @@ struct mpc8xxx_wdt_type {
 	bool hw_enabled;
 };
 
-static struct mpc8xxx_wdt __iomem *wd_base;
+struct mpc8xxx_wdt_ddata {
+	struct mpc8xxx_wdt __iomem *base;
+	struct watchdog_device wdd;
+	struct timer_list timer;
+	spinlock_t lock;
+};
 
 static u16 timeout = 0xffff;
 module_param(timeout, ushort, 0);
@@ -67,33 +72,28 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static DEFINE_SPINLOCK(wdt_spinlock);
-
-static void mpc8xxx_wdt_keepalive(void)
+static void mpc8xxx_wdt_keepalive(struct mpc8xxx_wdt_ddata *ddata)
 {
 	/* Ping the WDT */
-	spin_lock(&wdt_spinlock);
-	out_be16(&wd_base->swsrr, 0x556c);
-	out_be16(&wd_base->swsrr, 0xaa39);
-	spin_unlock(&wdt_spinlock);
+	spin_lock(&ddata->lock);
+	out_be16(&ddata->base->swsrr, 0x556c);
+	out_be16(&ddata->base->swsrr, 0xaa39);
+	spin_unlock(&ddata->lock);
 }
 
-static struct watchdog_device mpc8xxx_wdt_dev;
-static void mpc8xxx_wdt_timer_ping(unsigned long arg);
-static DEFINE_TIMER(wdt_timer, mpc8xxx_wdt_timer_ping, 0,
-		(unsigned long)&mpc8xxx_wdt_dev);
-
 static void mpc8xxx_wdt_timer_ping(unsigned long arg)
 {
-	struct watchdog_device *w = (struct watchdog_device *)arg;
+	struct mpc8xxx_wdt_ddata *ddata = (void *)arg;
 
-	mpc8xxx_wdt_keepalive();
+	mpc8xxx_wdt_keepalive(ddata);
 	/* We're pinging it twice faster than needed, just to be sure. */
-	mod_timer(&wdt_timer, jiffies + HZ * w->timeout / 2);
+	mod_timer(&ddata->timer, jiffies + HZ * ddata->wdd.timeout / 2);
 }
 
 static int mpc8xxx_wdt_start(struct watchdog_device *w)
 {
+	struct mpc8xxx_wdt_ddata *ddata = container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+
 	u32 tmp = SWCRR_SWEN | SWCRR_SWPR;
 
 	/* Good, fire up the show */
@@ -102,22 +102,24 @@ static int mpc8xxx_wdt_start(struct watchdog_device *w)
 
 	tmp |= timeout << 16;
 
-	out_be32(&wd_base->swcrr, tmp);
+	out_be32(&ddata->base->swcrr, tmp);
 
-	del_timer_sync(&wdt_timer);
+	del_timer_sync(&ddata->timer);
 
 	return 0;
 }
 
 static int mpc8xxx_wdt_ping(struct watchdog_device *w)
 {
-	mpc8xxx_wdt_keepalive();
+	struct mpc8xxx_wdt_ddata *ddata = container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+	mpc8xxx_wdt_keepalive(ddata);
 	return 0;
 }
 
 static int mpc8xxx_wdt_stop(struct watchdog_device *w)
 {
-	mod_timer(&wdt_timer, jiffies);
+	struct mpc8xxx_wdt_ddata *ddata = container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+	mod_timer(&ddata->timer, jiffies);
 	return 0;
 }
 
@@ -134,16 +136,12 @@ static struct watchdog_ops mpc8xxx_wdt_ops = {
 	.stop = mpc8xxx_wdt_stop,
 };
 
-static struct watchdog_device mpc8xxx_wdt_dev = {
-	.info = &mpc8xxx_wdt_info,
-	.ops = &mpc8xxx_wdt_ops,
-};
-
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
 	struct resource *res;
 	const struct mpc8xxx_wdt_type *wdt_type;
+	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 	unsigned int timeout_sec;
@@ -155,25 +153,35 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (!freq || freq == -1)
 		return -EINVAL;
 
+	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	wd_base = devm_ioremap_resource(&ofdev->dev, res);
-	if (IS_ERR(wd_base))
-		return PTR_ERR(wd_base);
+	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
 
-	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
+	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
 		pr_info("could not be enabled in software\n");
 		return -ENOSYS;
 	}
 
+	spin_lock_init(&ddata->lock);
+	setup_timer(&ddata->timer, mpc8xxx_wdt_timer_ping, (unsigned long)ddata);
+
+	ddata->wdd.info = &mpc8xxx_wdt_info,
+	ddata->wdd.ops = &mpc8xxx_wdt_ops,
+
 	/* Calculate the timeout in seconds */
 	timeout_sec = (timeout * wdt_type->prescaler) / freq;
 
-	mpc8xxx_wdt_dev.timeout = timeout_sec;
+	ddata->wdd.timeout = timeout_sec;
 
-	watchdog_set_nowayout(&mpc8xxx_wdt_dev, nowayout);
+	watchdog_set_nowayout(&ddata->wdd, nowayout);
 
-	ret = watchdog_register_device(&mpc8xxx_wdt_dev);
+	ret = watchdog_register_device(&ddata->wdd);
 	if (ret) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		return ret;
@@ -188,16 +196,20 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	 * userspace handles it.
 	 */
 	if (enabled)
-		mod_timer(&wdt_timer, jiffies);
+		mod_timer(&ddata->timer, jiffies);
+
+	platform_set_drvdata(ofdev, ddata);
 	return 0;
 }
 
 static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 {
+	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
+
 	pr_crit("Watchdog removed, expect the %s soon!\n",
 		reset ? "reset" : "machine check exception");
-	del_timer_sync(&wdt_timer);
-	watchdog_unregister_device(&mpc8xxx_wdt_dev);
+	del_timer_sync(&ddata->timer);
+	watchdog_unregister_device(&ddata->wdd);
 
 	return 0;
 }
-- 
2.4.6

