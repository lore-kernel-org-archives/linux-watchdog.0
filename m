Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47458 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcGQWER (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 18:04:17 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/2] watchdog: sbsa: Drop status function
Date: Sun, 17 Jul 2016 15:04:12 -0700
Message-Id: <1468793052-26252-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1468793052-26252-1-git-send-email-linux@roeck-us.net>
References: <1468793052-26252-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog status function is supposed to return WDIOF_ flags,
not internal status flags. The available WDIOF_ flags are now
returned by the watchdog core, so the status function in this driver
is unnecessary.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Adjust description

 drivers/watchdog/sbsa_gwdt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index cc885f1c1850..ce0c38bd0f00 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -180,15 +180,6 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
 	return 0;
 }
 
-static unsigned int sbsa_gwdt_status(struct watchdog_device *wdd)
-{
-	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
-	u32 status = readl(gwdt->control_base + SBSA_GWDT_WCS);
-
-	/* is the watchdog timer running? */
-	return (status & SBSA_GWDT_WCS_EN) << WDOG_ACTIVE;
-}
-
 static int sbsa_gwdt_start(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
@@ -228,7 +219,6 @@ static struct watchdog_ops sbsa_gwdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= sbsa_gwdt_start,
 	.stop		= sbsa_gwdt_stop,
-	.status		= sbsa_gwdt_status,
 	.ping		= sbsa_gwdt_keepalive,
 	.set_timeout	= sbsa_gwdt_set_timeout,
 	.get_timeleft	= sbsa_gwdt_get_timeleft,
-- 
2.5.0

