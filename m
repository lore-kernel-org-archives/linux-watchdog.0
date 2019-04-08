Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C552C282DD
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79220883
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hofmannsweb.com header.i=@hofmannsweb.com header.b="YAuKTCk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDHIFn (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:05:43 -0400
Received: from 178.27.4.93.rev.sfr.net ([93.4.27.178]:50328 "EHLO
        hofmannsweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHIFn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 04:05:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 8D5B0311822;
        Mon,  8 Apr 2019 10:05:40 +0200 (CEST)
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0-Ism3ccbgCD; Mon,  8 Apr 2019 10:05:37 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 3B6F031181D;
        Mon,  8 Apr 2019 10:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 hofmannsweb.com 3B6F031181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hofmannsweb.com;
        s=5A2CD3FC-E3ED-11E4-B8B6-D3B199B2F681; t=1554710737;
        bh=uTcKLY9szAYibfzuzi5pR7tkxGXtUXgwHEqGEgM8VG0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YAuKTCk//ccoFo5OH1wWmKhQL3/7OK+KAaqHrbdmzXEF45iNS6L7ak0T7Y3Psdn+i
         2FvmpXlC+AFyBvh+YcrfH2s0pVLphlhreUVdg4CR20Vg5lBF6heroGsFmNPBJ0X1xX
         PMIWCluEG95G5GjCD/XcvdfIor5PkRphYhmFCe0g=
X-Virus-Scanned: amavisd-new at hofmannsweb.com
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xf_MfPyICUK6; Mon,  8 Apr 2019 10:05:37 +0200 (CEST)
Received: from hofmannsweb.com (hofmannsweb.com [192.168.1.10])
        by hofmannsweb.com (Postfix) with ESMTP id 1F1CF311819;
        Mon,  8 Apr 2019 10:05:37 +0200 (CEST)
Date:   Mon, 8 Apr 2019 10:05:36 +0200 (CEST)
From:   Georg Hofmann <georg@hofmannsweb.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-watchdog@vger.kernel.org
Message-ID: <869353809.2803.1554710736950.JavaMail.zimbra@hofmannsweb.com>
Subject: [PATCH] Fix set_timeout for big timeout values
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [90.63.250.166]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF66 (Linux)/8.8.11_GA_3787)
Thread-Index: Ck1lmCh5THoROgujgYmB9XBRh+G8GQ==
Thread-Topic: Fix set_timeout for big timeout values
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This patch implements the documented behavior: if max_hw_heartbeat_ms is
implemented, the minimum of the set_timeout argument and
max_hw_heartbeat_ms should be used.
Previously only the first 7 bits were used and the input argument was
returned.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
---
 drivers/watchdog/imx2_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2b52514..3c13adc 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -178,9 +178,11 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
                                 unsigned int new_timeout)
 {
-        __imx2_wdt_set_timeout(wdog, new_timeout);
+        unsigned int actual;
 
-        wdog->timeout = new_timeout;
+        actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+        __imx2_wdt_set_timeout(wdog, actual);

+        wdog->timeout = new_timeout;
         return 0;
 }
 
-- 
2.7.4
