Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:52184 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab3LUIee (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Dec 2013 03:34:34 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so3581648pbc.10
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Dec 2013 00:34:33 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org
Subject: [PATCH 1/1] watchdog: sirf: Remove redundant of_match_ptr helper
Date: Sat, 21 Dec 2013 14:01:13 +0530
Message-Id: <1387614673-2740-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

'sirfsoc_wdt_of_match' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/sirfsoc_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index ced3edc95957..702d07870808 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -212,7 +212,7 @@ static struct platform_driver sirfsoc_wdt_driver = {
 		.name = "sirfsoc-wdt",
 		.owner = THIS_MODULE,
 		.pm = &sirfsoc_wdt_pm_ops,
-		.of_match_table	= of_match_ptr(sirfsoc_wdt_of_match),
+		.of_match_table	= sirfsoc_wdt_of_match,
 	},
 	.probe = sirfsoc_wdt_probe,
 	.remove = sirfsoc_wdt_remove,
-- 
1.7.9.5

