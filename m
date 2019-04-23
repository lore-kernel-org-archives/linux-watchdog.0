Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91880C10F03
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E012175B
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfDWPuy (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:50:54 -0400
Received: from mail1.windriver.com ([147.11.146.13]:37683 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDWPux (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 11:50:53 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3NFoLe3017793
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 08:50:21 -0700 (PDT)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 08:50:20 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 5/5] watchdog: coh901327: make it explicitly non-modular
Date:   Tue, 23 Apr 2019 11:48:35 -0400
Message-ID: <1556034515-28792-6-git-send-email-paul.gortmaker@windriver.com>
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

config COH901327_WATCHDOG
       bool "ST-Ericsson COH 901 327 watchdog"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_ALIAS is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We replace module.h with moduleparam.h since the file does actually
declare some module parameters (i.e. boot args for non-modules).

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/watchdog/coh901327_wdt.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index f29d1edc5bad..5914cc767c87 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -6,7 +6,7 @@
  * Watchdog driver for the ST-Ericsson AB COH 901 327 IP core
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -243,16 +243,6 @@ static struct watchdog_device coh901327_wdt = {
 	.timeout = U300_WDOG_DEFAULT_TIMEOUT,
 };
 
-static int __exit coh901327_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&coh901327_wdt);
-	coh901327_disable();
-	free_irq(irq, pdev);
-	clk_disable_unprepare(clk);
-	clk_put(clk);
-	return 0;
-}
-
 static int __init coh901327_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -408,19 +398,13 @@ static struct platform_driver coh901327_driver = {
 	.driver = {
 		.name	= "coh901327_wdog",
 		.of_match_table = coh901327_dt_match,
+		.suppress_bind_attrs = true,
 	},
-	.remove		= __exit_p(coh901327_remove),
 	.suspend	= coh901327_suspend,
 	.resume		= coh901327_resume,
 };
+builtin_platform_driver_probe(coh901327_driver, coh901327_probe);
 
-module_platform_driver_probe(coh901327_driver, coh901327_probe);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
-MODULE_DESCRIPTION("COH 901 327 Watchdog");
-
+/* not really modular, but ... */
 module_param(margin, uint, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
-
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:coh901327-watchdog");
-- 
2.7.4

