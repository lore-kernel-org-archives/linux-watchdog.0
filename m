Return-Path: <SRS0=8G6l=SR=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE8C282DA
	for <linux-watchdog@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDB42087C
	for <linux-watchdog@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOKwK (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:52:10 -0400
Received: from sauhun.de ([88.99.104.3]:40532 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfDOKwK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 Apr 2019 06:52:10 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id B5E4D2C0114;
        Mon, 15 Apr 2019 12:52:06 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] watchdog: renesas_wdt: support handover from bootloader
Date:   Mon, 15 Apr 2019 12:52:01 +0200
Message-Id: <20190415105201.2078-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Support an already running watchdog by checking its enable bit and set
up the status accordingly before registering the device.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This patch was tested using a Renesas Salvator XS board (R-Car M3N). It works.
However, there is a small window where the watchdog clock is disabled, namely
after the MSSR clock driver initializes it until RuntimePM of the watchdog
driver takes over. If the system hangs in this window, bad luck. So, I'd think
it makes sense to have this clock either always-on or to keep the state which
came from the firmware. Geert, what do you think?

 drivers/watchdog/renesas_wdt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 565dbc1ec638..37d757288b22 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -179,6 +179,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
+	u8 csra;
 
 	if (rwdt_blacklisted(&pdev->dev))
 		return -ENODEV;
@@ -198,8 +199,8 @@ static int rwdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 	priv->clk_rate = clk_get_rate(clk);
-	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
-				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
+	csra = readb_relaxed(priv->base + RWTCSRA);
+	priv->wdev.bootstatus = csra & RWTCSRA_WOVF ? WDIOF_CARDRESET : 0;
 	pm_runtime_put(&pdev->dev);
 
 	if (!priv->clk_rate) {
@@ -237,6 +238,16 @@ static int rwdt_probe(struct platform_device *pdev)
 	/* This overrides the default timeout only if DT configuration was found */
 	watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
 
+	if (csra & RWTCSRA_TME) {
+		/* Ensure properly initialized dividers */
+		rwdt_start(&priv->wdev);
+		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
+		//FIXME: We are missing pm_runtime_put in some code paths to
+		// to balance PM calls. We first need to decide if we maybe
+		// should have the RWDT clock always-on or if using RPM for
+		// clock management is OK.
+	}
+
 	ret = watchdog_register_device(&priv->wdev);
 	if (ret < 0)
 		goto out_pm_disable;
-- 
2.11.0

