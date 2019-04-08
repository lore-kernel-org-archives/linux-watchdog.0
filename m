Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C468C10F13
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031C82083E
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hofmannsweb.com header.i=@hofmannsweb.com header.b="B6+eTkGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDHTZ4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:25:56 -0400
Received: from 178.27.4.93.rev.sfr.net ([93.4.27.178]:51920 "EHLO
        hofmannsweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDHTZ4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 15:25:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 089A83112B1;
        Mon,  8 Apr 2019 21:25:55 +0200 (CEST)
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XRp3XSHlF__h; Mon,  8 Apr 2019 21:25:54 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 911803112A2;
        Mon,  8 Apr 2019 21:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 hofmannsweb.com 911803112A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hofmannsweb.com;
        s=5A2CD3FC-E3ED-11E4-B8B6-D3B199B2F681; t=1554751554;
        bh=aEbIywQt4LRU63kQXpHF00iE9teFNkv/1csdQVLQn80=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=B6+eTkGDm/oBbKzllXC02QN4jmz6JUmA1ioQUoytpqh3GJYT3A6lavdEQ0SUGwGHV
         14JOEXHMgLeQuid+MgubmAEip+WLVz4znF029tjqoDoroPJZVurSzkYpRSww+oxgV2
         7xbeH6li1aN9Ng3qnpznm6wRbjy2zgiijnfbhoA4=
X-Virus-Scanned: amavisd-new at hofmannsweb.com
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id noSqfCc445oU; Mon,  8 Apr 2019 21:25:54 +0200 (CEST)
Received: from hofmannsweb.com (hofmannsweb.com [192.168.1.10])
        by hofmannsweb.com (Postfix) with ESMTP id 75F6431129E;
        Mon,  8 Apr 2019 21:25:54 +0200 (CEST)
Date:   Mon, 8 Apr 2019 21:25:54 +0200 (CEST)
From:   Georg Hofmann <georg@hofmannsweb.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-watchdog@vger.kernel.org
Message-ID: <66814249.3190.1554751554223.JavaMail.zimbra@hofmannsweb.com>
Subject: [PATCH v2] watchdog: imx2_wdt: Fix set_timeout for big timeout
 values
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.1.11]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF66 (Mac)/8.8.11_GA_3787)
Thread-Index: zJ0jbco9/T6wlUKLc3Eb07hJ+N+oHQ==
Thread-Topic: watchdog: imx2_wdt: Fix set_timeout for big timeout values
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The documentated behavior is: if max_hw_heartbeat_ms is implemented, the
minimum of the set_timeout argument and max_hw_heartbeat_ms should be used.
This patch implements this behavior.
Previously only the first 7bits were used and the input argument was
returned.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
---
 drivers/watchdog/imx2_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2b52514..7e7bdcb 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -178,8 +178,10 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
-	__imx2_wdt_set_timeout(wdog, new_timeout);
+	unsigned int actual;
 
+	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+	__imx2_wdt_set_timeout(wdog, actual);
 	wdog->timeout = new_timeout;
 	return 0;
 }
-- 
2.7.4
