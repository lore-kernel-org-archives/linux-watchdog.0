Return-path: <linux@roeck-us.net>
From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v7 9/9] watchdog: dw_wdt: Convert to use watchdog infrastructure
Date: Mon, 25 Jan 2016 18:53:16 -0800
Message-Id: <1453776796-3885-10-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

Convert driver to use watchdog infrastructure. This includes
infrastructure support to handle watchdog keepalive if the watchdog
is running while the watchdog device is closed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v7: Set max_hw_timeout_ms
    Rebased to v4.5-rc1
v6: Added patch
---
 drivers/watchdog/Kconfig  |   1 +
 drivers/watchdog/dw_wdt.c | 323 +++++++++++++++++-----------------------------
 2 files changed, 117 insertions(+), 207 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be0da34..36b3835bc524 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -329,6 +329,7 @@ config SA1100_WATCHDOG
 config DW_WATCHDOG
 	tristate "Synopsys DesignWare watchdog"
 	depends on HAS_IOMEM
+	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the Synopsys DesignWare
 	  watchdog timer found in many chips.
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 8fefa4ad46d4..a088451e28cb 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -12,9 +12,8 @@
  * and these are a function of the input clock frequency.
  *
  * The DesignWare watchdog cannot be stopped once it has been started so we
- * use a software timer to implement a ping that will keep the watchdog alive.
- * If we receive an expected close for the watchdog then we keep the timer
- * running, otherwise the timer is stopped and the watchdog will expire.
+ * do not implement a stop function. The watchdog core will continue to send
+ * heartbeat requests after the watchdog device has been closed.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -22,12 +21,9 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/notifier.h>
@@ -35,8 +31,6 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
-#include <linux/timer.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
@@ -57,53 +51,50 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#define WDT_TIMEOUT		(HZ / 2)
-
-static struct {
+struct dw_wdt {
 	void __iomem		*regs;
 	struct clk		*clk;
-	unsigned long		in_use;
-	unsigned long		next_heartbeat;
-	struct timer_list	timer;
-	int			expect_close;
 	struct notifier_block	restart_handler;
-} dw_wdt;
+	struct watchdog_device	wdd;
+};
+
+#define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
 
-static inline int dw_wdt_is_enabled(void)
+static inline int dw_wdt_is_enabled(struct dw_wdt *dw_wdt)
 {
-	return readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET) &
+	return readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET) &
 		WDOG_CONTROL_REG_WDT_EN_MASK;
 }
 
-static inline int dw_wdt_top_in_seconds(unsigned top)
+static inline int dw_wdt_top_in_seconds(struct dw_wdt *dw_wdt, unsigned top)
 {
 	/*
 	 * There are 16 possible timeout values in 0..15 where the number of
 	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
 	 */
-	return (1U << (16 + top)) / clk_get_rate(dw_wdt.clk);
+	return (1U << (16 + top)) / clk_get_rate(dw_wdt->clk);
 }
 
-static int dw_wdt_get_top(void)
+static int dw_wdt_get_top(struct dw_wdt *dw_wdt)
 {
-	int top = readl(dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET) & 0xF;
+	int top = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET) & 0xF;
 
-	return dw_wdt_top_in_seconds(top);
+	return dw_wdt_top_in_seconds(dw_wdt, top);
 }
 
-static inline void dw_wdt_set_next_heartbeat(void)
+static int dw_wdt_ping(struct watchdog_device *wdd)
 {
-	dw_wdt.next_heartbeat = jiffies + dw_wdt_get_top() * HZ;
-}
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 
-static void dw_wdt_keepalive(void)
-{
-	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
+	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt->regs +
 	       WDOG_COUNTER_RESTART_REG_OFFSET);
+
+	return 0;
 }
 
