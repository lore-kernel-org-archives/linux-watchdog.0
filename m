Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:35338 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867Ab2CLEY0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:24:26 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 21/22] watchdog/sp805: convert to watchdog core
Date: Mon, 12 Mar 2012 09:52:16 +0530
Message-ID: <5995d6811770943879be2ab5bcc0810aa38dd72f.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch converts existing sp805 watchdog driver to use already in place
common infrastructure present in watchdog core. With this lot of code goes away.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/Kconfig     |    1 +
 drivers/watchdog/sp805_wdt.c |  241 ++++++++++++++---------------------------
 2 files changed, 83 insertions(+), 159 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f66617a..438c393 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -85,6 +85,7 @@ config WM8350_WATCHDOG
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
 	depends on ARM_AMBA
+	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
 	  the timeout is reached.
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 859d8b0..5c34eda 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -16,20 +16,17 @@
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
 
 /* default timeout in seconds */
@@ -56,6 +53,7 @@
 
 /**
  * struct sp805_wdt: sp805 wdt device structure
+ * @wdd: instance of struct watchdog_device
  * @lock: spin lock protecting dev structure and io access
  * @base: base address of wdt
  * @clk: clock structure of wdt
@@ -65,24 +63,24 @@
  * @timeout: current programmed timeout
  */
 struct sp805_wdt {
+	struct watchdog_device		wdd;
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
 	struct amba_device		*adev;
-	unsigned long			status;
-	#define WDT_BUSY		0
-	#define WDT_CAN_BE_CLOSED	1
 	unsigned int			load_val;
 	unsigned int			timeout;
 };
 
-/* local variables */
-static struct sp805_wdt *wdt;
 static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		"Set to 1 to keep watchdog running after device release");
 
 /* This routine finds load value that will reset system in required timout */
-static void wdt_setload(unsigned int timeout)
+static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
 	rate = clk_get_rate(wdt->clk);
@@ -103,11 +101,14 @@ static void wdt_setload(unsigned int timeout)
 	/* roundup timeout to closest positive integer value */
 	wdt->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
 	spin_unlock(&wdt->lock);
+
+	return 0;
 }
 
 /* returns number of seconds left for reset to occur */
-static u32 wdt_timeleft(void)
+static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 {
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
 	rate = clk_get_rate(wdt->clk);
@@ -123,166 +124,88 @@ static u32 wdt_timeleft(void)
 	return div_u64(load, rate);
 }
 
-/* enables watchdog timers reset */
-static void wdt_enable(void)
+static int wdt_config(struct watchdog_device *wdd, bool ping)
 {
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	if (!ping) {
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(&wdt->adev->dev, "clock enable fail");
+			return ret;
+		}
+	}
+
 	spin_lock(&wdt->lock);
 
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
-	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
-	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
-	writel_relaxed(LOCK, wdt->base + WDTLOCK);
-
-	/* Flush posted writes. */
-	readl_relaxed(wdt->base + WDTLOCK);
-	spin_unlock(&wdt->lock);
-}
 
-/* disables watchdog timers reset */
-static void wdt_disable(void)
-{
-	spin_lock(&wdt->lock);
+	if (!ping) {
+		writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
+		writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base +
+				WDTCONTROL);
+	}
 
-	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
-	writel_relaxed(0, wdt->base + WDTCONTROL);
 	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
 	/* Flush posted writes. */
 	readl_relaxed(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
+
+	return 0;
 }
 
-static ssize_t sp805_wdt_write(struct file *file, const char *data,
-		size_t len, loff_t *ppos)
+static int wdt_ping(struct watchdog_device *wdd)
 {
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			clear_bit(WDT_CAN_BE_CLOSED, &wdt->status);
-
-			for (i = 0; i != len; i++) {
-				char c;
-
-				if (get_user(c, data + i))
-					return -EFAULT;
-				/* Check for Magic Close character */
-				if (c == 'V') {
-					set_bit(WDT_CAN_BE_CLOSED,
-							&wdt->status);
-					break;
-				}
-			}
-		}
-		wdt_enable();
-	}
-	return len;
+	return wdt_config(wdd, true);
 }
 
-static const struct watchdog_info ident = {
-	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-	.identity = MODULE_NAME,
-};
-
-static long sp805_wdt_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg)
+/* enables watchdog timers reset */
+static int wdt_enable(struct watchdog_device *wdd)
 {
-	int ret = -ENOTTY;
-	unsigned int timeout;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		ret = copy_to_user((struct watchdog_info *)arg, &ident,
-				sizeof(ident)) ? -EFAULT : 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-		ret = put_user(0, (int *)arg);
-		break;
-
-	case WDIOC_KEEPALIVE:
-		wdt_enable();
-		ret = 0;
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		ret = get_user(timeout, (unsigned int *)arg);
-		if (ret)
-			break;
-
-		wdt_setload(timeout);
-
-		wdt_enable();
-		/* Fall through */
-
-	case WDIOC_GETTIMEOUT:
-		ret = put_user(wdt->timeout, (unsigned int *)arg);
-		break;
-	case WDIOC_GETTIMELEFT:
-		ret = put_user(wdt_timeleft(), (unsigned int *)arg);
-		break;
-	}
-	return ret;
+	return wdt_config(wdd, false);
 }
 
