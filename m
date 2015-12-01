Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:58935 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbbLANGn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 08:06:43 -0500
Subject: [PATCH 06/11] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ from
 "periph" clk
To: Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	Jonas Gorski <jogo@openwrt.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9B5A.9030901@simon.arlott.org.uk>
Date: Tue, 1 Dec 2015 13:06:34 +0000
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of using a fixed clock HZ in the driver, obtain it from the
"periph" clk that the watchdog timer uses.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/watchdog/bcm63xx_wdt.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 2257924..0a19731 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -32,12 +33,14 @@
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_HZ			50000000		/* Fclk */
+#define WDT_CLK_NAME		"periph"
 
 struct bcm63xx_wdt_hw {
 	struct watchdog_device wdd;
 	raw_spinlock_t lock;
 	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clock_hz;
 	bool running;
 };
 
@@ -54,7 +57,7 @@ static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&hw->lock, flags);
-	bcm_writel(wdd->timeout * WDT_HZ, hw->regs + WDT_DEFVAL_REG);
+	bcm_writel(wdd->timeout * hw->clock_hz, hw->regs + WDT_DEFVAL_REG);
 	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
 	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
 	hw->running = true;
@@ -118,7 +121,7 @@ static void bcm63xx_wdt_isr(void *data)
 			die(PFX ": watchdog timer expired\n", get_irq_regs());
 		}
 
-		ms = timeleft / (WDT_HZ / 1000);
+		ms = timeleft / (hw->clock_hz / 1000);
 		dev_alert(hw->wdd.dev,
 			"warning timer fired, reboot in %ums\n", ms);
 	}
@@ -162,6 +165,25 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	hw->clk = devm_clk_get(&pdev->dev, WDT_CLK_NAME);
+	if (IS_ERR(hw->clk)) {
+		if (PTR_ERR(hw->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to request clock\n");
+		return PTR_ERR(hw->clk);
+	}
+
+	hw->clock_hz = clk_get_rate(hw->clk);
+	if (!hw->clock_hz) {
+		dev_err(&pdev->dev, "unable to fetch clock rate\n");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(hw->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return ret;
+	}
+
 	raw_spin_lock_init(&hw->lock);
 	hw->running = false;
 
@@ -169,7 +191,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &bcm63xx_wdt_ops;
 	wdd->info = &bcm63xx_wdt_info;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = 0xffffffff / WDT_HZ;
+	wdd->max_timeout = 0xffffffff / hw->clock_hz;
 	wdd->timeout = min(30U, wdd->max_timeout);
 
 	platform_set_drvdata(pdev, hw);
@@ -180,7 +202,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		return ret;
+		goto disable_clk;
 	}
 
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, hw);
@@ -198,6 +220,9 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 
 unregister_watchdog:
 	watchdog_unregister_device(wdd);
+
+disable_clk:
+	clk_disable_unprepare(hw->clk);
 	return ret;
 }
 
@@ -207,6 +232,7 @@ static int bcm63xx_wdt_remove(struct platform_device *pdev)
 
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
 	watchdog_unregister_device(&hw->wdd);
+	clk_disable_unprepare(hw->clk);
 	return 0;
 }
 
-- 
2.1.4


-- 
Simon Arlott
