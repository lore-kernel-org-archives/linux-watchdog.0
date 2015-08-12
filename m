Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42904 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639AbbHLIQY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:24 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 3/7] watchdog: mpc8xxx: make use of of_device_get_match_data
Date: Wed, 12 Aug 2015 10:15:54 +0200
Message-Id: <1439367358-5338-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This function is new in v4.2-rc1 and makes a forward declaration of the
match table superfluous which can so be removed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index e0acda3282d9..fb1fe967cf57 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -139,7 +139,6 @@ static struct watchdog_device mpc8xxx_wdt_dev = {
 	.ops = &mpc8xxx_wdt_ops,
 };
 
-static const struct of_device_id mpc8xxx_wdt_match[];
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
@@ -150,10 +149,9 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	bool enabled;
 	unsigned int timeout_sec;
 
-	match = of_match_device(mpc8xxx_wdt_match, &ofdev->dev);
-	if (!match)
+	wdt_type = of_device_get_match_data(&ofdev->dev);
+	if (!wdt_type)
 		return -EINVAL;
-	wdt_type = match->data;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
-- 
2.4.6

