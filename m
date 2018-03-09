Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932528AbeCIV62 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:28 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29LwDF2037287
        for <linux-watchdog@vger.kernel.org>; Fri, 9 Mar 2018 16:58:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyv8dxru-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 16:58:28 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 16:58:27 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 1/2] watchdog: aspeed: Fix translation of reset mode to ctrl register
Date: Fri,  9 Mar 2018 15:58:19 -0600
In-Reply-To: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
Message-Id: <1520632700-25800-2-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

Assert RESET_SYSTEM bit for any reset and set MODE field from reset
type.

The watchdog control register has a RESET_SYSTEM bit that is really
closer to activate a reset, and RESET_SYSTEM_MODE field that chooses
how much to reset.

Before this patch, a node without these optional property would do a
SOC reset, but a node with properties requesting a cpu or SOC reset
would do nothing and a node requesting a system reset would do a
SOC reset.

Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index ca5b91e..d1987d6 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -232,11 +232,14 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC | WDT_CTRL_RESET_SYSTEM;
 	} else {
 		if (!strcmp(reset_type, "cpu"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "soc"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "system"))
-			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (strcmp(reset_type, "none"))
 			return -EINVAL;
 	}
-- 
1.8.3.1

