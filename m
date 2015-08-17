Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:15791 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753811AbbHQQTG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Aug 2015 12:19:06 -0400
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: at91rm9200: Correct check for syscon_node_to_regmap() errors
Date: Mon, 17 Aug 2015 09:19:03 -0700
Message-ID: <1439828343-6679-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

syscon_node_to_regmap() returns a regmap or an ERR_PTR().

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/watchdog/at91rm9200_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 9ba1153465ae..e12a797cb820 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -244,7 +244,7 @@ static int at91wdt_probe(struct platform_device *pdev)
 	}
 
 	regmap_st = syscon_node_to_regmap(parent->of_node);
-	if (!regmap_st)
+	if (IS_ERR(regmap_st))
 		return -ENODEV;
 
 	res = misc_register(&at91wdt_miscdev);
-- 
1.8.2.2

