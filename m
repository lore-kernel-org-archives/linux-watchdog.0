Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:51781 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbbFQW7U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 18:59:20 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [PATCH v2 1/3] watchdog: max63xx: dynamically allocate device
Date: Wed, 17 Jun 2015 18:58:58 -0400
Message-Id: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch removes the static watchdog device for a new max63xx_wdt data
structure, and constifies the max63xx_timeout data.

The new structure contains pointers to pin access routines, which
abstracts mmap-specific code. This will ease future accesses like GPIO.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/max63xx_wdt.c | 170 +++++++++++++++++++++++++----------------
 1 file changed, 104 insertions(+), 66 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index b3a1130..3f7e8d5 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -39,10 +39,22 @@ static bool nowayout  = WATCHDOG_NOWAYOUT;
 #define MAX6369_WDSET	(7 << 0)
 #define MAX6369_WDI	(1 << 3)
 
-static DEFINE_SPINLOCK(io_lock);
+#define MAX6369_WDSET_DISABLED 3
 
 static int nodelay;
-static void __iomem	*wdt_base;
+
+struct max63xx_wdt {
+	struct watchdog_device wdd;
+	const struct max63xx_timeout *timeout;
+
+	/* memory mapping */
+	void __iomem *base;
+	spinlock_t lock;
+
+	/* WDI and WSET bits write access routines */
+	void (*ping)(struct max63xx_wdt *wdt);
+	void (*set)(struct max63xx_wdt *wdt, u8 set);
+};
 
 /*
  * The timeout values used are actually the absolute minimum the chip
@@ -59,25 +71,25 @@ static void __iomem	*wdt_base;
 
 /* Timeouts in second */
 struct max63xx_timeout {
-	u8 wdset;
-	u8 tdelay;
-	u8 twd;
+	const u8 wdset;
+	const u8 tdelay;
+	const u8 twd;
 };
 
