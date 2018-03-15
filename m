Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932999AbeCOQCV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Mar 2018 12:02:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2FG060Y065495
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Mar 2018 12:02:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gqse799gv-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Mar 2018 12:02:16 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 15 Mar 2018 10:02:12 -0600
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2] watchdog: aspeed: Allow configuring for alternate boot
Date: Thu, 15 Mar 2018 11:02:06 -0500
Message-Id: <1521129726-15490-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

Allow the device tree to specify a watchdog to fallover to
the alternate boot source.

The aspeeed watchdog can set a latch directing flash chip select 0 to
chip select 1, allowing boot from an alternate media if the watchdog
is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
while on the ast2500 the chip selects are swapped.

Also clear the secondary boot bit during the machine restart operation.
Otherwise, the system will switch to the alternate boot after every
reboot, which is not desired.

Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
Changes since v1:
 * Disable secondary boot before the restart operation.

 drivers/watchdog/aspeed_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index d1987d6..a5b8eb2 100644
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
@@ -158,6 +159,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 {
 	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
 
+	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
 	mdelay(1000);
@@ -245,6 +247,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+	if (of_property_read_bool(np, "aspeed,alt-boot"))
+		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		/*
-- 
1.8.3.1