-static int dw_wdt_set_top(unsigned top_s)
+static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
 {
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 	int i, top_val = DW_WDT_MAX_TOP;
 
 	/*
@@ -111,7 +102,7 @@ static int dw_wdt_set_top(unsigned top_s)
 	 * always look for >=.
 	 */
 	for (i = 0; i <= DW_WDT_MAX_TOP; ++i)
-		if (dw_wdt_top_in_seconds(i) >= top_s) {
+		if (dw_wdt_top_in_seconds(dw_wdt, i) >= top_s) {
 			top_val = i;
 			break;
 		}
@@ -123,33 +114,43 @@ static int dw_wdt_set_top(unsigned top_s)
 	 * effectively get a pat of the watchdog right here.
 	 */
 	writel(top_val | top_val << WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT,
-		dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+	       dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 
-	/*
-	 * Add an explicit pat to handle versions of the watchdog that
-	 * don't have TOPINIT.  This won't hurt on versions that have
-	 * it.
-	 */
-	dw_wdt_keepalive();
+	wdd->timeout = dw_wdt_top_in_seconds(dw_wdt, top_val);
 
-	dw_wdt_set_next_heartbeat();
+	return 0;
+}
+
+static int dw_wdt_start(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
+
+	dw_wdt_set_timeout(wdd, wdd->timeout);
 
-	return dw_wdt_top_in_seconds(top_val);
+	set_bit(WDOG_HW_RUNNING, &wdd->status);
+
+	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
+	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
+
+	return 0;
 }
 
 static int dw_wdt_restart_handle(struct notifier_block *this,
-				unsigned long mode, void *cmd)
+				 unsigned long mode, void *cmd)
 {
+	struct dw_wdt *dw_wdt;
 	u32 val;
 
-	writel(0, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
-	val = readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+	dw_wdt = container_of(this, struct dw_wdt, restart_handler);
+
+	writel(0, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
-		writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
-			WDOG_COUNTER_RESTART_REG_OFFSET);
+		writel(WDOG_COUNTER_RESTART_KICK_VALUE,
+		       dw_wdt->regs + WDOG_COUNTER_RESTART_REG_OFFSET);
 	else
 		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
-		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+		       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 
 	/* wait for reset to assert... */
 	mdelay(500);
@@ -157,74 +158,12 @@ static int dw_wdt_restart_handle(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static void dw_wdt_ping(unsigned long data)
+static unsigned int dw_wdt_get_timeleft(struct watchdog_device *wdd)
 {
-	if (time_before(jiffies, dw_wdt.next_heartbeat) ||
-	    (!nowayout && !dw_wdt.in_use)) {
-		dw_wdt_keepalive();
-		mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
-	} else
-		pr_crit("keepalive missed, machine will reset\n");
-}
-
-static int dw_wdt_open(struct inode *inode, struct file *filp)
-{
-	if (test_and_set_bit(0, &dw_wdt.in_use))
-		return -EBUSY;
-
-	/* Make sure we don't get unloaded. */
-	__module_get(THIS_MODULE);
-
-	if (!dw_wdt_is_enabled()) {
-		/*
-		 * The watchdog is not currently enabled. Set the timeout to
-		 * something reasonable and then start it.
-		 */
-		dw_wdt_set_top(DW_WDT_DEFAULT_SECONDS);
-		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
-		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
-	}
-
-	dw_wdt_set_next_heartbeat();
-
-	return nonseekable_open(inode, filp);
-}
-
-static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
-			    size_t len, loff_t *offset)
-{
-	if (!len)
-		return 0;
-
-	if (!nowayout) {
-		size_t i;
-
-		dw_wdt.expect_close = 0;
-
-		for (i = 0; i < len; ++i) {
-			char c;
-
-			if (get_user(c, buf + i))
-				return -EFAULT;
-
-			if (c == 'V') {
-				dw_wdt.expect_close = 1;
-				break;
-			}
-		}
-	}
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 
-	dw_wdt_set_next_heartbeat();
-	dw_wdt_keepalive();
-	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
-
-	return len;
-}
-
-static u32 dw_wdt_time_left(void)
-{
-	return readl(dw_wdt.regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
-		clk_get_rate(dw_wdt.clk);
+	return readl(dw_wdt->regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
+		clk_get_rate(dw_wdt->clk);
 }
 
 static const struct watchdog_info dw_wdt_ident = {
@@ -233,78 +172,33 @@ static const struct watchdog_info dw_wdt_ident = {
 	.identity	= "Synopsys DesignWare Watchdog",
 };
 
-static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	unsigned long val;
-	int timeout;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user((void __user *)arg, &dw_wdt_ident,
-				    sizeof(dw_wdt_ident)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int __user *)arg);
-
-	case WDIOC_KEEPALIVE:
-		dw_wdt_set_next_heartbeat();
-		return 0;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(val, (int __user *)arg))
-			return -EFAULT;
-		timeout = dw_wdt_set_top(val);
-		return put_user(timeout , (int __user *)arg);
-
-	case WDIOC_GETTIMEOUT:
-		return put_user(dw_wdt_get_top(), (int __user *)arg);
-
-	case WDIOC_GETTIMELEFT:
-		/* Get the time left until expiry. */
-		if (get_user(val, (int __user *)arg))
-			return -EFAULT;
-		return put_user(dw_wdt_time_left(), (int __user *)arg);
-
-	default:
-		return -ENOTTY;
-	}
-}
-
-static int dw_wdt_release(struct inode *inode, struct file *filp)
-{
-	clear_bit(0, &dw_wdt.in_use);
-
-	if (!dw_wdt.expect_close) {
-		del_timer(&dw_wdt.timer);
-
-		if (!nowayout)
-			pr_crit("unexpected close, system will reboot soon\n");
-		else
-			pr_crit("watchdog cannot be disabled, system will reboot soon\n");
-	}
-
-	dw_wdt.expect_close = 0;
-
-	return 0;
-}
+static const struct watchdog_ops dw_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= dw_wdt_start,
+	.ping		= dw_wdt_ping,
+	.set_timeout	= dw_wdt_set_timeout,
+	.get_timeleft	= dw_wdt_get_timeleft,
+};
 
 #ifdef CONFIG_PM_SLEEP
 static int dw_wdt_suspend(struct device *dev)
 {
-	clk_disable_unprepare(dw_wdt.clk);
+	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dw_wdt->clk);
 
 	return 0;
 }
 
 static int dw_wdt_resume(struct device *dev)
 {
-	int err = clk_prepare_enable(dw_wdt.clk);
+	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
+	int err = clk_prepare_enable(dw_wdt->clk);
 
 	if (err)
 		return err;
 
-	dw_wdt_keepalive();
+	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
 }
