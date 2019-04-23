Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C20C10F03
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD02175B
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfDWPv5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:51:57 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40468 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfDWPv4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 11:51:56 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3NFmwNX005137
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 08:50:17 -0700
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 08:50:13 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Avi Fishman <avifishman70@gmail.com>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        "Patrick Venture" <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH 3/5] watchdog: npcm: make it explicitly non-modular
Date:   Tue, 23 Apr 2019 11:48:33 -0400
Message-ID: <1556034515-28792-4-git-send-email-paul.gortmaker@windriver.com>
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

config NPCM7XX_WATCHDOG
       bool "Nuvoton NPCM750 watchdog"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: openbmc@lists.ozlabs.org
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/watchdog/npcm_wdt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 0d4213652ecc..44d305683ab6 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -2,11 +2,15 @@
 // Copyright (c) 2018 Nuvoton Technology corporation.
 // Copyright (c) 2018 IBM Corp.
 
+/*
+ * Watchdog driver for NPCM
+ * Author: Joel Stanley
+ */
+
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -237,7 +241,6 @@ static const struct of_device_id npcm_wdt_match[] = {
 	{.compatible = "nuvoton,npcm750-wdt"},
 	{},
 };
-MODULE_DEVICE_TABLE(of, npcm_wdt_match);
 #endif
 
 static struct platform_driver npcm_wdt_driver = {
@@ -247,8 +250,4 @@ static struct platform_driver npcm_wdt_driver = {
 		.of_match_table = of_match_ptr(npcm_wdt_match),
 	},
 };
-module_platform_driver(npcm_wdt_driver);
-
-MODULE_AUTHOR("Joel Stanley");
-MODULE_DESCRIPTION("Watchdog driver for NPCM");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(npcm_wdt_driver);
-- 
2.7.4

