Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72703C433F5
	for <linux-watchdog@archiver.kernel.org>; Tue, 21 Sep 2021 10:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521EC610A1
	for <linux-watchdog@archiver.kernel.org>; Tue, 21 Sep 2021 10:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhIUKa2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:30:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:25034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhIUKa2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202820032"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="202820032"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 03:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="474103519"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2021 03:28:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CE9A614A; Tue, 21 Sep 2021 13:29:00 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Malin Jonsson <malin.jonsson@ericsson.com>, john.jacques@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v2] watchdog: iTCO_wdt: No need to stop the timer in probe
Date:   Tue, 21 Sep 2021 13:29:00 +0300
Message-Id: <20210921102900.61586-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The watchdog core can handle pinging of the watchdog before userspace
opens the device. For this reason instead of stopping the timer, just
mark it as running and let the watchdog core take care of it.

Cc: Malin Jonsson <malin.jonsson@ericsson.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:

 - Only set the WDOG_HW_RUNNING flag.

 drivers/watchdog/iTCO_wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 643c6c2d0b72..a0e8ad3901a4 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -430,6 +430,16 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is * enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11)))
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -572,8 +582,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	iTCO_wdt_set_running(p);
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
-- 
2.33.0

