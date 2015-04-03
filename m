Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f201.google.com ([209.85.213.201]:34704 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbDCRFZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Apr 2015 13:05:25 -0400
Received: by igdh15 with SMTP id h15so3930045igd.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Apr 2015 10:05:25 -0700 (PDT)
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V3 3/3] watchdog: imgpdc: Add reboot support
Date: Fri,  3 Apr 2015 10:05:22 -0700
Message-Id: <1428080722-29683-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Register a restart handler that will restart the system by writing
to the watchdog's SOFT_RESET register.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
No changes from v1/v2.
---
 drivers/watchdog/imgpdc_wdt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index ffeb1bf..28c10e2 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
@@ -57,6 +58,7 @@ struct pdc_wdt_dev {
 	struct clk *wdt_clk;
 	struct clk *sys_clk;
 	void __iomem *base;
+	struct notifier_block restart_handler;
 };
 
 static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
@@ -136,6 +138,18 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.set_timeout	= pdc_wdt_set_timeout,
 };
 
+static int pdc_wdt_restart(struct notifier_block *this, unsigned long mode,
+			   void *cmd)
+{
+	struct pdc_wdt_dev *wdt = container_of(this, struct pdc_wdt_dev,
+					       restart_handler);
+
+	/* Assert SOFT_RESET */
+	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
+
+	return NOTIFY_OK;
+}
+
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
 	int ret, val;
@@ -242,6 +256,13 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
+	pdc_wdt->restart_handler.notifier_call = pdc_wdt_restart;
+	pdc_wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&pdc_wdt->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to register restart handler: %d\n",
+			 ret);
+
 	return 0;
 
 disable_wdt_clk:
-- 
2.2.0.rc0.207.ga3a616c

