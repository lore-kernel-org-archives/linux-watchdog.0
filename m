Return-Path: <SRS0=ndJk=EJ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121A3C2D0A3
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Nov 2020 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41B4222EC
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Nov 2020 06:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCGwl (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:52:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7406 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgKCGwl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Nov 2020 01:52:41 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQL7l2PZHz7223;
        Tue,  3 Nov 2020 14:52:35 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 14:52:28 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH -next v2 2/2] watchdog: Fix potential dereferencing of null pointer
Date:   Tue, 3 Nov 2020 06:52:17 +0000
Message-ID: <20201103065217.67876-2-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201103065217.67876-1-wangwensheng4@huawei.com>
References: <20201103065217.67876-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

A reboot notifier, which stops the WDT by calling the stop hook without
any check, would be registered when we set WDOG_STOP_ON_REBOOT flag.

Howerer we allow the WDT driver to omit the stop hook since commit
"d0684c8a93549" ("watchdog: Make stop function optional") and provide
a module parameter for user that controls the WDOG_STOP_ON_REBOOT flag
in commit 9232c80659e94 ("watchdog: Add stop_on_reboot parameter to
control reboot policy"). Together that commits make user potential to
insert a watchdog driver that don't provide a stop hook but with the
stop_on_reboot parameter set, then dereferencing of null pointer occurs
on system reboot.

Check the stop hook before registering the reboot notifier to fix the
issue.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/watchdog/watchdog_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index c73871f41142..5269761ba072 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -265,8 +265,12 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	}
 
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
-		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
+		if (!wdd->ops->stop) {
+			ret = -EINVAL;
+			goto dev_unregister;
+		}
 
+		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
 		ret = register_reboot_notifier(&wdd->reboot_nb);
 		if (ret) {
 			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
-- 
2.25.0

