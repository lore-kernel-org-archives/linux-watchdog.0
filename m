Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:48196 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbaGFSmK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Jul 2014 14:42:10 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>,
	Mike Turquette <mturquette@linaro.org>
Subject: [RFC PATCH 3/3] clk: rockchip: add restart notifier
Date: Sun, 06 Jul 2014 20:43:35 +0200
Message-ID: <3525040.Bkx5U4OiQ5@diego>
In-Reply-To: <1531376.ijR0PPyvmJ@diego>
References: <1531376.ijR0PPyvmJ@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add infrastructure to write the correct value to the restart register and
register the restart notifier for both rk3188 (including rk3066) and rk3188.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c |  2 ++
 drivers/clk/rockchip/clk-rk3288.c |  2 ++
 drivers/clk/rockchip/clk.c        | 23 +++++++++++++++++++++++
 drivers/clk/rockchip/clk.h        |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index a83a6d8..71b661a 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -631,6 +631,8 @@ static void __init rk3188_common_clk_init(struct device_node *np)
 
 	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
+
+	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST);
 }
 
 static void __init rk3066a_clk_init(struct device_node *np)
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 0d8c6c5..b604217 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -713,5 +713,7 @@ static void __init rk3288_clk_init(struct device_node *np)
 
 	rockchip_register_softrst(np, 9, reg_base + RK3288_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
+
+	rockchip_register_restart_notifier(RK3288_GLB_SRST_FST);
 }
 CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 278cf9d..0594941 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -25,6 +25,7 @@
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 #include "clk.h"
 
 /**
@@ -242,3 +243,25 @@ void __init rockchip_clk_register_branches(
 		rockchip_clk_add_lookup(clk, list->id);
 	}
 }
+
+static unsigned int reg_restart;
+static int rockchip_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	writel(0xfdb9, reg_base + reg_restart);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rockchip_restart_notifier = {
+	.notifier_call = rockchip_restart_notify,
+};
+
+void __init rockchip_register_restart_notifier(unsigned int reg)
+{
+	int ret;
+
+	reg_restart = reg;
+	ret = register_restart_notifier(&rockchip_restart_notifier);
+	if (ret)
+		pr_err("cannot register restart notifier, %d\n", ret);
+}
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 887cbde..0b5eab5 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -329,6 +329,7 @@ void rockchip_clk_register_branches(struct rockchip_clk_branch *clk_list,
 				    unsigned int nr_clk);
 void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
 				unsigned int nr_pll, int grf_lock_offset);
+void rockchip_register_restart_notifier(unsigned int reg);
 
 #define ROCKCHIP_SOFTRST_HIWORD_MASK	BIT(0)
 
-- 
1.9.0


