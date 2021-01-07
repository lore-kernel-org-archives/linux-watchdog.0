Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08FC433E6
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Jan 2021 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092C723433
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Jan 2021 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbhAGT6c (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 7 Jan 2021 14:58:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:35272 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGT63 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Jan 2021 14:58:29 -0500
IronPort-SDR: OkeivqDMtQbnB2kDJSlHcxfDRmfPQbM/AIfPhJMZbQ/dlb4i6hXZIikgH/kA7H525IyYcBjzKH
 GyoolpDHAFHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="173979227"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="173979227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:57:48 -0800
IronPort-SDR: meS7Rg6Hs3z5SPe5OJ/IuiC7PU0y9zG6WV4dczcf+KtWVJi0/Fg7p8z9AUmsBG/Siu8kaYKzDa
 vmPS94hjILSg==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="379837366"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:57:46 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog] watchdog: mei_wdt: request stop on unregister
Date:   Thu,  7 Jan 2021 21:57:30 +0200
Message-Id: <20210107195730.1660449-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Send the stop command to the firmware on watchdog unregister
to eleminate false event on suspend.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/mei_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 5391bf3e6b11..c5967d8b4256 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -382,6 +382,7 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 	watchdog_stop_on_reboot(&wdt->wdd);
+	watchdog_stop_on_unregister(&wdt->wdd);
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret)
-- 
2.26.2

