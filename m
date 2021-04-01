Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D96C433ED
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Apr 2021 02:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B8A61041
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Apr 2021 02:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhDACZW (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:25:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14659 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhDACY6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Mar 2021 22:24:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9n546Cbwzmc8K;
        Thu,  1 Apr 2021 10:22:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 10:24:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <khilman@baylibre.com>
CC:     <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] watchdog: meson_wdt: Use device_get_match_data() helper
Date:   Thu, 1 Apr 2021 10:25:21 +0800
Message-ID: <1617243921-56774-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Use the device_get_match_data() helper instead of open coding.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/watchdog/meson_wdt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 459f3ae..539feaa 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -162,7 +162,6 @@ static int meson_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_wdt_dev *meson_wdt;
-	const struct of_device_id *of_id;
 	int err;
 
 	meson_wdt = devm_kzalloc(dev, sizeof(*meson_wdt), GFP_KERNEL);
@@ -173,12 +172,7 @@ static int meson_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(meson_wdt->wdt_base))
 		return PTR_ERR(meson_wdt->wdt_base);
 
-	of_id = of_match_device(meson_wdt_dt_ids, dev);
-	if (!of_id) {
-		dev_err(dev, "Unable to initialize WDT data\n");
-		return -ENODEV;
-	}
-	meson_wdt->data = of_id->data;
+	meson_wdt->data = device_get_match_data(dev);
 
 	meson_wdt->wdt_dev.parent = dev;
 	meson_wdt->wdt_dev.info = &meson_wdt_info;
-- 
2.7.4

