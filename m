Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639AbbHLIQR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:17 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 6/7] watchdog: mpc8xxx: use better error code when watchdog cannot be enabled
Date: Wed, 12 Aug 2015 10:15:57 +0200
Message-Id: <1439367358-5338-7-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

checkpatch warns about ENOSYS, telling "ENOSYS means 'invalid syscall
nr' and nothing else". So use ENODEV instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 0b69797d3417..5f2273aac37d 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -170,7 +170,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
 		pr_info("could not be enabled in software\n");
-		return -ENOSYS;
+		return -ENODEV;
 	}
 
 	spin_lock_init(&ddata->lock);
-- 
2.4.6

