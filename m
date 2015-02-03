Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:45862 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbbBCK0I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 05:26:08 -0500
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <wim@iguana.be>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
	<paul@crapouillou.net>
Subject: [PATCH_V3 2/2] watchdog: jz4740: Add DT support
Date: Tue, 3 Feb 2015 10:25:48 +0000
Message-ID: <1422959148-38075-3-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1422959148-38075-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422959148-38075-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add DT support to the jz4740 driver. Simple of_match_ptr. No other
modification for probe needed

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---
V3 Typo in Reviewed-by: Guenter Roeck <linux@roeck-us.net>

V2 changes
Add module device table. Even though we are moving to non-dt for jz4740.
Lets try and not break things while at it.

Renamed jz4740_of_match to jz4740_wdt_of_match
---
 drivers/watchdog/jz4740_wdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 18e41af..4c2cc09 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <asm/mach-jz4740/timer.h>
 
@@ -142,6 +143,14 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.set_timeout = jz4740_wdt_set_timeout,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_wdt_of_matches[] = {
+	{ .compatible = "ingenic,jz4740-watchdog", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches)
+#endif
+
 static int jz4740_wdt_probe(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata;
@@ -211,6 +220,7 @@ static struct platform_driver jz4740_wdt_driver = {
 	.remove = jz4740_wdt_remove,
 	.driver = {
 		.name = "jz4740-wdt",
+		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
 	},
 };
 
-- 
1.9.1

