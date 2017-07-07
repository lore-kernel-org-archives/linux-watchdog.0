Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40999 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753115AbdGGAtj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Jul 2017 20:49:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v670mxMh043900
        for <linux-watchdog@vger.kernel.org>; Thu, 6 Jul 2017 20:49:28 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bhr8t11xb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Jul 2017 20:49:28 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 18:49:27 -0600
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v4 2/2] drivers/watchdog: ASPEED reference dev tree properties for config
Date: Thu,  6 Jul 2017 19:49:00 -0500
In-Reply-To: <20170707004901.26780-1-cbostic@linux.vnet.ibm.com>
References: <20170707004901.26780-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170707004901.26780-3-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Reference the system device tree when configuring the watchdog
engines. If property 'aspeed,reset_type' is present then set
reset behavior based on the specified value.  This can be one of
three different mutually exclusive values
  * cpu - Reset CPU only on watchdog timeout
  * soc - Reset System on Chip
  * system - Full system reset

No reset can also be specified by indicating:
  * none - No reset, assumes another watchdog is responsible for
           this.

Add optional property 'aspeed,external-signal'. If present then
configure to generate external signal on watchdog timeout.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v4 - Change the three reset type parameters to a new property
     'aspeed,reset_type' and check assignment for one of four
     different values, cpu, soc, system, none
v3 - Invert the logic for system reset dev tree property to
     preserve backwards compatibility. If not specified the
     default is to configure for system reset
   - Add check for 'aspeed,no-soc-reset' property and only if
     not present is SOC reset to be configured.  This preserves
     backwards compatibility.
v2 - Change of_get_property() to of_property_read_bool()
   - Remove redundant check for NULL struct device_node pointer
   - Optional property names now start with prefix 'aspeed,'
---
 drivers/watchdog/aspeed_wdt.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..3ca79565 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -36,6 +36,7 @@ struct aspeed_wdt {
 #define WDT_CTRL		0x0C
 #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
 #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
+#define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
 #define   WDT_CTRL_1MHZ_CLK		BIT(4)
 #define   WDT_CTRL_WDT_EXT		BIT(3)
 #define   WDT_CTRL_WDT_INTR		BIT(2)
@@ -140,6 +141,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
 	struct resource *res;
+	struct device_node *np;
+	const char *reset_type;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -164,14 +167,28 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
 	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
 
+	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
+
 	/*
 	 * Control reset on a per-device basis to ensure the
-	 * host is not affected by a BMC reboot, so only reset
-	 * the SOC and not the full chip
+	 * host is not affected by a BMC reboot
 	 */
-	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
-		WDT_CTRL_1MHZ_CLK |
-		WDT_CTRL_RESET_SYSTEM;
+	np = pdev->dev.of_node;
+	ret = of_property_read_string(np, "aspeed,reset-type", &reset_type);
+	if (ret) {
+		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+	} else {
+		if (!strcmp(reset_type, "cpu"))
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
+		else if (!strcmp(reset_type, "soc"))
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+		else if (!strcmp(reset_type, "system"))
+			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+	}
+	if (of_property_read_bool(np, "aspeed,external-signal"))
+		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		aspeed_wdt_start(&wdt->wdd);
-- 
1.8.2.2

