Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37350 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdHGLY2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 Aug 2017 07:24:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so658308wmt.4
        for <linux-watchdog@vger.kernel.org>; Mon, 07 Aug 2017 04:24:27 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] watchdog: of_xilinx_wdt: Add suspend/resume support
Date: Mon,  7 Aug 2017 13:24:23 +0200
Message-Id: <1e1307808bd32591ea4f03ec3d70d0eadb38b91e.1502105061.git.michal.simek@xilinx.com>
In-Reply-To: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
References: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
In-Reply-To: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
References: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add suspend/resume support to driver.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/of_xilinx_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 41edeb93a327..1cf286945b7a 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -264,6 +264,43 @@ static int xwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * xwdt_suspend - Suspend the device.
+ *
+ * @dev: handle to the device structure.
+ * Return: 0 always.
+ */
+static int __maybe_unused xwdt_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xwdt_device *xdev = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&xdev->xilinx_wdt_wdd))
+		xilinx_wdt_stop(&xdev->xilinx_wdt_wdd);
+
+	return 0;
+}
+
+/**
+ * xwdt_resume - Resume the device.
+ *
+ * @dev: handle to the device structure.
+ * Return: 0 on success, errno otherwise.
+ */
+static int __maybe_unused xwdt_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xwdt_device *xdev = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (watchdog_active(&xdev->xilinx_wdt_wdd))
+		ret = xilinx_wdt_start(&xdev->xilinx_wdt_wdd);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
+
 /* Match table for of_platform binding */
 static const struct of_device_id xwdt_of_match[] = {
 	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
@@ -278,6 +315,7 @@ static int xwdt_remove(struct platform_device *pdev)
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
+		.pm = &xwdt_pm_ops,
 	},
 };
 
-- 
1.9.1

