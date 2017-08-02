Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42640 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbdHBW7R (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 18:59:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v8 11/16] MIPS: lantiq: remove old reset controller implementation
Date: Thu,  3 Aug 2017 00:57:12 +0200
Message-Id: <20170802225717.24408-12-hauke@hauke-m.de>
In-Reply-To: <20170802225717.24408-1-hauke@hauke-m.de>
References: <20170802225717.24408-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This code is now replaced by a reset controller in drivers/reset/reset-
lantiq-rcu.c. The old code was never used anyway.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/reset.c | 68 -------------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 2dedcf939901..5cb9309b0047 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -194,74 +194,6 @@ int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 	return 0;
 }
 
-/* reset a io domain for u micro seconds */
-void ltq_reset_once(unsigned int module, ulong u)
-{
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | module, RCU_RST_REQ);
-	udelay(u);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
-}
-
-static int ltq_assert_device(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val |= BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_deassert_device(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val &= ~BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_reset_device(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	ltq_assert_device(rcdev, id);
-	return ltq_deassert_device(rcdev, id);
-}
-
-static const struct reset_control_ops reset_ops = {
-	.reset = ltq_reset_device,
-	.assert = ltq_assert_device,
-	.deassert = ltq_deassert_device,
-};
-
-static struct reset_controller_dev reset_dev = {
-	.ops			= &reset_ops,
-	.owner			= THIS_MODULE,
-	.nr_resets		= 32,
-	.of_reset_n_cells	= 1,
-};
-
-void ltq_rst_init(void)
-{
-	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
-						"lantiq,xway-reset");
-	if (!reset_dev.of_node)
-		pr_err("Failed to find reset controller node");
-	else
-		reset_controller_register(&reset_dev);
-}
-
 static void ltq_machine_restart(char *command)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_REQ);
-- 
2.11.0

