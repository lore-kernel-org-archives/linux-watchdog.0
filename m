Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:57024 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWhd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:33 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 3/6] ARM: SAMSUNG: Add watchdog reset driver
Date: Sun, 19 May 2013 00:37:04 +0200
Message-Id: <1368916627-23139-4-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds a watchdog reset driver that can be used on Samsung SoCs
that do not provide dedicated reset method. It replaces the legacy
helper function that relies on static IO mapping.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/Kconfig                      |  6 ++
 arch/arm/plat-samsung/Makefile                     |  1 +
 .../arm/plat-samsung/include/plat/watchdog-reset.h |  9 ++
 arch/arm/plat-samsung/watchdog-reset.c             | 97 ++++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm/plat-samsung/watchdog-reset.c

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8ed2de..ec68155 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -475,6 +475,12 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
+config SAMSUNG_WDT_RESET
+	bool
+	help
+	  Compile support for system restart by triggering watchdog reset.
+	  Used on SoCs that do not provide dedicated reset control.
+
 config S5P_PM
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index a23c460..03cea14 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PM)		+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
+obj-$(CONFIG_SAMSUNG_WDT_RESET)	+= watchdog-reset.o
 
 obj-$(CONFIG_S5P_PM)		+= s5p-pm.o s5p-irq-pm.o
 obj-$(CONFIG_S5P_SLEEP)		+= s5p-sleep.o
diff --git a/arch/arm/plat-samsung/include/plat/watchdog-reset.h b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
index bc4db9b..4def1b2 100644
--- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
+++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
@@ -10,6 +10,9 @@
  * published by the Free Software Foundation.
 */
 
+#ifndef __PLAT_WATCHDOG_RESET_H
+#define __PLAT_WATCHDOG_RESET_H
+
 #include <plat/clock.h>
 #include <plat/regs-watchdog.h>
 #include <mach/map.h>
@@ -44,3 +47,9 @@ static inline void arch_wdt_reset(void)
 	/* delay to allow the serial port to show the message */
 	mdelay(50);
 }
+
+extern void samsung_wdt_reset(void);
+extern void samsung_wdt_reset_of_init(void);
+extern void samsung_wdt_reset_init(void __iomem *base);
+
+#endif /* __PLAT_WATCHDOG_RESET_H */
diff --git a/arch/arm/plat-samsung/watchdog-reset.c b/arch/arm/plat-samsung/watchdog-reset.c
new file mode 100644
index 0000000..2ecb50be
--- /dev/null
+++ b/arch/arm/plat-samsung/watchdog-reset.c
@@ -0,0 +1,97 @@
+/* arch/arm/plat-samsung/watchdog-reset.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Coyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Watchdog reset support for Samsung SoCs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define S3C2410_WTCON			0x00
+#define S3C2410_WTDAT			0x04
+#define S3C2410_WTCNT			0x08
+
+#define S3C2410_WTCON_ENABLE		(1 << 5)
+#define S3C2410_WTCON_DIV16		(0 << 3)
+#define S3C2410_WTCON_RSTEN		(1 << 0)
+#define S3C2410_WTCON_PRESCALE(x)	((x) << 8)
+
+static void __iomem *wdt_base;
+static struct clk *wdt_clock;
+
+void samsung_wdt_reset(void)
+{
+	if (!wdt_base) {
+		pr_err("%s: wdt reset not initialized\n", __func__);
+		/* delay to allow the serial port to show the message */
+		mdelay(50);
+		return;
+	}
+
+	if (!IS_ERR(wdt_clock))
+		clk_prepare_enable(wdt_clock);
+
+	/* disable watchdog, to be safe  */
+	__raw_writel(0, wdt_base + S3C2410_WTCON);
+
+	/* put initial values into count and data */
+	__raw_writel(0x80, wdt_base + S3C2410_WTCNT);
+	__raw_writel(0x80, wdt_base + S3C2410_WTDAT);
+
+	/* set the watchdog to go and reset... */
+	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
+			S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
+			wdt_base + S3C2410_WTCON);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	pr_err("Watchdog reset failed to assert reset\n");
+
+	/* delay to allow the serial port to show the message */
+	mdelay(50);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id s3c2410_wdt_match[] = {
+	{ .compatible = "samsung,s3c2410-wdt" },
+	{},
+};
+
+void __init samsung_wdt_reset_of_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, s3c2410_wdt_match);
+	if (!np) {
+		pr_err("%s: failed to find watchdog node\n", __func__);
+		return;
+	}
+
+	wdt_base = of_iomap(np, 0);
+	if (!wdt_base) {
+		pr_err("%s: failed to map watchdog registers\n", __func__);
+		return;
+	}
+
+	wdt_clock = of_clk_get(np, 0);
+}
+#endif
+
+void __init samsung_wdt_reset_init(void __iomem *base)
+{
+	wdt_base = base;
+	wdt_clock = clk_get(NULL, "watchdog");
+}
-- 
1.8.2.1