@@ -312,67 +206,82 @@ static int dw_wdt_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
 
-static const struct file_operations wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.open		= dw_wdt_open,
-	.write		= dw_wdt_write,
-	.unlocked_ioctl	= dw_wdt_ioctl,
-	.release	= dw_wdt_release
-};
-
-static struct miscdevice dw_wdt_miscdev = {
-	.fops		= &wdt_fops,
-	.name		= "watchdog",
-	.minor		= WATCHDOG_MINOR,
-};
-
 static int dw_wdt_drv_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdd;
+	struct dw_wdt *dw_wdt;
+	struct resource *mem;
 	int ret;
-	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	dw_wdt.regs = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dw_wdt.regs))
-		return PTR_ERR(dw_wdt.regs);
+	dw_wdt = devm_kzalloc(dev, sizeof(*dw_wdt), GFP_KERNEL);
+	if (!dw_wdt)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dw_wdt->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(dw_wdt->regs))
+		return PTR_ERR(dw_wdt->regs);
 
-	dw_wdt.clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dw_wdt.clk))
-		return PTR_ERR(dw_wdt.clk);
+	dw_wdt->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(dw_wdt->clk))
+		return PTR_ERR(dw_wdt->clk);
 
-	ret = clk_prepare_enable(dw_wdt.clk);
+	ret = clk_prepare_enable(dw_wdt->clk);
 	if (ret)
 		return ret;
 
-	ret = misc_register(&dw_wdt_miscdev);
+	wdd = &dw_wdt->wdd;
+	wdd->info = &dw_wdt_ident;
+	wdd->ops = &dw_wdt_ops;
+	wdd->min_timeout = 1;
+	wdd->max_hw_timeout_ms =
+		dw_wdt_top_in_seconds(dw_wdt, DW_WDT_MAX_TOP) * 1000;
+	wdd->parent = dev;
+
+	watchdog_set_drvdata(wdd, dw_wdt);
+	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_init_timeout(wdd, 0, dev);
+
+	/*
+	 * If the watchdog is already running, use its already configured
+	 * timeout. Otherwise use the default or the value provided through
+	 * devicetree.
+	 */
+	if (dw_wdt_is_enabled(dw_wdt)) {
+		wdd->timeout = dw_wdt_get_top(dw_wdt);
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	} else {
+		wdd->timeout = DW_WDT_DEFAULT_SECONDS;
+		watchdog_init_timeout(wdd, 0, dev);
+	}
+
+	platform_set_drvdata(pdev, dw_wdt);
+
+	ret = watchdog_register_device(wdd);
 	if (ret)
 		goto out_disable_clk;
 
-	dw_wdt.restart_handler.notifier_call = dw_wdt_restart_handle;
-	dw_wdt.restart_handler.priority = 128;
-	ret = register_restart_handler(&dw_wdt.restart_handler);
+	dw_wdt->restart_handler.notifier_call = dw_wdt_restart_handle;
+	dw_wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&dw_wdt->restart_handler);
 	if (ret)
 		pr_warn("cannot register restart handler\n");
 
-	dw_wdt_set_next_heartbeat();
-	setup_timer(&dw_wdt.timer, dw_wdt_ping, 0);
-	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
-
 	return 0;
 
 out_disable_clk:
-	clk_disable_unprepare(dw_wdt.clk);
-
+	clk_disable_unprepare(dw_wdt->clk);
 	return ret;
 }
 
 static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
-	unregister_restart_handler(&dw_wdt.restart_handler);
-
-	misc_deregister(&dw_wdt_miscdev);
+	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(dw_wdt.clk);
+	unregister_restart_handler(&dw_wdt->restart_handler);
+	watchdog_unregister_device(&dw_wdt->wdd);
+	clk_disable_unprepare(dw_wdt->clk);
 
 	return 0;
 }
-- 
2.1.4
