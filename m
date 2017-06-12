Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36281 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdFLGdH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Jun 2017 02:33:07 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: linux@roeck-us.net, wim@iguana.be, baoyou.xie@linaro.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: zx2967: constify zx2967_wdt_ops.
Date: Mon, 12 Jun 2017 12:02:39 +0530
Message-Id: <42bf28fa31b27477cc97cfca4b0a8bcdc83309f4.1497249031.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
    988	    288	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1084	    192	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/zx2967_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index e290d5a..17774de 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -154,7 +154,7 @@ static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
 	.identity         =	"zx2967 watchdog",
 };
 
-static struct watchdog_ops zx2967_wdt_ops = {
+static const struct watchdog_ops zx2967_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = zx2967_wdt_start,
 	.stop = zx2967_wdt_stop,
-- 
1.9.1

