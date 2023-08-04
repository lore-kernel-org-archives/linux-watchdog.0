Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EBC001DB
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Aug 2023 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjHDKHZ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHDKGw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2023 06:06:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E40849E5
        for <linux-watchdog@vger.kernel.org>; Fri,  4 Aug 2023 03:06:47 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RHLv86GpDz1KCDH;
        Fri,  4 Aug 2023 18:05:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 18:06:45 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <jth@kernel.org>, <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <lizetao1@huawei.com>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH -next] watchdog: menz069_wdt: Remove redundant initialization owner in men_z069_driver
Date:   Fri, 4 Aug 2023 18:06:17 +0800
Message-ID: <20230804100617.100251-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The module_mcb_driver() will set "THIS_MODULE" to driver.owner when
register a mcb_driver driver, so it is redundant initialization to set
driver.owner in men_z069_driver statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/watchdog/menz69_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 3c98030b9fcd..c7de30270043 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -153,7 +153,6 @@ MODULE_DEVICE_TABLE(mcb, men_z069_ids);
 static struct mcb_driver men_z069_driver = {
 	.driver = {
 		.name = "z069-wdt",
-		.owner = THIS_MODULE,
 	},
 	.probe = men_z069_probe,
 	.remove = men_z069_remove,
-- 
2.34.1

