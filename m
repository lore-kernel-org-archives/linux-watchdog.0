Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:54241 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbdHSWUQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 19 Aug 2017 18:20:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v10 13/16] MIPS: lantiq: remove old GPHY loader code
Date: Sun, 20 Aug 2017 00:18:20 +0200
Message-Id: <20170819221823.13850-14-hauke@hauke-m.de>
In-Reply-To: <20170819221823.13850-1-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The GPHY loader was replaced by a new more flexible driver. Remove the
old driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/Makefile        |   2 -
 arch/mips/lantiq/xway/reset.c         | 106 -------------------------------
 arch/mips/lantiq/xway/xrx200_phy_fw.c | 113 ----------------------------------
 3 files changed, 221 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c

diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index a2edc538f477..6daf3149e7ca 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,5 +1,3 @@
 obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o dcdc.o
 
 obj-y += vmmc.o
-
-obj-$(CONFIG_XRX200_PHY_FW) += xrx200_phy_fw.o
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 5cb9309b0047..be5fd29de523 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -27,18 +27,6 @@
 #define RCU_RST_REQ		0x0010
 /* reset status register */
 #define RCU_RST_STAT		0x0014
-/* vr9 gphy registers */
-#define RCU_GFS_ADD0_XRX200	0x0020
-#define RCU_GFS_ADD1_XRX200	0x0068
-/* xRX300 gphy registers */
-#define RCU_GFS_ADD0_XRX300	0x0020
-#define RCU_GFS_ADD1_XRX300	0x0058
-#define RCU_GFS_ADD2_XRX300	0x00AC
-/* xRX330 gphy registers */
-#define RCU_GFS_ADD0_XRX330	0x0020
-#define RCU_GFS_ADD1_XRX330	0x0058
-#define RCU_GFS_ADD2_XRX330	0x00AC
-#define RCU_GFS_ADD3_XRX330	0x0264
 
 /* xbar BE flag */
 #define RCU_AHB_ENDIAN          0x004C
@@ -48,15 +36,6 @@
 #define RCU_RD_GPHY0_XRX200	BIT(31)
 #define RCU_RD_SRST		BIT(30)
 #define RCU_RD_GPHY1_XRX200	BIT(29)
-/* xRX300 bits */
-#define RCU_RD_GPHY0_XRX300	BIT(31)
-#define RCU_RD_GPHY1_XRX300	BIT(29)
-#define RCU_RD_GPHY2_XRX300	BIT(28)
-/* xRX330 bits */
-#define RCU_RD_GPHY0_XRX330	BIT(31)
-#define RCU_RD_GPHY1_XRX330	BIT(29)
-#define RCU_RD_GPHY2_XRX330	BIT(28)
-#define RCU_RD_GPHY3_XRX330	BIT(10)
 
 /* reset cause */
 #define RCU_STAT_SHIFT		26
@@ -98,7 +77,6 @@
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
 static struct device_node *ltq_rcu_np;
-static DEFINE_SPINLOCK(ltq_rcu_lock);
 
 static void ltq_rcu_w32(uint32_t val, uint32_t reg_off)
 {
@@ -110,90 +88,6 @@ static uint32_t ltq_rcu_r32(uint32_t reg_off)
 	return ltq_r32(ltq_rcu_membase + reg_off);
 }
 
-static void ltq_rcu_w32_mask(uint32_t clr, uint32_t set, uint32_t reg_off)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ltq_rcu_lock, flags);
-	ltq_rcu_w32((ltq_rcu_r32(reg_off) & ~(clr)) | (set), reg_off);
-	spin_unlock_irqrestore(&ltq_rcu_lock, flags);
-}
-
-struct ltq_gphy_reset {
-	u32 rd;
-	u32 addr;
-};
-
-/* reset / boot a gphy */
-static struct ltq_gphy_reset xrx200_gphy[] = {
-	{RCU_RD_GPHY0_XRX200, RCU_GFS_ADD0_XRX200},
-	{RCU_RD_GPHY1_XRX200, RCU_GFS_ADD1_XRX200},
-};
-
-/* reset / boot a gphy */
-static struct ltq_gphy_reset xrx300_gphy[] = {
-	{RCU_RD_GPHY0_XRX300, RCU_GFS_ADD0_XRX300},
-	{RCU_RD_GPHY1_XRX300, RCU_GFS_ADD1_XRX300},
-	{RCU_RD_GPHY2_XRX300, RCU_GFS_ADD2_XRX300},
-};
-
-/* reset / boot a gphy */
-static struct ltq_gphy_reset xrx330_gphy[] = {
-	{RCU_RD_GPHY0_XRX330, RCU_GFS_ADD0_XRX330},
-	{RCU_RD_GPHY1_XRX330, RCU_GFS_ADD1_XRX330},
-	{RCU_RD_GPHY2_XRX330, RCU_GFS_ADD2_XRX330},
-	{RCU_RD_GPHY3_XRX330, RCU_GFS_ADD3_XRX330},
-};
-
-static void xrx200_gphy_boot_addr(struct ltq_gphy_reset *phy_regs,
-				  dma_addr_t dev_addr)
-{
-	ltq_rcu_w32_mask(0, phy_regs->rd, RCU_RST_REQ);
-	ltq_rcu_w32(dev_addr, phy_regs->addr);
-	ltq_rcu_w32_mask(phy_regs->rd, 0,  RCU_RST_REQ);
-}
-
-/* reset and boot a gphy. these phys only exist on xrx200 SoC */
-int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
-{
-	struct clk *clk;
-
-	if (!of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200")) {
-		dev_err(dev, "this SoC has no GPHY\n");
-		return -EINVAL;
-	}
-
-	if (of_machine_is_compatible("lantiq,vr9")) {
-		clk = clk_get_sys("1f203000.rcu", "gphy");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-		clk_enable(clk);
-	}
-
-	dev_info(dev, "booting GPHY%u firmware at %X\n", id, dev_addr);
-
-	if (of_machine_is_compatible("lantiq,vr9")) {
-		if (id >= ARRAY_SIZE(xrx200_gphy)) {
-			dev_err(dev, "%u is an invalid gphy id\n", id);
-			return -EINVAL;
-		}
-		xrx200_gphy_boot_addr(&xrx200_gphy[id], dev_addr);
-	} else if (of_machine_is_compatible("lantiq,ar10")) {
-		if (id >= ARRAY_SIZE(xrx300_gphy)) {
-			dev_err(dev, "%u is an invalid gphy id\n", id);
-			return -EINVAL;
-		}
-		xrx200_gphy_boot_addr(&xrx300_gphy[id], dev_addr);
-	} else if (of_machine_is_compatible("lantiq,grx390")) {
-		if (id >= ARRAY_SIZE(xrx330_gphy)) {
-			dev_err(dev, "%u is an invalid gphy id\n", id);
-			return -EINVAL;
-		}
-		xrx200_gphy_boot_addr(&xrx330_gphy[id], dev_addr);
-	}
-	return 0;
-}
-
 static void ltq_machine_restart(char *command)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_REQ);
diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
deleted file mode 100644
index f0a0f2d431b2..000000000000
--- a/arch/mips/lantiq/xway/xrx200_phy_fw.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Lantiq XRX200 PHY Firmware Loader
- * Author: John Crispin
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2012 John Crispin <john@phrozen.org>
- */
-
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/firmware.h>
-#include <linux/of_platform.h>
-
-#include <lantiq_soc.h>
-
-#define XRX200_GPHY_FW_ALIGN	(16 * 1024)
-
-static dma_addr_t xway_gphy_load(struct platform_device *pdev)
-{
-	const struct firmware *fw;
-	dma_addr_t dev_addr = 0;
-	const char *fw_name;
-	void *fw_addr;
-	size_t size;
-
-	if (of_get_property(pdev->dev.of_node, "firmware1", NULL) ||
-		of_get_property(pdev->dev.of_node, "firmware2", NULL)) {
-		switch (ltq_soc_type()) {
-		case SOC_TYPE_VR9:
-			if (of_property_read_string(pdev->dev.of_node,
-						    "firmware1", &fw_name)) {
-				dev_err(&pdev->dev,
-					"failed to load firmware filename\n");
-				return 0;
-			}
-			break;
-		case SOC_TYPE_VR9_2:
-			if (of_property_read_string(pdev->dev.of_node,
-						    "firmware2", &fw_name)) {
-				dev_err(&pdev->dev,
-					"failed to load firmware filename\n");
-				return 0;
-			}
-			break;
-		}
-	} else if (of_property_read_string(pdev->dev.of_node,
-					 "firmware", &fw_name)) {
-		dev_err(&pdev->dev, "failed to load firmware filename\n");
-		return 0;
-	}
-
-	dev_info(&pdev->dev, "requesting %s\n", fw_name);
-	if (request_firmware(&fw, fw_name, &pdev->dev)) {
-		dev_err(&pdev->dev, "failed to load firmware: %s\n", fw_name);
-		return 0;
-	}
-
-	/*
-	 * GPHY cores need the firmware code in a persistent and contiguous
-	 * memory area with a 16 kB boundary aligned start address
-	 */
-	size = fw->size + XRX200_GPHY_FW_ALIGN;
-
-	fw_addr = dma_alloc_coherent(&pdev->dev, size, &dev_addr, GFP_KERNEL);
-	if (fw_addr) {
-		fw_addr = PTR_ALIGN(fw_addr, XRX200_GPHY_FW_ALIGN);
-		dev_addr = ALIGN(dev_addr, XRX200_GPHY_FW_ALIGN);
-		memcpy(fw_addr, fw->data, fw->size);
-	} else {
-		dev_err(&pdev->dev, "failed to alloc firmware memory\n");
-	}
-
-	release_firmware(fw);
-	return dev_addr;
-}
-
-static int xway_phy_fw_probe(struct platform_device *pdev)
-{
-	dma_addr_t fw_addr;
-	struct property *pp;
-	unsigned char *phyids;
-	int i, ret = 0;
-
-	fw_addr = xway_gphy_load(pdev);
-	if (!fw_addr)
-		return -EINVAL;
-	pp = of_find_property(pdev->dev.of_node, "phys", NULL);
-	if (!pp)
-		return -ENOENT;
-	phyids = pp->value;
-	for (i = 0; i < pp->length && !ret; i++)
-		ret = xrx200_gphy_boot(&pdev->dev, phyids[i], fw_addr);
-	if (!ret)
-		mdelay(100);
-	return ret;
-}
-
-static const struct of_device_id xway_phy_match[] = {
-	{ .compatible = "lantiq,phy-xrx200" },
-	{},
-};
-
-static struct platform_driver xway_phy_driver = {
-	.probe = xway_phy_fw_probe,
-	.driver = {
-		.name = "phy-xrx200",
-		.of_match_table = xway_phy_match,
-	},
-};
-builtin_platform_driver(xway_phy_driver);
-- 
2.11.0

