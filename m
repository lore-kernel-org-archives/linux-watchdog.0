Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:39076 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3I3EnJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Sep 2013 00:43:09 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so5016520pbc.26
        for <linux-watchdog@vger.kernel.org>; Sun, 29 Sep 2013 21:43:09 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 2/3] watchdog: orion: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:12:52 +0530
Message-Id: <1380516173-6974-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/orion_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ea5fcc..34adb54 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -207,7 +207,7 @@ static struct platform_driver orion_wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "orion_wdt",
-		.of_match_table = of_match_ptr(orion_wdt_of_match_table),
+		.of_match_table = orion_wdt_of_match_table,
 	},
 };
 
-- 
1.7.9.5

