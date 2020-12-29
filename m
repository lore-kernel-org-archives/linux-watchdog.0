Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA235C433E0
	for <linux-watchdog@archiver.kernel.org>; Tue, 29 Dec 2020 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02DC207B8
	for <linux-watchdog@archiver.kernel.org>; Tue, 29 Dec 2020 11:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL2LUV (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 29 Dec 2020 06:20:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10090 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2LUU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Dec 2020 06:20:20 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4sNq6qMwzMBqn;
        Tue, 29 Dec 2020 19:18:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 19:19:35 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: use boolean value when setting nowayout
Date:   Tue, 29 Dec 2020 19:19:36 +0800
Message-ID: <1609240776-39726-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Fixes coccicheck warnings:
drivers/watchdog/alim7101_wdt.c:390:2-10: WARNING: Assignment of 0/1 to
bool variable

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/watchdog/alim7101_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 4ff7f5a..951449e 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -387,7 +387,7 @@ static int __init alim7101_wdt_init(void)
 			pr_info("Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
 			goto err_out;
 		}
-		nowayout = 1;
+		nowayout = true;
 	} else if ((tmp & 0x1e) != 0x12 && (tmp & 0x1e) != 0x00) {
 		pr_info("ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
 		goto err_out;
-- 
2.7.4

