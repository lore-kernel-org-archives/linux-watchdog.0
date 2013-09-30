Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35092 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3I3EnF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Sep 2013 00:43:05 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so5351213pab.12
        for <linux-watchdog@vger.kernel.org>; Sun, 29 Sep 2013 21:43:05 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 1/3] watchdog: at91rm9200: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:12:51 +0530
Message-Id: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/at91rm9200_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 1c75260..aa5cb56 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -269,7 +269,7 @@ static struct platform_driver at91wdt_driver = {
 	.driver		= {
 		.name	= "at91_wdt",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
+		.of_match_table = at91_wdt_dt_ids,
 	},
 };
 
-- 
1.7.9.5

