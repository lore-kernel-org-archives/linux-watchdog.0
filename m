Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:24131 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3D2JgK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:36:10 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 6/7] watchdog: riowd: use devm_kzalloc()
Date: Mon, 29 Apr 2013 18:36:09 +0900
Message-id: <001001ce44bc$faf2ce40$f0d86ac0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_kzalloc() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/riowd.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 0040451..13363ad 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -183,7 +183,7 @@ static int riowd_probe(struct platform_device *op)
 		goto out;
 
 	err = -ENOMEM;
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
 	if (!p)
 		goto out;
 
@@ -192,7 +192,7 @@ static int riowd_probe(struct platform_device *op)
 	p->regs = of_ioremap(&op->resource[0], 0, 2, DRIVER_NAME);
 	if (!p->regs) {
 		pr_err("Cannot map registers\n");
-		goto out_free;
+		goto out;
 	}
 	/* Make miscdev useable right away */
 	riowd_device = p;
@@ -213,9 +213,6 @@ out_iounmap:
 	riowd_device = NULL;
 	of_iounmap(&op->resource[0], p->regs, 2);
 
-out_free:
-	kfree(p);
-
 out:
 	return err;
 }
@@ -226,7 +223,6 @@ static int riowd_remove(struct platform_device *op)
 
 	misc_deregister(&riowd_miscdev);
 	of_iounmap(&op->resource[0], p->regs, 2);
-	kfree(p);
 
 	return 0;
 }
-- 
1.7.2.5