-static struct max63xx_timeout max6369_table[] = {
+static const struct max63xx_timeout max6369_table[] = {
 	{ 5,  1,  1 },
 	{ 6, 10, 10 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6371_table[] = {
+static const struct max63xx_timeout max6371_table[] = {
 	{ 6, 60,  3 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6373_table[] = {
+static const struct max63xx_timeout max6373_table[] = {
 	{ 2, 60,  1 },
 	{ 5,  0,  1 },
 	{ 1,  3,  3 },
@@ -86,8 +98,6 @@ static struct max63xx_timeout max6373_table[] = {
 	{ },
 };
 
-static struct max63xx_timeout *current_timeout;
-
 static struct max63xx_timeout *
 max63xx_select_timeout(struct max63xx_timeout *table, int value)
 {
@@ -108,59 +118,32 @@ max63xx_select_timeout(struct max63xx_timeout *table, int value)
 
 static int max63xx_wdt_ping(struct watchdog_device *wdd)
 {
-	u8 val;
-
-	spin_lock(&io_lock);
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	val = __raw_readb(wdt_base);
-
-	__raw_writeb(val | MAX6369_WDI, wdt_base);
-	__raw_writeb(val & ~MAX6369_WDI, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->ping(wdt);
 	return 0;
 }
 
 static int max63xx_wdt_start(struct watchdog_device *wdd)
 {
-	struct max63xx_timeout *entry = watchdog_get_drvdata(wdd);
-	u8 val;
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	spin_lock(&io_lock);
-
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= entry->wdset;
-	__raw_writeb(val, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->set(wdt, wdt->timeout->wdset);
 
 	/* check for a edge triggered startup */
-	if (entry->tdelay == 0)
-		max63xx_wdt_ping(wdd);
+	if (wdt->timeout->tdelay == 0)
+		wdt->ping(wdt);
 	return 0;
 }
 
 static int max63xx_wdt_stop(struct watchdog_device *wdd)
 {
-	u8 val;
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	spin_lock(&io_lock);
-
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= 3;
-	__raw_writeb(val, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->set(wdt, MAX6369_WDSET_DISABLED);
 	return 0;
 }
 
-static const struct watchdog_info max63xx_wdt_info = {
-	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-	.identity = "max63xx Watchdog",
-};
-
 static const struct watchdog_ops max63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = max63xx_wdt_start,
@@ -168,49 +151,104 @@ static const struct watchdog_ops max63xx_wdt_ops = {
 	.ping = max63xx_wdt_ping,
 };
 
-static struct watchdog_device max63xx_wdt_dev = {
-	.info = &max63xx_wdt_info,
-	.ops = &max63xx_wdt_ops,
+static const struct watchdog_info max63xx_wdt_info = {
+	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "max63xx Watchdog",
 };
 
+static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
+{
+	u8 val;
+
+	spin_lock(&wdt->lock);
+
+	val = __raw_readb(wdt->base);
+
+	__raw_writeb(val | MAX6369_WDI, wdt->base);
+	__raw_writeb(val & ~MAX6369_WDI, wdt->base);
+
+	spin_unlock(&wdt->lock);
+}
+
+static void max63xx_mmap_set(struct max63xx_wdt *wdt, u8 set)
+{
+	u8 val;
+
+	spin_lock(&wdt->lock);
+
+	val = __raw_readb(wdt->base);
+	val &= ~MAX6369_WDSET;
+	val |= set & MAX6369_WDSET;
+	__raw_writeb(val, wdt->base);
+
+	spin_unlock(&wdt->lock);
+}
+
+static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
+{
+	struct resource *mem = platform_get_resource(p, IORESOURCE_MEM, 0);
+
+	wdt->base = devm_ioremap_resource(&p->dev, mem);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	spin_lock_init(&wdt->lock);
+
+	wdt->ping = max63xx_mmap_ping;
+	wdt->set = max63xx_mmap_set;
+	return 0;
+}
+
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
-	struct resource	*wdt_mem;
+	struct max63xx_wdt *wdt;
 	struct max63xx_timeout *table;
+	int err;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
 
 	table = (struct max63xx_timeout *)pdev->id_entry->driver_data;
 
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
-	dev_info(&pdev->dev, "requesting %ds heartbeat\n", heartbeat);
-	current_timeout = max63xx_select_timeout(table, heartbeat);
-
-	if (!current_timeout) {
-		dev_err(&pdev->dev, "unable to satisfy heartbeat request\n");
+	wdt->timeout = max63xx_select_timeout(table, heartbeat);
+	if (!wdt->timeout) {
+		dev_err(&pdev->dev, "unable to satisfy %ds heartbeat request\n",
+			heartbeat);
 		return -EINVAL;
 	}
 
-	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
-		 current_timeout->twd, current_timeout->tdelay);
+	err = max63xx_mmap_init(pdev, wdt);
+	if (err)
+		return err;
+
+	platform_set_drvdata(pdev, &wdt->wdd);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-	heartbeat = current_timeout->twd;
+	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.timeout = wdt->timeout->twd;
+	wdt->wdd.info = &max63xx_wdt_info;
+	wdt->wdd.ops = &max63xx_wdt_ops;
 
-	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt_base = devm_ioremap_resource(&pdev->dev, wdt_mem);
-	if (IS_ERR(wdt_base))
-		return PTR_ERR(wdt_base);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
-	max63xx_wdt_dev.timeout = heartbeat;
-	watchdog_set_nowayout(&max63xx_wdt_dev, nowayout);
-	watchdog_set_drvdata(&max63xx_wdt_dev, current_timeout);
+	err = watchdog_register_device(&wdt->wdd);
+	if (err)
+		return err;
 
-	return watchdog_register_device(&max63xx_wdt_dev);
+	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
+		 wdt->timeout->twd, wdt->timeout->tdelay);
+	return 0;
 }
 
 static int max63xx_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&max63xx_wdt_dev);
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(wdd);
 	return 0;
 }
 
-- 
2.4.3

