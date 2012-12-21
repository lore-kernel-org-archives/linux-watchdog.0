Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50913 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab2LUNQz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Dec 2012 08:16:55 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj3so2842158pad.0
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Dec 2012 05:16:55 -0800 (PST)
Message-ID: <1356095346.18328.0.camel@phoenix>
Subject: [PATCH] watchdog: da9055: Fix invalid free of devm_ allocated data
From: Axel Lin <axel.lin@ingics.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: David Dajun Chen <dchen@diasemi.com>,
	Ashish Jangam <ashish.jangam@kpitcummins.com>,
	linux-watchdog@vger.kernel.org
Date: Fri, 21 Dec 2012 21:09:06 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It is not required to free devm_ allocated data. Since kref_put
needs a valid release function, da9055_wdt_release_resources()
is not deleted.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/watchdog/da9055_wdt.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 709ea1a..31d5379 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -102,10 +102,6 @@ static int da9055_wdt_ping(struct watchdog_device *wdt_dev)
 
 static void da9055_wdt_release_resources(struct kref *r)
 {
-	struct da9055_wdt_data *driver_data =
-		container_of(r, struct da9055_wdt_data, kref);
-
-	kfree(driver_data);
 }
 
 static void da9055_wdt_ref(struct watchdog_device *wdt_dev)
-- 
1.7.9.5



