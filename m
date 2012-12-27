Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:58470 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab2L0Oia (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Dec 2012 09:38:30 -0500
From: Gabor Juhos <juhosg@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/3] watchdog: ath79_wdt: get register base from platform device's resources
Date: Thu, 27 Dec 2012 15:38:26 +0100
Message-Id: <1356619106-13403-3-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
References: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ath79_wdt driver uses a fixed memory address
currently. Although this is working with each
currently supported SoCs, but this may change
in the future. Additionally, the driver includes
platform specific header files in order to be
able to get the memory base of the watchdog
device.

The patch adds a memory resource to the platform
device, and converts the driver to get the base
address of the watchdog device from that.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-common.c |   10 ++++++++-
 drivers/watchdog/ath79_wdt.c |   48 +++++++++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 2093b1b..ea3a814 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -103,5 +103,13 @@ void __init ath79_register_uart(void)
 
 void __init ath79_register_wdt(void)
 {
-	platform_device_register_simple("ath79-wdt", -1, NULL, 0);
+	struct resource res;
+
+	memset(&res, 0, sizeof(res));
+
+	res.flags = IORESOURCE_MEM;
+	res.start = AR71XX_RESET_BASE + AR71XX_RESET_REG_WDOG_CTRL;
+	res.end = res.start + 0x8 - 1;
+
+	platform_device_register_simple("ath79-wdt", -1, &res, 1);
 }
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index dcd18ec..e786f64 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -33,13 +34,13 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-
 #define DRIVER_NAME	"ath79-wdt"
 
 #define WDT_TIMEOUT	15	/* seconds */
 
+#define WDOG_REG_CTRL		0x00
+#define WDOG_REG_TIMER		0x04
+
 #define WDOG_CTRL_LAST_RESET	BIT(31)
 #define WDOG_CTRL_ACTION_MASK	3
 #define WDOG_CTRL_ACTION_NONE	0	/* no action */
@@ -66,27 +67,38 @@ static struct clk *wdt_clk;
 static unsigned long wdt_freq;
 static int boot_status;
 static int max_timeout;
+static void __iomem *wdt_base;
+
+static inline void ath79_wdt_wr(unsigned reg, u32 val)
+{
+	iowrite32(val, wdt_base + reg);
+}
+
+static inline u32 ath79_wdt_rr(unsigned reg)
+{
+	return ioread32(wdt_base + reg);
+}
 
 static inline void ath79_wdt_keepalive(void)
 {
-	ath79_reset_wr(AR71XX_RESET_REG_WDOG, wdt_freq * timeout);
+	ath79_wdt_wr(WDOG_REG_TIMER, wdt_freq * timeout);
 	/* flush write */
-	ath79_reset_rr(AR71XX_RESET_REG_WDOG);
+	ath79_wdt_rr(WDOG_REG_TIMER);
 }
 
 static inline void ath79_wdt_enable(void)
 {
 	ath79_wdt_keepalive();
-	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_FCR);
+	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
 	/* flush write */
-	ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
+	ath79_wdt_rr(WDOG_REG_CTRL);
 }
 
 static inline void ath79_wdt_disable(void)
 {
-	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_NONE);
+	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
 	/* flush write */
-	ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
+	ath79_wdt_rr(WDOG_REG_CTRL);
 }
 
 static int ath79_wdt_set_timeout(int val)
@@ -226,9 +238,25 @@ static struct miscdevice ath79_wdt_miscdev = {
 
 static int ath79_wdt_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	u32 ctrl;
 	int err;
 
+	if (wdt_base)
+		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no memory resource found\n");
+		return -EINVAL;
+	}
+
+	wdt_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!wdt_base) {
+		dev_err(&pdev->dev, "unable to remap memory region\n");
+		return -ENOMEM;
+	}
+
 	wdt_clk = devm_clk_get(&pdev->dev, "wdt");
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
@@ -251,7 +279,7 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 			max_timeout, timeout);
 	}
 
-	ctrl = ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
+	ctrl = ath79_wdt_rr(WDOG_REG_CTRL);
 	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
 
 	err = misc_register(&ath79_wdt_miscdev);
-- 
1.7.10

