Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62412 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaBKGsT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:48:19 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00B0XK8HJMB0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:48:17 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Jean Delvare' <jdelvare@suse.de>,
	'Hans-Christian Egtvedt' <egtvedt@samfundet.no>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 1/8] watchdog: at32ap700x: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:48:16 +0900
Message-id: <000201cf26f5$3df1bf10$b9d53d30$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/at32ap700x_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
index afe7d17..25b5c67 100644
--- a/drivers/watchdog/at32ap700x_wdt.c
+++ b/drivers/watchdog/at32ap700x_wdt.c
@@ -323,10 +323,8 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(struct wdt_at32ap700x),
 			GFP_KERNEL);
-	if (!wdt) {
-		dev_dbg(&pdev->dev, "no memory for wdt structure\n");
+	if (!wdt)
 		return -ENOMEM;
-	}
 
 	wdt->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
 	if (!wdt->regs) {
-- 
1.7.10.4


