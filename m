Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:63071 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbcGOIOx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 04:14:53 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	<linux-watchdog@vger.kernel.org>,
	<linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] watchdog: bcm2835_wdt: remove redundant ->set_timeout callback
Date: Fri, 15 Jul 2016 10:15:22 +0200
Message-ID: <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

bcm2835_wdt_set_timeout does exactly what the watchdog framework does
in the absence of a ->set_timeout callback (see watchdog_set_timeout
in watchdog_dev.c), so remove it.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/bcm2835_wdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 733e402..4dddd82 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -82,12 +82,6 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 	return 0;
 }
 
-static int bcm2835_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
-{
-	wdog->timeout = t;
-	return 0;
-}
-
 static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 {
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
@@ -100,7 +94,6 @@ static const struct watchdog_ops bcm2835_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	bcm2835_wdt_start,
 	.stop =		bcm2835_wdt_stop,
-	.set_timeout =	bcm2835_wdt_set_timeout,
 	.get_timeleft =	bcm2835_wdt_get_timeleft,
 };
 
-- 
2.5.0

