Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43446 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbcDYTT6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Apr 2016 15:19:58 -0400
From: Colin King <colin.king@canonical.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jiri Kosina <trivial@kernel.org>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: trivial fix of spelling mistake on "allocate"
Date: Mon, 25 Apr 2016 20:19:51 +0100
Message-Id: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake, alloacate -> allocate

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/watchdog/jz4740_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 6a7d5c3..3f2ddc8 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -161,7 +161,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
 			       GFP_KERNEL);
 	if (!drvdata) {
-		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
+		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");
 		return -ENOMEM;
 	}
 
-- 
2.7.4

