Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50937 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752626AbcAORfi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jan 2016 12:35:38 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH] watchdog: max63xx: make module's license marker match the header
Date: Fri, 15 Jan 2016 18:35:34 +0100
Message-Id: <1452879334-2499-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The header specifies GPL version 2 only, so make the MODULE_LICENSE
string use the respective string for that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/max63xx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index f36ca4be0720..ac5840d9689a 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -292,4 +292,4 @@ MODULE_PARM_DESC(nodelay,
 		 "Force selection of a timeout setting without initial delay "
 		 "(max6373/74 only, default=0)");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.6.4

