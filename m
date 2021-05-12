Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7BC433B4
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 May 2021 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AA8613CA
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 May 2021 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhELIsr (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 12 May 2021 04:48:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:57960 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhELIsn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 May 2021 04:48:43 -0400
IronPort-SDR: 5gtTP6tdJz1PgAgoqttp07jNY1ZZBNPWNytiRTSjlPiSSog1LOgeHH7MzM4R/UGJkvBWH/2+I6
 kDPUtmGUMZCg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179246757"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="179246757"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 01:47:36 -0700
IronPort-SDR: paG7A9zEsc/oHd1kJhRZIWuZ39Zsw7dLWzwe/zdcMEGNbq/CA3mMj26FKsWdLoPbTluZ0jRQZH
 Y1S4D0+LgsBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="435106423"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2021 01:47:32 -0700
From:   shruthi.sanil@intel.com
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH 02/10] watchdog: keembay: Upadate WDT pretimeout for every update in timeout
Date:   Wed, 12 May 2021 14:17:16 +0530
Message-Id: <20210512084724.14634-3-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512084724.14634-1-shruthi.sanil@intel.com>
References: <20210512084724.14634-1-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The pre-timeout value to be programmed to the register has to be
calculated and updated for every change in the timeout value.
Else the threshold time wouldn't be calculated to its
corresponding timeout.

Fixes: fa0f8d51e90d ("watchdog: Add watchdog driver for Intel Keembay Soc")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Kris Pan <kris.pan@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 drivers/watchdog/keembay_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index f2f5c9fae29c..b2afeb4a60e3 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -109,6 +109,7 @@ static int keembay_wdt_set_timeout(struct watchdog_device *wdog, u32 t)
 {
 	wdog->timeout = t;
 	keembay_wdt_set_timeout_reg(wdog);
+	keembay_wdt_set_pretimeout_reg(wdog);
 
 	return 0;
 }
-- 
2.17.1

