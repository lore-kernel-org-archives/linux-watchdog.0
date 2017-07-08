Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.148.104]:42414 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751659AbdGHAde (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 20:33:34 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 98CAE112E2A
        for <linux-watchdog@vger.kernel.org>; Fri,  7 Jul 2017 19:33:31 -0500 (CDT)
Date: Fri, 7 Jul 2017 19:33:30 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
Message-ID: <20170708003330.GA15374@embeddedgus>
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
 drivers/watchdog/coh901327_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 38dd60f0..4410337 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -218,7 +218,7 @@ static const struct watchdog_info coh901327_ident = {
 	.identity = DRV_NAME,
 };
 
-static struct watchdog_ops coh901327_ops = {
+static const struct watchdog_ops coh901327_ops = {
 	.owner = THIS_MODULE,
 	.start = coh901327_start,
 	.stop = coh901327_stop,
-- 
2.5.0

