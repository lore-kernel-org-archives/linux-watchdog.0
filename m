Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:53533 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGTCqy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 22:46:54 -0400
From: <yanjiang.jin@windriver.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <jinyanjiang@gmail.com>, <yanjiang.jin@windriver.com>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: imx2_wdt: use new_timeout value to override the old
Date: Thu, 20 Jul 2017 10:45:33 +0800
Message-ID: <20170720024533.70081-1-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

Without this patch we couldn't change the timeout value of imx2_wdt.

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 drivers/watchdog/imx2_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f..6cfeee6 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -178,6 +178,9 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
+
+	wdog->timeout = new_timeout;
+
 	return 0;
 }
 
-- 
1.9.1

