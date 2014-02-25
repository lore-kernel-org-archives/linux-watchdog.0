Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:41186
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbaBYQS1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Feb 2014 11:18:27 -0500
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jason@lakedaemon.net>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH RESEND] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Date: Tue, 25 Feb 2014 13:17:33 -0300
Message-ID: <1393345053-16964-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When building an ARM multi_v7_defconfig with LPAE option selected we get the
following build warning:

drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]

Fix it by using %pa to print 'phys_addr_t'.

Reported-by: Olof's autobuilder <build@lixom.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Acked-by: Wim Van Sebroeck <wim@iguana.be>
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


