Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.54.2]:28213 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752616AbdGHAll (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 20:41:41 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 5D877400CCD4C
        for <linux-watchdog@vger.kernel.org>; Fri,  7 Jul 2017 19:18:41 -0500 (CDT)
Date: Fri, 7 Jul 2017 19:18:40 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: ts72xx_wdt: constify watchdog_ops structure
Message-ID: <20170708001840.GA8758@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Check for watchdog_ops structures that are only stored in the ops field of
a watchdog_device structure. This field is declared const, so watchdog_ops
structures that have this property can be declared as const also.

This issue was detected using Coccinelle and the following semantic patch:

@r
disable optional_qualifier@
identifier i;
position p;
@@
static struct watchdog_ops i@p = { ... };

@ok@
identifier r.i;
struct watchdog_device e;
position p;
@@
e.ops = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct watchdog_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct watchdog_ops i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/watchdog/ts72xx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 17c25da..811e43c 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -112,7 +112,7 @@ static const struct watchdog_info ts72xx_wdt_ident = {
 	.identity		= "TS-72XX WDT",
 };
 
-static struct watchdog_ops ts72xx_wdt_ops = {
+static const struct watchdog_ops ts72xx_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= ts72xx_wdt_start,
 	.stop		= ts72xx_wdt_stop,
-- 
2.5.0