-static int sp805_wdt_open(struct inode *inode, struct file *file)
+/* disables watchdog timers reset */
+static int wdt_disable(struct watchdog_device *wdd)
 {
-	int ret = 0;
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	if (test_and_set_bit(WDT_BUSY, &wdt->status))
-		return -EBUSY;
-
-	ret = clk_enable(wdt->clk);
-	if (ret) {
-		dev_err(&wdt->adev->dev, "clock enable fail");
-		goto err;
-	}
-
-	wdt_enable();
-
-	/* can not be closed, once enabled */
-	clear_bit(WDT_CAN_BE_CLOSED, &wdt->status);
-	return nonseekable_open(inode, file);
+	spin_lock(&wdt->lock);
 
-err:
-	clear_bit(WDT_BUSY, &wdt->status);
-	return ret;
-}
+	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
+	writel_relaxed(0, wdt->base + WDTCONTROL);
+	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
-static int sp805_wdt_release(struct inode *inode, struct file *file)
-{
-	if (!test_bit(WDT_CAN_BE_CLOSED, &wdt->status)) {
-		clear_bit(WDT_BUSY, &wdt->status);
-		dev_warn(&wdt->adev->dev, "Device closed unexpectedly\n");
-		return 0;
-	}
+	/* Flush posted writes. */
+	readl_relaxed(wdt->base + WDTLOCK);
+	spin_unlock(&wdt->lock);
 
-	wdt_disable();
 	clk_disable(wdt->clk);
-	clear_bit(WDT_BUSY, &wdt->status);
 
 	return 0;
 }
 
-static const struct file_operations sp805_wdt_fops = {
-	.owner = THIS_MODULE,
-	.llseek = no_llseek,
-	.write = sp805_wdt_write,
-	.unlocked_ioctl = sp805_wdt_ioctl,
-	.open = sp805_wdt_open,
-	.release = sp805_wdt_release,
+static const struct watchdog_info wdt_info = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = MODULE_NAME,
 };
 
-static struct miscdevice sp805_wdt_miscdev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &sp805_wdt_fops,
+static const struct watchdog_ops wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= wdt_enable,
+	.stop		= wdt_disable,
+	.ping		= wdt_ping,
+	.set_timeout	= wdt_setload,
+	.get_timeleft	= wdt_timeleft,
 };
 
 static int __devinit
 sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
+	struct sp805_wdt *wdt;
 	int ret = 0;
 
 	if (!devm_request_mem_region(&adev->dev, adev->res.start,
@@ -315,19 +238,26 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	wdt->adev = adev;
+	wdt->wdd.info = &wdt_info;
+	wdt->wdd.ops = &wdt_ops;
+
 	spin_lock_init(&wdt->lock);
-	wdt_setload(DEFAULT_TIMEOUT);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
 
-	ret = misc_register(&sp805_wdt_miscdev);
-	if (ret < 0) {
-		dev_warn(&adev->dev, "cannot register misc device\n");
-		goto err_misc_register;
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret) {
+		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
+				ret);
+		goto err_register;
 	}
+	amba_set_drvdata(adev, wdt);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 
 	dev_info(&adev->dev, "registration successful\n");
 	return 0;
 
-err_misc_register:
+err_register:
 	clk_put(wdt->clk);
 err:
 	dev_err(&adev->dev, "Probe Failed!!!\n");
@@ -336,7 +266,11 @@ err:
 
 static int __devexit sp805_wdt_remove(struct amba_device *adev)
 {
-	misc_deregister(&sp805_wdt_miscdev);
+	struct sp805_wdt *wdt = amba_get_drvdata(adev);
+
+	watchdog_unregister_device(&wdt->wdd);
+	amba_set_drvdata(adev, NULL);
+	watchdog_set_drvdata(&wdt->wdd, NULL);
 	clk_put(wdt->clk);
 
 	return 0;
@@ -345,28 +279,22 @@ static int __devexit sp805_wdt_remove(struct amba_device *adev)
 #ifdef CONFIG_PM
 static int sp805_wdt_suspend(struct device *dev)
 {
-	if (test_bit(WDT_BUSY, &wdt->status)) {
-		wdt_disable();
-		clk_disable(wdt->clk);
-	}
+	struct sp805_wdt *wdt = dev_get_drvdata(dev);
+
+	if (is_wdd_active(&wdt->wdd))
+		return wdt_disable(&wdt->wdd);
 
 	return 0;
 }
 
 static int sp805_wdt_resume(struct device *dev)
 {
-	int ret = 0;
+	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
-	if (test_bit(WDT_BUSY, &wdt->status)) {
-		ret = clk_enable(wdt->clk);
-		if (ret) {
-			dev_err(dev, "clock enable fail");
-			return ret;
-		}
-		wdt_enable();
-	}
+	if (is_wdd_active(&wdt->wdd))
+		return wdt_enable(&wdt->wdd);
 
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
@@ -405,11 +333,6 @@ static void __exit sp805_wdt_exit(void)
 }
 module_exit(sp805_wdt_exit);
 
-module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout,
-		"Set to 1 to keep watchdog running after device release");
-
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
 MODULE_DESCRIPTION("ARM SP805 Watchdog Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.8.110.g4cb5d

