Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46894 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdGBWlR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Jul 2017 18:41:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v7 03/16] mtd: spi-falcon: drop check of boot select
Date: Mon,  3 Jul 2017 00:40:38 +0200
Message-Id: <20170702224051.15109-4-hauke@hauke-m.de>
In-Reply-To: <20170702224051.15109-1-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not check which flash type the SoC was booted from before
using this driver. Assume that the device tree is correct and use this
driver when it was added to device tree. This also removes a build
dependency to the SoC code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/spi/spi-falcon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 286b2c81fc6b..f8638e82e5db 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -395,11 +395,6 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	int ret;
 
-	if (ltq_boot_select() != BS_SPI) {
-		dev_err(&pdev->dev, "invalid bootstrap options\n");
-		return -ENODEV;
-	}
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
 	if (!master)
 		return -ENOMEM;
-- 
2.11.0

