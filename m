Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbdLMTnw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 13 Dec 2017 14:43:52 -0500
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: linux@roeck-us.net, wim@iguana.be
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] watchdog: document watchdog_init_timeout() wdd parameter
Date: Wed, 13 Dec 2017 20:41:40 +0100
Message-Id: <20171213194140.1717-1-clabbe.montjoie@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

All parameters of watchdog_init_timeout() are documented with exception
of wdd, thus generating a build warning.

This patch document it and so remove the following build warning:
drivers/watchdog/watchdog_core.c:113: warning: No description found for parameter 'wdd'

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/watchdog/watchdog_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 8a8d952f8df9..eb8fa25f8eb2 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -97,6 +97,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 
 /**
  * watchdog_init_timeout() - initialize the timeout field
+ * @wdd: watchdog device
  * @timeout_parm: timeout module parameter
  * @dev: Device that stores the timeout-sec property
  *
-- 
2.13.6

