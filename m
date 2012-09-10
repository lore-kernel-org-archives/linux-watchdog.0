Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56780 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab2IJElQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Sep 2012 00:41:16 -0400
Received: by qcro28 with SMTP id o28so774800qcr.19
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Sep 2012 21:41:16 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Sep 2012 12:41:15 +0800
Message-ID: <CAPgLHd-8OYXbf0a_mWJQ0GzjkAe1bRZJhT-OTL+DFb_eF8nHPQ@mail.gmail.com>
Subject: [PATCH] watchdog: move the dereference below the NULL test
From: Wei Yongjun <weiyj.lk@gmail.com>
To: wim@iguana.be
Cc: yongjun_wei@trendmicro.com.cn, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

spatch with a semantic match is used to found this.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/watchdog/watchdog_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 6aa46a9..3796434 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -128,11 +128,12 @@ EXPORT_SYMBOL_GPL(watchdog_register_device);
 void watchdog_unregister_device(struct watchdog_device *wdd)
 {
 	int ret;
-	int devno = wdd->cdev.dev;
+	int devno;
 
 	if (wdd == NULL)
 		return;
 
+	devno = wdd->cdev.dev;
 	ret = watchdog_dev_unregister(wdd);
 	if (ret)
 		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);

