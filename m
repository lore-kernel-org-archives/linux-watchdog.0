Return-path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
Date: Sat, 10 Jan 2015 19:29:10 +0100
Message-Id: <1420914550-18335-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1420914550-18335-1-git-send-email-lars@metafoo.de>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
List-ID: <linux-watchdog@vger.kernel.org>

On JZ4740 reset is handled by the watchdog peripheral. This patch moves the
reset handler code from a architecture specific file to the watchdog peripheral
driver and registers it as a generic reset handler. This will allow it to be
reused by other SoCs that use the same watchdog peripheral.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/reset.c      |   22 ----------------------
 drivers/watchdog/jz4740_wdt.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index b6c6343..0871b94 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -35,27 +35,6 @@ static void jz4740_halt(void)
 	}
 }
 
-#define JZ_REG_WDT_DATA 0x00
-#define JZ_REG_WDT_COUNTER_ENABLE 0x04
-#define JZ_REG_WDT_COUNTER 0x08
-#define JZ_REG_WDT_CTRL 0x0c
-
-static void jz4740_restart(char *command)
-{
-	void __iomem *wdt_base = ioremap(JZ4740_WDT_BASE_ADDR, 0x0f);
-
-	jz4740_timer_enable_watchdog();
-
-	writeb(0, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-
-	writew(0, wdt_base + JZ_REG_WDT_COUNTER);
-	writew(0, wdt_base + JZ_REG_WDT_DATA);
-	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
-
-	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_halt();
-}
-
 #define JZ_REG_RTC_CTRL			0x00
 #define JZ_REG_RTC_HIBERNATE		0x20
 #define JZ_REG_RTC_WAKEUP_FILTER	0x24
@@ -112,7 +91,6 @@ static void jz4740_power_off(void)
 
 void jz4740_reset_init(void)
 {
-	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
 	pm_power_off = jz4740_power_off;
 }
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 18e41af..86a4c55 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/reboot.h>
 
 #include <asm/mach-jz4740/timer.h>
 
@@ -65,6 +66,8 @@ struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
 	void __iomem *base;
 	struct clk *rtc_clk;
+
+	struct notifier_block restart_handler;
 };
 
 static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
@@ -142,6 +145,25 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.set_timeout = jz4740_wdt_set_timeout,
 };
 
+static int jz4740_wdt_restart(struct notifier_block *nb,
+	unsigned long mode, void *cmd)
+{
+	struct jz4740_wdt_drvdata *drvdata = container_of(nb,
+		struct jz4740_wdt_drvdata, restart_handler);
+
+	jz4740_timer_enable_watchdog();
+
+	writeb(0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+
+	writew(0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	writew(0, drvdata->base + JZ_REG_WDT_TIMER_DATA);
+	writew(JZ_WDT_CLOCK_EXT, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
+
+	writeb(1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+
+	return NOTIFY_DONE;
+}
+
 static int jz4740_wdt_probe(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata;
@@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_clk;
 
+	drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
+	drvdata->restart_handler.priority = 128;
+	ret = register_restart_handler(&drvdata->restart_handler);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot register restart handler, %d\n",
+			ret);
+		goto err_unregister_watchdog;
+	}
+
 	platform_set_drvdata(pdev, drvdata);
 	return 0;
 
+err_unregister_watchdog:
+	watchdog_unregister_device(&drvdata->wdt);
 err_disable_clk:
 	clk_put(drvdata->rtc_clk);
 err_out:
@@ -199,6 +232,7 @@ static int jz4740_wdt_remove(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
 
+	unregister_restart_handler(&drvdata->restart_handler);
 	jz4740_wdt_stop(&drvdata->wdt);
 	watchdog_unregister_device(&drvdata->wdt);
 	clk_put(drvdata->rtc_clk);
-- 
1.7.10.4
