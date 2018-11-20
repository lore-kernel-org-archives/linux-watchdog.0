Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeKUBYT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 20:24:19 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] watchdog: cpwd: add of_node_put()
Date: Tue, 20 Nov 2018 09:54:45 -0500
Message-Id: <20181120145445.20730-1-tiny.windzz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-do that right after its last use to also cover
 error handling.
---
 drivers/watchdog/cpwd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index aee0b25cf10d..32156e199c51 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -570,6 +570,8 @@ static int cpwd_probe(struct platform_device *op)
 	if (str_prop)
 		p->timeout = simple_strtoul(str_prop, NULL, 10);
 
+	of_node_put(options);
+
 	/* CP1400s seem to have broken PLD implementations-- the
 	 * interrupt_mask register cannot be written, so no timer
 	 * interrupts can be masked within the PLD.
-- 
2.17.0
