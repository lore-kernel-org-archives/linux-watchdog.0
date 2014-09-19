Return-path: <jszhang@marvell.com>
From: Jisheng Zhang <jszhang@marvell.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/2] watchdog: dw_wdt: add restart handler support
Date: Fri, 19 Sep 2014 14:29:59 +0800
Message-ID: <1411108199-1280-3-git-send-email-jszhang@marvell.com>
In-Reply-To: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
References: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The kernel core now provides an API to trigger a system restart.
Register with it to support restarting the system via. watchdog.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/watchdog/dw_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index ad0619d..4ca41e9 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -29,9 +29,11 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/uaccess.h>
@@ -62,6 +64,7 @@ static struct {
 	unsigned long		next_heartbeat;
 	struct timer_list	timer;
 	int			expect_close;
+	struct notifier_block	restart_handler;
 } dw_wdt;
 
 static inline int dw_wdt_is_enabled(void)
@@ -119,6 +122,22 @@ static void dw_wdt_keepalive(void)
 	       WDOG_COUNTER_RESTART_REG_OFFSET);
 }
 
+static int dw_wdt_restart_handle(struct notifier_block *this,
+				unsigned long mode, void *cmd)
+{
+	u32 val;
+
+	writel(0, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+	val = readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
+		writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
+			WDOG_COUNTER_RESTART_REG_OFFSET);
+	else
+		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
+		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+	return NOTIFY_DONE;
+}
+
 static void dw_wdt_ping(unsigned long data)
 {
 	if (time_before(jiffies, dw_wdt.next_heartbeat) ||
@@ -315,6 +334,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk;
 
+	dw_wdt.restart_handler.notifier_call = dw_wdt_restart_handle;
+	dw_wdt.restart_handler.priority = 128;
+	ret = register_restart_handler(&dw_wdt.restart_handler);
+	if (ret)
+		pr_warn("cannot register restart handler\n");
+
 	dw_wdt_set_next_heartbeat();
 	setup_timer(&dw_wdt.timer, dw_wdt_ping, 0);
 	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
@@ -329,6 +354,8 @@ out_disable_clk:
 
 static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
+	unregister_restart_handler(&dw_wdt.restart_handler);
+
 	misc_deregister(&dw_wdt_miscdev);
 
 	clk_disable_unprepare(dw_wdt.clk);
-- 
2.1.0
