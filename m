Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA6C10F03
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3F2175B
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfDWPun (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:50:43 -0400
Received: from mail.windriver.com ([147.11.1.11]:55923 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDWPun (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 11:50:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3NFoIV3029014
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 08:50:18 -0700 (PDT)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 08:50:17 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4/5] watchdog: intel_scu: make it explicitly non-modular
Date:   Tue, 23 Apr 2019 11:48:34 -0400
Message-ID: <1556034515-28792-5-git-send-email-paul.gortmaker@windriver.com>
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

config INTEL_SCU_WATCHDOG
       bool "Intel SCU Watchdog for Mobile Platforms"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We leave the moduleparam.h include since the file does declare some
module parameters, and leaving them as such is currently the easiest
way to remain compatible with existing boot arg use cases.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/watchdog/intel_scu_watchdog.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index 0caab6241eb7..32bc5611f0cc 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -25,7 +25,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/compiler.h>
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -545,21 +544,4 @@ static int __init intel_scu_watchdog_init(void)
 	iounmap(watchdog_device.timer_load_count_addr);
 	return ret;
 }
-
-static void __exit intel_scu_watchdog_exit(void)
-{
-
-	misc_deregister(&watchdog_device.miscdev);
-	unregister_reboot_notifier(&watchdog_device.intel_scu_notifier);
-	/* disable the timer */
-	iowrite32(0x00000002, watchdog_device.timer_control_addr);
-	iounmap(watchdog_device.timer_load_count_addr);
-}
-
 late_initcall(intel_scu_watchdog_init);
-module_exit(intel_scu_watchdog_exit);
-
-MODULE_AUTHOR("Intel Corporation");
-MODULE_DESCRIPTION("Intel SCU Watchdog Device Driver");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(WDT_VER);
-- 
2.7.4

