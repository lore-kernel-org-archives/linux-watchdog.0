Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34216 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdFLGUy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Jun 2017 02:20:54 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: linux@roeck-us.net, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: bcm47xx_wdt: constify bcm47xx_wdt_hard_ops and bcm47xx_wdt_soft_ops
Date: Mon, 12 Jun 2017 11:50:26 +0530
Message-Id: <09f03198797fa7041adfab96811c059e50f44171.1497248301.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   1282	    388	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1474	    196	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/bcm47xx_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 35725e2..2365828 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -97,7 +97,7 @@ static int bcm47xx_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
-static struct watchdog_ops bcm47xx_wdt_hard_ops = {
+static const struct watchdog_ops bcm47xx_wdt_hard_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_hard_start,
 	.stop		= bcm47xx_wdt_hard_stop,
@@ -168,7 +168,7 @@ static int bcm47xx_wdt_soft_set_timeout(struct watchdog_device *wdd,
 				WDIOF_MAGICCLOSE,
 };
 
-static struct watchdog_ops bcm47xx_wdt_soft_ops = {
+static const struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_soft_start,
 	.stop		= bcm47xx_wdt_soft_stop,
-- 
1.9.1

