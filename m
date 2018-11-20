Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34197 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeKTXxK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 18:53:10 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] watchdog: cpwd: add of_node_put()
Date: Tue, 20 Nov 2018 08:23:59 -0500
Message-Id: <20181120132359.19799-1-tiny.windzz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/cpwd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index aee0b25cf10d..d3a81642ada5 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, p);
 	cpwd_device = p;
+	of_node_put(options);
 	return 0;
 
 out_unregister:
-- 
2.17.0
