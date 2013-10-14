Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45074 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120Ab3JNQc5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Oct 2013 12:32:57 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so7576437pde.38
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Oct 2013 09:32:56 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: ts72xx_wdt: Propagate return value from timeout_to_regval
Date: Mon, 14 Oct 2013 09:32:48 -0700
Message-Id: <1381768368-25062-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

timeout_to_regval() returns a valid error code. Might as well use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ts72xx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 42913f1..a4f3ce5 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -192,7 +192,7 @@ static int ts72xx_wdt_open(struct inode *inode, struct file *file)
 		dev_err(&wdt->pdev->dev,
 			"failed to convert timeout (%d) to register value\n",
 			timeout);
-		return -EINVAL;
+		return regval;
 	}
 
 	if (mutex_lock_interruptible(&wdt->lock))
-- 
1.7.9.7

