Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36410 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbcLORve (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 12:51:34 -0500
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] watchdog: octeon: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 18:49:29 +0100
Message-Id: <20161215174929.12493-1-clabbe.montjoie@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

watchdog/octeon-wdt-main.c does not use any miscdevice so this patch
remove this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/watchdog/octeon-wdt-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 529182d..b5cdceb 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -56,7 +56,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
 #include <linux/cpumask.h>
-- 
2.10.2

