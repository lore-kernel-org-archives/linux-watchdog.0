Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from newton.telenet-ops.be ([195.130.132.45]:58363 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbcHSGd3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Aug 2016 02:33:29 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by newton.telenet-ops.be (Postfix) with ESMTP id 3sFYBq6xb3zMtGPv
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Aug 2016 19:34:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Date: Thu, 18 Aug 2016 19:34:27 +0200
Message-Id: <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Replace the custom minimal clock implementation for Toshiba TXx9 by a
basic implementation using the Common Clock Framework.

The only clocks that are provided are those needed by TXx9-specific
drivers ("imbus" and "spi" (TX4938 only)), and their common parent
clock "gbus". Other clocks can be added when needed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on RBTX4927.
---
 arch/mips/txx9/Kconfig         |  2 +-
 arch/mips/txx9/generic/setup.c | 68 ++++++++++++++++++++----------------------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 8c337d60f790db9f..42923478d45ca363 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -20,7 +20,7 @@ config MACH_TXX9
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select HAVE_CLK
+	select COMMON_CLK
 
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index ada92db92f87d91a..2fdbcf91b2cc472c 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -15,7 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/module.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
@@ -83,40 +84,6 @@ int txx9_ccfg_toeon __initdata;
 int txx9_ccfg_toeon __initdata = 1;
 #endif
 
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 2);
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2);
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
 #define BOARD_VEC(board)	extern struct txx9_board_vec board;
 #include <asm/txx9/boards.h>
 #undef BOARD_VEC
@@ -560,8 +527,39 @@ void __init plat_time_init(void)
 	txx9_board_vec->time_init();
 }
 
+static void txx9_clk_init(void)
+{
+	struct clk *clk;
+	int error;
+
+	clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
+	if (IS_ERR(clk)) {
+		error = PTR_ERR(clk);
+		goto fail;
+	}
+
+	clk = clk_register_fixed_factor(NULL, "imbus", "gbus", 0, 1, 2);
+	error = clk_register_clkdev(clk, "imbus_clk", NULL);
+	if (error)
+		goto fail;
+
+	if (TX4938_REV_PCODE() == 0x4938) {
+		clk = clk_register_fixed_factor(NULL, "spi", "gbus", 0, 1, 4);
+		error = clk_register_clkdev(clk, "spi-baseclk", NULL);
+		if (error)
+			goto fail;
+	}
+
+	return;
+
+fail:
+	pr_err("Failed to register clocks: %d\n", error);
+}
+
 static int __init _txx9_arch_init(void)
 {
+	txx9_clk_init();
+
 	if (txx9_board_vec->arch_init)
 		txx9_board_vec->arch_init();
 	return 0;
-- 
1.9.1

