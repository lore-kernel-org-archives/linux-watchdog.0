Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34470 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbcEYGiV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 02:38:21 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6/7] watchdog: softdog: drop superfluous set_timeout callback
Date: Wed, 25 May 2016 08:37:48 +0200
Message-Id: <1464158269-2447-7-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we leave set_timeout empty, the core will do exactly what is
implemented here anyway.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/softdog.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index ab0e02fc81a276..5e3a30b99d4415 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -87,12 +87,6 @@ static int softdog_stop(struct watchdog_device *w)
 	return 0;
 }
 
-static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
-{
-	w->timeout = t;
-	return 0;
-}
-
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
@@ -102,7 +96,6 @@ static struct watchdog_ops softdog_ops = {
 	.owner = THIS_MODULE,
 	.start = softdog_ping,
 	.stop = softdog_stop,
-	.set_timeout = softdog_set_timeout,
 };
 
 static struct watchdog_device softdog_dev = {
-- 
2.8.1

