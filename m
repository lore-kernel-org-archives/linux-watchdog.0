Return-Path: <SRS0=kg2l=ZJ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0956C432C0
	for <linux-watchdog@archiver.kernel.org>; Sun, 17 Nov 2019 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B766A20748
	for <linux-watchdog@archiver.kernel.org>; Sun, 17 Nov 2019 20:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfKQUKp (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 17 Nov 2019 15:10:45 -0500
Received: from ch3vs02.rockwellcollins.com ([205.175.226.29]:64655 "EHLO
        ch3vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfKQUKp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 17 Nov 2019 15:10:45 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 15:10:45 EST
IronPort-SDR: OsZdomubnYOgMLqLhaBzvdi1pZjMkNkNB3CZvqP/yTzbkaPxQF9tTJbHb/gPL2BdIU67gwJzWu
 82vEC2ZylhOTAap/XWoEn3wyN6P99SXF2z3BYezsG6L+3EWzyCR/Unwsq6oxj1Tn8Bz8ygo0RA
 3VBWXQt0TB/bnIkhbP/ncUsQVLdZ3brk6/tVjGTaqmosLxgTJIYQVFIaQhNLFFEuTPffoFtXtn
 Um0ANk7OREYUPxYfJPlgo+936kvjtRB6rtQRB+8Umnh5xpX61UHvs4sUMjFbdd7i/Oqhu/nZdd
 87Q=
Received: from ofwch3n02.rockwellcollins.com (HELO dtulimr02.rockwellcollins.com) ([205.175.226.14])
  by ch3vs02.rockwellcollins.com with ESMTP; 17 Nov 2019 14:03:38 -0600
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by dtulimr02.rockwellcollins.com (Postfix) with ESMTP id 691042006E;
        Sun, 17 Nov 2019 14:03:37 -0600 (CST)
From:   Brandon Maier <brandon.maier@rockwellcollins.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux@roeck-us.net, wim@linux-watchdog.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH] watchdog: omap: Fix early_enable to start watchdogd
Date:   Sun, 17 Nov 2019 14:03:25 -0600
Message-Id: <20191117200325.142419-1-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

When the 'early_enable' module_param is enabled, Linux's watchdogd
thread does not start, causing the watchdog to eventually fire.

For the watchdogd to be started, the WDOG_HW_RUNNING flag must be set
before watchdog_register_device().

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/watchdog/omap_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 9b91882fe3c4..ecc8592c00a5 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -268,8 +268,13 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	if (!early_enable)
+	if (!early_enable) {
 		omap_wdt_disable(wdev);
+		clear_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
+	} else {
+		omap_wdt_start(&wdev->wdog);
+		set_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
+	}
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
@@ -281,9 +286,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	if (early_enable)
-		omap_wdt_start(&wdev->wdog);
-
 	pm_runtime_put(wdev->dev);
 
 	return 0;
-- 
2.23.0

