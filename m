Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:55207 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab1LZSHQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Dec 2011 13:07:16 -0500
From: Julia Lawall <julia@diku.dk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers/watchdog/lantiq_wdt.c: drop iounmap for devm_ allocated data
Date: Mon, 26 Dec 2011 18:38:00 +0100
Message-Id: <1324921081-13161-1-git-send-email-julia@diku.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Data allocated with devm_ioremap or devm_ioremap_nocache should not be
freed using iounmap, because doing so causes a dangling pointer, and a
subsequent double free.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression x;
@@
(
 x = devm_ioremap(...)
|
 x = devm_ioremap_nocache(...)
)

@@
expression r.x;
@@
* iounmap(x)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/watchdog/lantiq_wdt.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 102aed0..d3a63be 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -222,9 +222,6 @@ ltq_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ltq_wdt_miscdev);
 
-	if (ltq_wdt_membase)
-		iounmap(ltq_wdt_membase);
-
 	return 0;
 }
 

