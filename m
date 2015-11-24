Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:54352 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbbKXWMf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 17:12:35 -0500
Message-ID: <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <5651CC3C.5090200@simon.arlott.org.uk>
References: <5650BFD6.5030700@simon.arlott.org.uk>
    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
    <5651CB13.4090704@simon.arlott.org.uk>
    <5651CC3C.5090200@simon.arlott.org.uk>
Date: Tue, 24 Nov 2015 22:12:31 -0000
Subject: [PATCH (v2) 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ
 from "periph" clk
From: "Simon Arlott" <simon@fire.lp0.eu>
To: linux-watchdog@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Jason Cooper" <jason@lakedaemon.net>,
	"Marc Zyngier" <marc.zyngier@arm.com>,
	"Kevin Cernekee" <cernekee@gmail.com>,
	"Florian Fainelli" <f.fainelli@gmail.com>,
	"Wim Van Sebroeck" <wim@iguana.be>,
	"Maxime Bizon" <mbizon@freebox.fr>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, "Rob Herring" <robh+dt@kernel.org>,
	"Pawel Moll" <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	"Jonas Gorski" <jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of using a fixed clock HZ in the driver, obtain it from the
"periph" clk that the watchdog timer uses.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Changed to check for -EPROBE_DEFER before printing an error.

 drivers/watchdog/bcm63xx_wdt.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 1d2a501..3c7667a 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -13,6 +13,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -32,11 +33,13 @@

 #define PFX KBUILD_MODNAME

-#define WDT_HZ			50000000		/* Fclk */
+#define WDT_CLK_NAME		"periph"

 struct bcm63xx_wdt_hw {
 	raw_spinlock_t lock;
 	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clock_hz;
 	bool running;
 };

@@ -51,7 +54,7 @@ static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 	unsigned long flags;

 	raw_spin_lock_irqsave(&hw->lock, flags);
-	bcm_writel(wdd->timeout * WDT_HZ, hw->regs + WDT_DEFVAL_REG);
+	bcm_writel(wdd->timeout * hw->clock_hz, hw->regs + WDT_DEFVAL_REG);
 	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
 	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
 	hw->running = true;
@@ -116,7 +119,7 @@ static void bcm63xx_wdt_isr(void *data)
 			die(PFX ": watchdog timer expired\n", get_irq_regs());
 		}

-		ms = timeleft / (WDT_HZ / 1000);
+		ms = timeleft / (hw->clock_hz / 1000);
 		dev_alert(wdd->dev,
 			"warning timer fired, reboot in %ums\n", ms);
 	}
@@ -160,14 +163,32 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
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
-	hw->running = false;

 	wdd->parent = &pdev->dev;
 	wdd->ops = &bcm63xx_wdt_ops;
 	wdd->info = &bcm63xx_wdt_info;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = 0xffffffff / WDT_HZ;
+	wdd->max_timeout = 0xffffffff / hw->clock_hz;
 	wdd->timeout = min(30U, wdd->max_timeout);

 	watchdog_set_drvdata(wdd, hw);
@@ -179,7 +200,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
-		return ret;
+		goto disable_clk;
 	}

 	ret = watchdog_register_device(wdd);
@@ -197,15 +218,20 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)

 unregister_timer:
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
+
+disable_clk:
+	clk_disable_unprepare(hw->clk);
 	return ret;
 }

 static int bcm63xx_wdt_remove(struct platform_device *pdev)
 {
 	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);

 	bcm63xx_timer_unregister(TIMER_WDT_ID);
 	watchdog_unregister_device(wdd);
+	clk_disable_unprepare(hw->clk);
 	return 0;
 }

-- 
2.1.4

-- 
Simon Arlott
