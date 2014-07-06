Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:48183 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbaGFSlr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Jul 2014 14:41:47 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>,
	Mike Turquette <mturquette@linaro.org>
Subject: [RFC PATCH 2/3] clk: samsung: register restart notifiers for s3c2412 and s3c2443
Date: Sun, 06 Jul 2014 20:43:10 +0200
Message-ID: <1436436.XH2jFxzQOf@diego>
In-Reply-To: <1531376.ijR0PPyvmJ@diego>
References: <1531376.ijR0PPyvmJ@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

S3C2412, S3C2443 and their derivatives contain a special software-reset
register in their system-controller.

Therefore register a restart-notifier for those.

Tested on a s3c2416-based board, s3c2412 compile-tested.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/clk-s3c2412.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-s3c2443.c | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index 23e4313..840f9bd 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/reboot.h>
 
 #include <dt-bindings/clock/s3c2412.h>
 
@@ -26,6 +27,7 @@
 #define CLKCON		0x0c
 #define CLKDIVN		0x14
 #define CLKSRC		0x1c
+#define SWRST		0x30
 
 /* list of PLLs to be registered */
 enum s3c2412_plls {
@@ -204,6 +206,27 @@ struct samsung_clock_alias s3c2412_aliases[] __initdata = {
 	ALIAS(MSYSCLK, NULL, "fclk"),
 };
 
+static int s3c2412_restart_notify(struct notifier_block *this,
+				  unsigned long mode, void *cmd)
+{
+	/* errata "Watch-dog/Software Reset Problem" specifies that
+	 * this reset must be done with the SYSCLK sourced from
+	 * EXTCLK instead of FOUT to avoid a glitch in the reset
+	 * mechanism.
+	 *
+	 * See the watchdog section of the S3C2412 manual for more
+	 * information on this fix.
+	 */
+
+	__raw_writel(0x00, reg_base + CLKSRC);
+	__raw_writel(0x533C2412, reg_base + SWRST);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block s3c2412_restart_notifier = {
+	.notifier_call = s3c2412_restart_notify,
+};
+
 /*
  * fixed rate clocks generated outside the soc
  * Only necessary until the devicetree-move is complete
@@ -233,6 +256,7 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				    unsigned long ext_f, void __iomem *base)
 {
 	struct samsung_clk_provider *ctx;
+	int ret;
 	reg_base = base;
 
 	if (np) {
@@ -265,6 +289,10 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				   ARRAY_SIZE(s3c2412_aliases));
 
 	s3c2412_clk_sleep_init();
+
+	ret = register_restart_notifier(&s3c2412_restart_notifier);
+	if (ret)
+		pr_warn("cannot register restart notifier, %d\n", ret);
 }
 
 static void __init s3c2412_clk_init(struct device_node *np)
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index c4bbdab..0be33cc 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/reboot.h>
 
 #include <dt-bindings/clock/s3c2443.h>
 
@@ -33,6 +34,7 @@
 #define HCLKCON		0x30
 #define PCLKCON		0x34
 #define SCLKCON		0x38
+#define SWRST		0x44
 
 /* the soc types */
 enum supported_socs {
@@ -354,6 +356,17 @@ struct samsung_clock_alias s3c2450_aliases[] __initdata = {
 	ALIAS(PCLK_I2C1, "s3c2410-i2c.1", "i2c"),
 };
 
+static int s3c2443_restart_notify(struct notifier_block *this,
+				  unsigned long mode, void *cmd)
+{
+	__raw_writel(0x533c2443, reg_base + SWRST);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block s3c2443_restart_notifier = {
+	.notifier_call = s3c2443_restart_notify,
+};
+
 /*
  * fixed rate clocks generated outside the soc
  * Only necessary until the devicetree-move is complete
@@ -378,6 +391,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				    void __iomem *base)
 {
 	struct samsung_clk_provider *ctx;
+	int ret;
 	reg_base = base;
 
 	if (np) {
@@ -445,6 +459,10 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}
 
 	s3c2443_clk_sleep_init();
+
+	ret = register_restart_notifier(&s3c2443_restart_notifier);
+	if (ret)
+		pr_warn("cannot register restart notifier, %d\n", ret);
 }
 
 static void __init s3c2416_clk_init(struct device_node *np)
-- 
1.9.0


