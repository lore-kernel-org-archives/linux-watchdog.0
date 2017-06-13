Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54599 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753742AbdFMUj2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Jun 2017 16:39:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5DKdPuB029760
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:39:28 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b2mb3831d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:39:26 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Tue, 13 Jun 2017 14:38:42 -0600
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        andrew@aj.id.au
Subject: [PATCH 2/2] drivers/watchdog: ASPEED reference dev tree properties for config
Date: Tue, 13 Jun 2017 15:38:18 -0500
In-Reply-To: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
References: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170613203818.17399-3-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Reference the system device tree when configuring the watchdog.
Configure for external signal generation if optional attribute
'external-signal' is present in device tree.  Configure for
reset system after timeout if the optional attribute
'no-system-reset' is not present.  Disabling system reset may be
required in situations where one of the other watchdogs in the
systems is responsible for this.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..9deb4be 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
 	struct resource *res;
+	struct device_node *np;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	 * the SOC and not the full chip
 	 */
 	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
-		WDT_CTRL_1MHZ_CLK |
-		WDT_CTRL_RESET_SYSTEM;
+		WDT_CTRL_1MHZ_CLK;
+
+	np = pdev->dev.of_node;
+	if (np && !of_get_property(np, "no-system-reset", NULL))
+		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+
+	if (np && of_get_property(np, "external-signal", NULL))
+		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		aspeed_wdt_start(&wdt->wdd);
-- 
1.8.2.2

