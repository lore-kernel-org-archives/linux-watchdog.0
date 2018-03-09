Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932528AbeCIV6c (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29LsSIm113662
        for <linux-watchdog@vger.kernel.org>; Fri, 9 Mar 2018 16:58:32 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyfd6v41-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 16:58:31 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 16:58:30 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 2/2] watchdog: aspeed: Allow configuring for alternate boot
Date: Fri,  9 Mar 2018 15:58:20 -0600
In-Reply-To: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
Message-Id: <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

Allow the device tree to specify a watchdog to fallover to
the alternate boot source.

The aspeeed watchdog can set a latch directing flash chip select 0 to
chip select 1, allowing boot from an alternate media if the watchdog
is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
while on the ast2500 the chip selects are swapped.

Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index d1987d6..f41d246 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -46,6 +46,7 @@ struct aspeed_wdt_config {
 #define WDT_RELOAD_VALUE	0x04
 #define WDT_RESTART		0x08
 #define WDT_CTRL		0x0C
+#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
 #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
 #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
 #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
@@ -245,6 +246,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+	if (of_property_read_bool(np, "aspeed,alt-boot"))
+		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		/*
-- 
1.8.3.1

