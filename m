Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60911C10F03
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A53218CD
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWPv0 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:51:26 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40460 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfDWPv0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 11:51:26 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3NFmwNU005137
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 08:50:06 -0700
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 08:49:49 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/5] watchdog: watchdog_core: make it explicitly non-modular
Date:   Tue, 23 Apr 2019 11:48:32 -0400
Message-ID: <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config WATCHDOG_CORE
       bool "WatchDog Timer Driver Core"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We replace module.h with export.h since the file does export some
symbols.  We don't add init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/watchdog/watchdog_core.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index eb8fa25f8eb2..f9f88f59d181 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -28,7 +28,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>	/* For EXPORT_SYMBOL/module stuff/... */
+#include <linux/export.h>	/* For EXPORT_SYMBOL stuff */
 #include <linux/types.h>	/* For standard types */
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/kernel.h>	/* For printk/panic/... */
@@ -359,17 +359,4 @@ static int __init watchdog_init(void)
 	watchdog_deferred_registration();
 	return 0;
 }
-
-static void __exit watchdog_exit(void)
-{
-	watchdog_dev_exit();
-	ida_destroy(&watchdog_ida);
-}
-
 subsys_initcall_sync(watchdog_init);
-module_exit(watchdog_exit);
-
-MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
-MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
-MODULE_DESCRIPTION("WatchDog Timer Driver Core");
-MODULE_LICENSE("GPL");
-- 
2.7.4

