Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Guenter Roeck <linux@roeck-us.net>, mturquette@linaro.org
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Jonas Jensen <jonas.jensen@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: rockchip: add restart handler
Date: Sat, 09 Aug 2014 22:25:12 +0200
Message-ID: <1812271.NdMZDbhgpa@diego>
In-Reply-To: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
References: <1407203338-12915-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

Add infrastructure to write the correct value to the restart register and
register the restart notifier for both rk3188 (including rk3066) and rk3288.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This of course needs the restart generalization from Guenter Roeck
and would need to go with that series.

changes since v1:
- adapt to changed restart notifier handling

 drivers/clk/rockchip/clk-rk3188.c |  2 ++
 drivers/clk/rockchip/clk-rk3288.c |  2 ++
 drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h        |  1 +
 4 files changed, 30 insertions(+)

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
index 278cf9d..aa41433 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -25,6 +25,7 @@
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 #include "clk.h"
 
 /**
@@ -242,3 +243,27 @@ void __init rockchip_clk_register_branches(
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
+static struct notifier_block rockchip_restart_handler = {
+	.notifier_call = rockchip_restart_notify,
+	.priority = 128,
+};
+
+void __init rockchip_register_restart_notifier(unsigned int reg)
+{
+	int ret;
+
+	reg_restart = reg;
+	ret = register_restart_handler(&rockchip_restart_handler);
+	if (ret)
+		pr_err("%s: cannot register restart handler, %d\n",
+		       __func__, ret);
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
2.0.1
