Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:59525 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbbKVOJa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Nov 2015 09:09:30 -0500
Subject: [PATCH 7/10] watchdog: bcm63xx_wdt: Add get_timeleft function
To: Guenter Roeck <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5651CC90.7090402@simon.arlott.org.uk>
Date: Sun, 22 Nov 2015 14:09:20 +0000
MIME-Version: 1.0
In-Reply-To: <5651CB13.4090704@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Return the remaining time from the hardware control register.

Warn when the device is registered if the hardware watchdog is currently
running and report the remaining time left.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/watchdog/bcm63xx_wdt.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index eb5e551..7109eb4 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -75,6 +76,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
+static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	val = __raw_readl(hw->regs + WDT_CTL_REG);
+	val /= hw->clock_hz;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return val;
+}
+
 static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
 	unsigned int timeout)
 {
@@ -130,6 +144,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = bcm63xx_wdt_start,
 	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
 	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
@@ -144,6 +159,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	struct bcm63xx_wdt_hw *hw;
 	struct watchdog_device *wdd;
 	struct resource *r;
+	u32 timeleft1, timeleft2;
+	unsigned int timeleft;
 	int ret;
 
 	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
@@ -182,7 +199,6 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	}
 
 	raw_spin_lock_init(&hw->lock);
-	hw->running = false;
 
 	wdd->parent = &pdev->dev;
 	wdd->ops = &bcm63xx_wdt_ops;
@@ -197,6 +213,23 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(wdd, 0, &pdev->dev);
 	watchdog_set_nowayout(wdd, nowayout);
 
+	/* Compare two reads of the time left value, 2 clock ticks apart */
+	rmb();
+	timeleft1 = __raw_readl(hw->regs + WDT_CTL_REG);
+	udelay(DIV_ROUND_UP(1000000, hw->clock_hz / 2));
+	/* Ensure the register is read twice */
+	rmb();
+	timeleft2 = __raw_readl(hw->regs + WDT_CTL_REG);
+
+	/* If the time left is changing, the watchdog is running */
+	if (timeleft1 != timeleft2) {
+		hw->running = true;
+		timeleft = bcm63xx_wdt_get_timeleft(wdd);
+	} else {
+		hw->running = false;
+		timeleft = 0;
+	}
+
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
@@ -214,6 +247,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		dev_name(wdd->dev), hw->regs,
 		wdd->timeout, wdd->max_timeout);
 
+	if (timeleft > 0)
+		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
 	return 0;
 
 unregister_timer:
@@ -255,6 +290,7 @@ module_platform_driver(bcm63xx_wdt_driver);
 
 MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_AUTHOR("Simon Arlott");
 MODULE_DESCRIPTION("Driver for the Broadcom BCM63xx SoC watchdog");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bcm63xx-wdt");
-- 
2.1.4

-- 
Simon Arlott
