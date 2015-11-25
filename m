Return-path: <simon@fire.lp0.eu>
Subject: [PATCH (v4) 7/11] watchdog: bcm63xx_wdt: Add get_timeleft function
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <56552214.2050808@roeck-us.net> <56556E84.50202@simon.arlott.org.uk>
 <56563B1E.6050906@simon.arlott.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Kevin Cernekee <cernekee@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
 Maxime Bizon <mbizon@freebox.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Jonas Gorski <jogo@openwrt.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56563C2C.60308@simon.arlott.org.uk>
Date: Wed, 25 Nov 2015 22:54:36 +0000
MIME-Version: 1.0
In-Reply-To: <56563B1E.6050906@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Return the remaining time from the hardware control register.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
On 25/11/15 02:51, Guenter Roeck wrote:
> This is really two logical changes, isn't it ?

Patch 7 correctly split into two patches this time.

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
