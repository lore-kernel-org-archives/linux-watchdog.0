Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52576 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948Ab2DTOmz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Apr 2012 10:42:55 -0400
Received: by dake40 with SMTP id e40so13110212dak.11
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Apr 2012 07:42:55 -0700 (PDT)
From: Viresh Kumar <viresh.linux@gmail.com>
To: wim@iguana.be
Cc: spear-devel@list.st.com, viresh.linux@gmail.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] watchdog: mpcore: Add DT bindings for ARM mpcore watchdog
Date: Fri, 20 Apr 2012 20:12:32 +0530
Message-Id: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds Device tree bindings for ARM Mpcore watchdog. It also updates
documentation for bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 .../bindings/watchdog/arm-mpcore-wdt.txt           |   19 +++++++++++++++++++
 drivers/watchdog/mpcore_wdt.c                      |   10 ++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm-mpcore-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/arm-mpcore-wdt.txt b/Documentation/devicetree/bindings/watchdog/arm-mpcore-wdt.txt
new file mode 100644
index 0000000..27a71aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/arm-mpcore-wdt.txt
@@ -0,0 +1,19 @@
+* ARM MPCORE WATCHDOG
+
+Required properties:
+- compatible : "arm,mpcore-wdt"
+- reg : Address range of the wdt registers
+
+Optional Properties:
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupt: Should contain the wdt interrupt number
+
+Example:
+
+	wdt@ec800620 {
+		compatible = "arm,mpcore-wdt";
+		reg = <0xec800620 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <1 14 0x301>;
+	};
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c00455..f82625f 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -402,6 +403,14 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");
 
+#ifdef CONFIG_OF
+static const struct of_device_id mpcore_wdt_id_table[] = {
+	{ .compatible = "arm,mpcore-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpcore_wdt_id_table);
+#endif
+
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= __devexit_p(mpcore_wdt_remove),
@@ -410,6 +419,7 @@ static struct platform_driver mpcore_wdt_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
 		.pm	= &mpcore_wdt_dev_pm_ops,
+		.of_match_table = of_match_ptr(mpcore_wdt_id_table),
 	},
 };
 
-- 
1.7.9

