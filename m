Return-Path: <SRS0=HvdG=SI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84350C10F06
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AC1218C3
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 10:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hofmannsweb.com header.i=@hofmannsweb.com header.b="YtB4UU40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfDFKX2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:23:28 -0400
Received: from 178.27.4.93.rev.sfr.net ([93.4.27.178]:58880 "EHLO
        hofmannsweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFKX2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 6 Apr 2019 06:23:28 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2019 06:23:27 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id AE04C3107CF;
        Sat,  6 Apr 2019 12:17:44 +0200 (CEST)
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yoDAxLpzE8fc; Sat,  6 Apr 2019 12:17:44 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 3CEDE3107C8;
        Sat,  6 Apr 2019 12:17:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 hofmannsweb.com 3CEDE3107C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hofmannsweb.com;
        s=5A2CD3FC-E3ED-11E4-B8B6-D3B199B2F681; t=1554545864;
        bh=TwJD/n2NuxTr6vrYXaZNNEZfOm+dRbOC/GZBmZf+690=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YtB4UU40HJTzFCev7lDvhbygua2pt6hqeHU2DmGebjvaejJYd9tplxr88C1XoPcgk
         f1ILh2ElzXVeQFAedVOY512h9qk2OWGaSmmZD15TLOjPyhUMxhxCWHRRGiRe06gVGX
         JDV6jNKsDydC4oKvYZLkLrkjXb/M/S9PIPCU8Ge8=
X-Virus-Scanned: amavisd-new at hofmannsweb.com
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jf4MPbyKa60k; Sat,  6 Apr 2019 12:17:44 +0200 (CEST)
Received: from hofmannsweb.com (hofmannsweb.com [192.168.1.10])
        by hofmannsweb.com (Postfix) with ESMTP id 22F013107C3;
        Sat,  6 Apr 2019 12:17:44 +0200 (CEST)
Date:   Sat, 6 Apr 2019 12:17:43 +0200 (CEST)
From:   Georg Hofmann <georg@hofmannsweb.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-watchdog@vger.kernel.org
Message-ID: <1274287303.1911.1554545863744.JavaMail.zimbra@hofmannsweb.com>
Subject: [PATCH] Fix set_timeout for big timeout values
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.1.11]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF66 (Mac)/8.8.11_GA_3787)
Thread-Index: hpDURopEjPpd12ToB1/fo7lp6LEylw==
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
-	__imx2_wdt_set_timeout(wdog, new_timeout);
+	unsigned int actual;
 
-	wdog->timeout = new_timeout;
+	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+	__imx2_wdt_set_timeout(wdog, actual);
+	wdog->timeout = actual;
 	return 0;
 }
 
-- 
2.7.4
