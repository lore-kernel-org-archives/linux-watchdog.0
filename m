Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1522C282CE
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146620870
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 11:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfDNLJk (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:09:40 -0400
Received: from sauhun.de ([88.99.104.3]:33170 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfDNLJj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 07:09:39 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id B81D32CF687;
        Sun, 14 Apr 2019 13:09:37 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Date:   Sun, 14 Apr 2019 13:09:33 +0200
Message-Id: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

And make sure the final obtained value gets properly scaled. Remove two
empty lines to group the initialization blocks while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested with a Renesas Lager board (R-Car H2, DA9063AD), checking the initial
timeout value via sysfs. I didn't test handover from bootloader because my
bootloader neither supports WDT or I2C out of the box.

 drivers/watchdog/da9063_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 06eb9070203c..3d65e92a4e3f 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -208,18 +208,20 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdd->max_timeout = DA9063_WDT_MAX_TIMEOUT;
 	wdd->min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
-	wdd->timeout = DA9063_WDG_TIMEOUT;
 	wdd->parent = dev;
-
 	wdd->status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
 	watchdog_set_restart_priority(wdd, 128);
-
 	watchdog_set_drvdata(wdd, da9063);
 
+	/* Set default timeout, maybe override it with DT value, scale it */
+	wdd->timeout = DA9063_WDG_TIMEOUT;
+	watchdog_init_timeout(wdd, 0, dev);
+	da9063_wdt_set_timeout(wdd, wdd->timeout);
+
 	/* Change the timeout to the default value if the watchdog is running */
 	if (da9063_wdt_is_running(da9063)) {
-		da9063_wdt_update_timeout(da9063, DA9063_WDG_TIMEOUT);
+		da9063_wdt_update_timeout(da9063, wdd->timeout);
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-- 
2.11.0

