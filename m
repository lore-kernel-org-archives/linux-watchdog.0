Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33189 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbcLFSU0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Dec 2016 13:20:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so20573718pgd.0
        for <linux-watchdog@vger.kernel.org>; Tue, 06 Dec 2016 10:20:25 -0800 (PST)
From: akkushwaha9896@gmail.com
To: linux@roeck-us.net, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
        Amit Kushwaha <akkushwaha9896@gmail.com>
Subject: [PATCH v2] watchdog: cpwd: remove memory allocate failure message
Date: Tue,  6 Dec 2016 10:19:48 -0800
Message-Id: <1481048388-4140-1-git-send-email-akkushwaha9896@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Amit Kushwaha <akkushwaha9896@gmail.com>

Replaced goto with a return statement and dropped the kfree()
calls because memory allocated with devm_kzalloc() is
automatically freed on driver detach

Signed-off-by: Amit Kushwaha <akkushwaha9896@gmail.com>
---
Changes in v2:
  - replaced goto and kzalloc() as suggested.

 drivers/watchdog/cpwd.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 71ee079..3d43775 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -538,12 +538,9 @@ static int cpwd_probe(struct platform_device *op)
 	if (cpwd_device)
 		return -EINVAL;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	err = -ENOMEM;
-	if (!p) {
-		pr_err("Unable to allocate struct cpwd\n");
-		goto out;
-	}
+	p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
 
 	p->irq = op->archdata.irqs[0];
 
@@ -553,12 +550,12 @@ static int cpwd_probe(struct platform_device *op)
 			     4 * WD_TIMER_REGSZ, DRIVER_NAME);
 	if (!p->regs) {
 		pr_err("Unable to map registers\n");
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	options = of_find_node_by_path("/options");
-	err = -ENODEV;
 	if (!options) {
+		err = -ENODEV;
 		pr_err("Unable to find /options node\n");
 		goto out_iounmap;
 	}
@@ -620,10 +617,7 @@ static int cpwd_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, p);
 	cpwd_device = p;
-	err = 0;
-
-out:
-	return err;
+	return 0;
 
 out_unregister:
 	for (i--; i >= 0; i--)
@@ -632,9 +626,7 @@ static int cpwd_probe(struct platform_device *op)
 out_iounmap:
 	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
 
-out_free:
-	kfree(p);
-	goto out;
+	return err;
 }
 
 static int cpwd_remove(struct platform_device *op)
@@ -659,7 +651,6 @@ static int cpwd_remove(struct platform_device *op)
 		free_irq(p->irq, p);
 
 	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
-	kfree(p);
 
 	cpwd_device = NULL;
 
-- 
1.7.1

