Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:20814
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754609AbaBRMYK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Feb 2014 07:24:10 -0500
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <wim@iguana.be>
CC: <olof@lixom.net>, <festevam@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Date: Tue, 18 Feb 2014 09:23:54 -0300
Message-ID: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When building an ARM multi_v7_defconfig with LPAE option selected we get the
following build warning:

drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]

Fix it by using %pa to print 'phys_addr_t'.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 15321aa..6f9b4c6 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -269,7 +269,7 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
 
 	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
 
-	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rstout);
+	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
 	return devm_ioremap(&pdev->dev, rstout, 0x4);
 }
 
-- 
1.8.1.2


