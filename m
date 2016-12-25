Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33650 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbcLYIAe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 25 Dec 2016 03:00:34 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: keescook@chromium.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] drivers: watchdog: pika_wdt: add __ro_after_init to ident
Date: Sun, 25 Dec 2016 13:30:24 +0530
Message-Id: <1482652824-8648-1-git-send-email-bhumirks@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The object ident of type watchdog_info structure is not
modified after getting initialized by pikawdt_init. Apart from getting
referenced in init it is also passed as an argument to the function
copy_to_user but this argument is of type const void *. Therefore add
__ro_after_init to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/watchdog/pika_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 0cdfee2..e35cf5e 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -54,7 +54,7 @@
 	struct timer_list timer;	/* The timer that pings the watchdog */
 } pikawdt_private;
 
-static struct watchdog_info ident = {
+static struct watchdog_info ident __ro_after_init = {
 	.identity	= DRV_NAME,
 	.options	= WDIOF_CARDRESET |
 			  WDIOF_SETTIMEOUT |
-- 
1.9.1

