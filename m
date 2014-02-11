Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9309 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaBKGxv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:53:51 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00HKJKHQAT00@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:53:50 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 6/8] watchdog: sp805_wdt: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:53:48 +0900
Message-id: <000701cf26f6$03fc9950$0bf5cbf0$%han@samsung.com>
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
 drivers/watchdog/sp805_wdt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 3f786ce..d7da73e 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -218,7 +218,6 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 
 	wdt = devm_kzalloc(&adev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt) {
-		dev_warn(&adev->dev, "Kzalloc failed\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
1.7.10.4


