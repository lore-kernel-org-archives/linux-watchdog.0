Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:38187 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3I3EnM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Sep 2013 00:43:12 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so5016558pbc.26
        for <linux-watchdog@vger.kernel.org>; Sun, 29 Sep 2013 21:43:11 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 3/3] watchdog: sunxi: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:12:53 +0530
Message-Id: <1380516173-6974-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/sunxi_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 1f94b42..cea0bc8 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -217,7 +217,7 @@ static struct platform_driver sunxi_wdt_driver = {
 	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= DRV_NAME,
-		.of_match_table	= of_match_ptr(sunxi_wdt_dt_ids)
+		.of_match_table	= sunxi_wdt_dt_ids,
 	},
 };
 
-- 
1.7.9.5

