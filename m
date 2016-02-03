Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53416 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933580AbcBCRWT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:22:19 -0500
From: fu.wei@linaro.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
	linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com,
	will.deacon@arm.com, Suravee.Suthikulpanit@amd.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout panic support
Date: Thu,  4 Feb 2016 01:18:43 +0800
Message-Id: <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch registers the WS0 interrupt routine to trigger panic,
when the watchdog reachs the first stage (the half timeout).
This function can help administrator to backup the system context
info by panic console output or kdump (if supported), once system
goes wrong (doesn't feed the watchdog in the half timeout).

User also can skip panic by setting panic_enabled (module parameter) as 0

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 Documentation/watchdog/watchdog-parameters.txt |  1 +
 drivers/watchdog/Kconfig                       | 10 +++++
 drivers/watchdog/sbsa_gwdt.c                   | 54 +++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 300eb4d..31641e2 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -286,6 +286,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 sbsa_gwdt:
 timeout: Watchdog timeout in seconds. (default 20s)
+panic_enabled: Enable panic at half timeout. (default=true)
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4ab1b05..42adfdf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -218,6 +218,16 @@ config ARM_SBSA_WATCHDOG
 	  To compile this driver as module, choose M here: The module
 	  will be called sbsa_gwdt.
 
+config ARM_SBSA_WATCHDOG_PANIC
+	bool "ARM SBSA Generic Watchdog triggers panic at the half timeout"
+	depends on ARM_SBSA_WATCHDOG
+	help
+	  ARM SBSA Generic Watchdog will trigger panic in the first signal
+	  (WS0) interrupt routine when the half timeout is reached.
+	  This function can help administrator to backup the system context
+	  info by panic console output or kdump (if supported).
+	  But user can skip panic by setting moduleparam panic_enabled as 0.
+
 config ASM9260_WATCHDOG
 	tristate "Alphascale ASM9260 watchdog"
 	depends on MACH_ASM9260
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 5a2dba3..d18cf37 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -16,18 +16,22 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * This SBSA Generic watchdog driver is a single stage timeout version.
+ * This SBSA Generic watchdog driver is a two stages version.
  * Since this watchdog timer has two stages, and each stage is determined
  * by WOR. So the timeout is (WOR * 2).
- * When first timeout is reached, WS0 is triggered, the interrupt
- * triggered by WS0 will be ignored, then the second watch period starts;
- * when second timeout is reached, then WS1 is triggered, system reset.
+ * When the first stage(the half timeout) is reached, WS0 interrupt is
+ * triggered, at this moment the second watch period starts;
+ * In the WS0 interrupt routine, panic will be triggered for saving the
+ * system context.
+ * If the system is getting into trouble and cannot be reset by panic or
+ * restart properly by the kdump kernel(if supported), then the second
+ * stage (the timeout) will be reached, system will be reset by WS1.
  *
  * More details about the hardware specification of this device:
  * ARM DEN0029B - Server Base System Architecture (SBSA)
  *
  * SBSA GWDT: |--------WOR-------WS0--------WOR-------WS1
- *            |----------------timeout----------------reset
+ *            |--half_timeout--(panic)--half_timeout--reset
  *
  */
 
@@ -84,6 +88,13 @@ MODULE_PARM_DESC(timeout,
 		 "Watchdog timeout in seconds. (>=0, default="
 		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
 
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+static bool panic_enabled = true;
+module_param(panic_enabled, bool, 0);
+MODULE_PARM_DESC(panic_enabled,
+		 "enable panic at half timeout. (default=true)");
+#endif
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout,
@@ -159,6 +170,16 @@ static int sbsa_gwdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
+{
+	if (panic_enabled)
+		panic("SBSA Watchdog half timeout");
+
+	return IRQ_HANDLED;
+}
+#endif
+
 static struct watchdog_info sbsa_gwdt_info = {
 	.identity	= "SBSA Generic Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
@@ -186,6 +207,9 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 status;
 	int ret;
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+	int irq;
+#endif
 
 	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
 	if (!gwdt)
@@ -202,6 +226,14 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(rf_base))
 		return PTR_ERR(rf_base);
 
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "unable to get ws0 interrupt.\n");
+		return irq;
+	}
+#endif
+
 	/*
 	 * Get the frequency of system counter from the cp15 interface of ARM
 	 * Generic timer. We don't need to check it, because if it returns "0",
@@ -228,6 +260,14 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 		dev_warn(dev, "System reset by WDT.\n");
 		wdd->bootstatus |= WDIOF_CARDRESET;
 	}
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+	ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
+			       pdev->name, gwdt);
+	if (ret) {
+		dev_err(dev, "unable to request IRQ %d\n", irq);
+		return ret;
+	}
+#endif
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
@@ -242,6 +282,10 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 
 	dev_info(dev, "Initialized with %ds timeout @ %u Hz%s\n", wdd->timeout,
 		 gwdt->clk, status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
+	dev_info(dev, "Half timeout panic %s.\n",
+		 panic_enabled ? "enabled" : "disabled");
+#endif
 
 	return 0;
 }
-- 
2.5.0

