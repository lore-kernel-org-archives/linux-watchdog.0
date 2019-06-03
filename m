Return-Path: <SRS0=2BDg=UC=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6FC28CC6
	for <linux-watchdog@archiver.kernel.org>; Mon,  3 Jun 2019 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC0928006
	for <linux-watchdog@archiver.kernel.org>; Mon,  3 Jun 2019 09:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfFCJaz (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:30:55 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:14095 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbfFCJaz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Jun 2019 05:30:55 -0400
X-IronPort-AV: E=Sophos;i="5.60,546,1549897200"; 
   d="scan'208";a="17679705"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Jun 2019 18:30:52 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D48094007529;
        Mon,  3 Jun 2019 18:30:52 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] watchdog: renesas_wdt: Add a few cycles delay
Date:   Mon,  3 Jun 2019 18:25:57 +0900
Message-Id: <1559553957-5764-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

According to the hardware manual of R-Car Gen2 and Gen3,
software should wait a few RLCK cycles as following:
 - Delay 2 cycles before setting watchdog counter.
 - Delay 3 cycles before disabling module clock.

So, this patch adds such delays.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 565dbc1..e632b56 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -7,6 +7,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -70,6 +71,16 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 	return 0;
 }
 
+static void rwdt_wait(struct rwdt_priv *priv, unsigned long cycles)
+{
+	unsigned long periods, delays;
+
+	periods = DIV_ROUND_UP(priv->clk_rate, cycles);
+	delays = DIV_ROUND_UP(1000000UL, periods);
+
+	usleep_range(delays, 2 * delays);
+}
+
 static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
@@ -80,6 +91,8 @@ static int rwdt_start(struct watchdog_device *wdev)
 	/* Stop the timer before we modify any register */
 	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
 	rwdt_write(priv, val, RWTCSRA);
+	/* Delay 2 cycles before setting watchdog counter */
+	rwdt_wait(priv, 2);
 
 	rwdt_init_timeout(wdev);
 	rwdt_write(priv, priv->cks, RWTCSRA);
@@ -98,6 +111,8 @@ static int rwdt_stop(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
+	/* Delay 3 cycles before disabling module clock */
+	rwdt_wait(priv, 3);
 	pm_runtime_put(wdev->parent);
 
 	return 0;
-- 
2.7.4

