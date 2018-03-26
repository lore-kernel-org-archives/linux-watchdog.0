Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751107AbeCZVRQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Mar 2018 17:17:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QLF0ZV055933
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Mar 2018 17:17:16 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gy868gyu3-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Mar 2018 17:17:15 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 17:17:15 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux@roeck-us.net,
        wim@linux-watchdog.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH] aspeed: watchdog: Add status function
Date: Mon, 26 Mar 2018 16:17:08 -0500
Message-Id: <1522099028-20347-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Populate the status watchdog operation to return the "timeout status"
register of the ASPEED watchdog.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index a5b8eb2..d6dd5c9 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -55,6 +55,7 @@ struct aspeed_wdt_config {
 #define   WDT_CTRL_WDT_INTR		BIT(2)
 #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
 #define   WDT_CTRL_ENABLE		BIT(0)
+#define WDT_TIMEOUT_STATUS	0x10
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -138,6 +139,13 @@ static int aspeed_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
+static unsigned int aspeed_wdt_status(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	return readl(wdt->base + WDT_TIMEOUT_STATUS);
+}
+
 static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
@@ -171,6 +179,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	.start		= aspeed_wdt_start,
 	.stop		= aspeed_wdt_stop,
 	.ping		= aspeed_wdt_ping,
+	.status		= aspeed_wdt_status,
 	.set_timeout	= aspeed_wdt_set_timeout,
 	.restart	= aspeed_wdt_restart,
 	.owner		= THIS_MODULE,
-- 
1.8.3.1

