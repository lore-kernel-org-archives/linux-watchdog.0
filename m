Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D4C43217
	for <linux-watchdog@archiver.kernel.org>; Fri, 22 Apr 2022 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiDVX06 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDVX0v (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 22 Apr 2022 19:26:51 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88B9E127E;
        Fri, 22 Apr 2022 16:05:40 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:52490.1277573903
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 9DF762800D7;
        Sat, 23 Apr 2022 07:05:37 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id c4fda4f59878486ab68eb988c9b703cf for wim@linux-watchdog.org;
        Sat, 23 Apr 2022 07:05:39 CST
X-Transaction-ID: c4fda4f59878486ab68eb988c9b703cf
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, groeck7@gmail.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH 3/3] watchdog: wdat_wdg: Add stop watchdog after unregister
Date:   Sat, 23 Apr 2022 07:05:18 +0800
Message-Id: <1650668718-13626-3-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650668718-13626-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650668718-13626-1-git-send-email-liuxp11@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Test shows that it still reboot after remove the module.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 609922ed4744..502da41ac0b2 100644
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

