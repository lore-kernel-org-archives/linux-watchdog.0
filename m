Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45086 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab2CZGgn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Mar 2012 02:36:43 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] watchdog: coh901327: fix build failure due to typo
Date: Mon, 26 Mar 2012 08:36:33 +0200
Message-Id: <1332743793-12822-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Linus: at least you could have build tested... ;)

 drivers/watchdog/coh901327_wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 3175767..6876430 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -250,7 +250,7 @@ static struct watchdog_device coh901327_wdt = {
 	.info = &coh901327_ident,
 	.ops = &coh901327_ops,
 	/*
-	 * Max timout is 327 since the 10ms
+	 * Max timeout is 327 since the 10ms
 	 * timeout register is max
 	 * 0x7FFF = 327670ms ~= 327s.
 	 */
@@ -355,7 +355,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 
 	if (margin < 1 || margin > 327)
 		margin = 60;
-	coh901327_wdt.timout = margin;
+	coh901327_wdt.timeout = margin;
 
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
-- 
1.7.2.5

