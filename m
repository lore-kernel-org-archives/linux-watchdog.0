Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:33806 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111Ab3GIXJM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jul 2013 19:09:12 -0400
From: <dinguyen@altera.com>
To: <linux-watchdog@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>
CC: <dinh.linux@gmail.com>, Dinh Nguyen <dinguyen@altera.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH] watchdog: dw: Enable OF support for DW watchdog timer.
Date: Tue, 9 Jul 2013 18:09:37 -0500
Message-ID: <1373411377-5170-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Dinh Nguyen <dinguyen@altera.com>

Add device tree support to the DW watchdog timer.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Pavel Machek <pavel@denx.de>
---
 .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
 drivers/watchdog/dw_wdt.c                          |    7 +++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
new file mode 100644
index 0000000..29e150b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -0,0 +1,16 @@
+Synopsys Designware Watchdog Timer
+
+Required Properties:
+
+- Compatiblity	: "snps,dw-wdt"
+- reg		: Base address of the watchdog timer register.
+
+Example:
+
+	watchdog0: wd@ffd02000 {
+		compatible = "snps,dw-wdt";
+		reg = <0xffd02000 0x1000>;
+		interrupts = <0 171 4>;
+		clocks = <&per_base_clk>;
+		status = "okay";
+	};
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2037669..f7eec38 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -343,12 +343,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dw_wdt_of_match[] = {
+	{ .compatible = "snps,dw-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
+
 static struct platform_driver dw_wdt_driver = {
 	.probe		= dw_wdt_drv_probe,
 	.remove		= dw_wdt_drv_remove,
 	.driver		= {
 		.name	= "dw_wdt",
 		.owner	= THIS_MODULE,
+		.of_match_table = dw_wdt_of_match,
 #ifdef CONFIG_PM
 		.pm	= &dw_wdt_pm_ops,
 #endif /* CONFIG_PM */
-- 
1.7.9.5


