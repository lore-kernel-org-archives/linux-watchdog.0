Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30499 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1FVJo6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 05:44:58 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LN600K2VR2FRHE0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 22 Jun 2011 18:44:47 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.37])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LN600D60R2IPD@mmp2.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 22 Jun 2011 18:44:47 +0900 (KST)
Date: Wed, 22 Jun 2011 15:24:32 +0530
From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] watchdog: s3c2410: Add support for device tree based probe
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, devicetree-discuss@lists.ozlabs.org,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	ben-linux@fluff.org, patches@linaro.org
Message-id: <1308736472-22380-1-git-send-email-thomas.abraham@linaro.org>
Content-transfer-encoding: 7BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the of_match_table to enable s3c2410-wdt driver
to be probed when watchdog device node is found in the device tree.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   12 ++++++++++++
 drivers/watchdog/s3c2410_wdt.c                     |   10 ++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
new file mode 100644
index 0000000..f2617e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -0,0 +1,12 @@
+* Samsung's Watchdog Timer Controller
+
+The Samsung's Watchdog controller is used for resuming system operation
+after a preset amount of time during which the WDT reset event has not
+occured.
+
+Required properties:
+- compatible : should be "samsung,s3c2410-wdt"
+- reg : base physical address of the controller and length of memory mapped
+	region.
+- interrupts : interrupt number to the cpu.
+
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index f7f5aa0..30da88f 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -589,6 +589,15 @@ static int s3c2410wdt_resume(struct platform_device *dev)
 #define s3c2410wdt_resume  NULL
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c2410_wdt_match[] = {
+	{ .compatible = "samsung,s3c2410-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
+#else
+#define s3c2410_wdt_match NULL
+#endif
 
 static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
@@ -599,6 +608,7 @@ static struct platform_driver s3c2410wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c2410-wdt",
+		.of_match_table	= s3c2410_wdt_match,
 	},
 };
 
-- 
1.6.6.rc2

