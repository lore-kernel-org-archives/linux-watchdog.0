Return-Path: <SRS0=y0dX=SM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2DC10F11
	for <linux-watchdog@archiver.kernel.org>; Wed, 10 Apr 2019 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14A2064B
	for <linux-watchdog@archiver.kernel.org>; Wed, 10 Apr 2019 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfDJTNA (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:13:00 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:33343 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfDJTNA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 10 Apr 2019 15:13:00 -0400
X-Greylist: delayed 1432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2019 15:12:59 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 8A89D9A840
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Apr 2019 13:49:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id EIHShVF734FKpEIHShzgaT; Wed, 10 Apr 2019 13:49:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.139.70] (port=42402 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hEIHR-000nKl-TJ; Wed, 10 Apr 2019 13:49:06 -0500
Date:   Wed, 10 Apr 2019 13:49:05 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] watchdog: machzwd: Mark expected switch fall-through
Message-ID: <20190410184905.GA24283@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.139.70
X-Source-L: No
X-Exim-ID: 1hEIHR-000nKl-TJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.139.70]:42402
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/watchdog/machzwd.c: In function ‘zf_set_timer’:
./arch/x86/include/asm/io.h:355:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
 #define outw outw
drivers/watchdog/machzwd.c:80:53: note: in expansion of macro ‘outw’
 #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
                                                     ^~~~
drivers/watchdog/machzwd.c:179:3: note: in expansion of macro ‘zf_writew’
   zf_writew(COUNTER_1, new);
   ^~~~~~~~~
drivers/watchdog/machzwd.c:180:2: note: here
  case WD2:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/watchdog/machzwd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 88d823d87a4b..108928dbc754 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -177,6 +177,7 @@ static inline void zf_set_timer(unsigned short new, unsigned char n)
 	switch (n) {
 	case WD1:
 		zf_writew(COUNTER_1, new);
+		/* fall through */
 	case WD2:
 		zf_writeb(COUNTER_2, new > 0xff ? 0xff : new);
 	default:
-- 
2.21.0

