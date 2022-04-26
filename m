Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5471EC433FE
	for <linux-watchdog@archiver.kernel.org>; Tue, 26 Apr 2022 10:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349060AbiDZKbo (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349011AbiDZKbS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Apr 2022 06:31:18 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63C2010FF34;
        Tue, 26 Apr 2022 03:09:39 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:40704.1059882310
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 2D7722800C3;
        Tue, 26 Apr 2022 18:09:37 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id c733d31a89fe48b6af858fd6be3f0b1e for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 18:09:39 CST
X-Transaction-ID: c733d31a89fe48b6af858fd6be3f0b1e
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v7 3/3] watchdog: wdat_wdt: Stop watchdog when uninstalling module
Date:   Tue, 26 Apr 2022 18:09:22 +0800
Message-Id: <1650967762-3122-4-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650967762-3122-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650967762-3122-1-git-send-email-liuxp11@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Test shows that wachdog still reboots machine after the module
is removed. Use watchdog_stop_on_unregister to stop the watchdog
on removing.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 0ef2b918364a..6732d7fc4f94 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -464,6 +464,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
 	watchdog_stop_on_reboot(&wdat->wdd);
+	watchdog_stop_on_unregister(&wdat->wdd);
 	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
 
-- 
2.23.0

