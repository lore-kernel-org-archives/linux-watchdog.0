Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18307 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3CRHf7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 03:35:59 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJU00LLOIEK2670@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:35:58 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJU00EL0IFYJA00@mmp1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:35:58 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
In-reply-to: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
Subject: [PATCH 3/7] watchdog: mv64x60_wdt: use devm_ioremap()
Date: Mon, 18 Mar 2013 16:35:58 +0900
Message-id: <01af01ce23ab$3b70efc0$b252cf40$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/mv64x60_wdt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index c7fb878..e4cf980 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -276,7 +276,7 @@ static int mv64x60_wdt_probe(struct platform_device *dev)
 	if (!r)
 		return -ENODEV;
 
-	mv64x60_wdt_regs = ioremap(r->start, resource_size(r));
+	mv64x60_wdt_regs = devm_ioremap(&dev->dev, r->start, resource_size(r));
 	if (mv64x60_wdt_regs == NULL)
 		return -ENOMEM;
 
@@ -293,8 +293,6 @@ static int mv64x60_wdt_remove(struct platform_device *dev)
 
 	mv64x60_wdt_handler_disable();
 
-	iounmap(mv64x60_wdt_regs);
-
 	return 0;
 }
 
-- 
1.7.2.5


