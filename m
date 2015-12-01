Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:58962 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbbLANIE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 08:08:04 -0500
Subject: [PATCH 07/11] watchdog: bcm63xx_wdt: Add get_timeleft function
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
Message-ID: <565D9BAC.2010809@simon.arlott.org.uk>
Date: Tue, 1 Dec 2015 13:07:56 +0000
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Return the remaining time from the hardware control register.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/watchdog/bcm63xx_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 0a19731..ab4a794 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -78,6 +78,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
+static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct bcm63xx_wdt_hw *hw = to_wdt_hw(wdd);
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
@@ -132,6 +145,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = bcm63xx_wdt_start,
 	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
 	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
@@ -256,6 +270,7 @@ module_platform_driver(bcm63xx_wdt_driver);
 
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
