Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36946 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258Ab1JCRut (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Oct 2011 13:50:49 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH v2 3/5] watchdog: s3c2410: re-add nowayout feature
Date: Mon,  3 Oct 2011 18:50:00 +0100
Message-Id: <1317664202-4085-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1317664202-4085-1-git-send-email-w.sang@pengutronix.de>
References: <1317664202-4085-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 'nowayout' feature got lost during the conversion towards using the
watchdog framework. Reenable it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

At this time, only build-tested. Will check on real hardware on wednesday.
Because of being trivial, I send it out already; so the whole series can get
the review.

 drivers/watchdog/s3c2410_wdt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 5de7e4f..773eee6 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -378,6 +378,9 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 							"cannot start\n");
 	}
 
+	if (nowayout)
+		s3c2410_wdd.status |= WATCHDOG_NOWAYOUT_INIT_STATUS;
+
 	ret = watchdog_register_device(&s3c2410_wdd);
 	if (ret) {
 		dev_err(dev, "cannot register watchdog (%d)\n", ret);
-- 
1.7.2.5

