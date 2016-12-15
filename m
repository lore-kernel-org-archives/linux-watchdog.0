Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36852 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbcLOSFy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 13:05:54 -0500
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] watchdog: mpc8xxx: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 19:03:44 +0100
Message-Id: <20161215180344.22237-1-clabbe.montjoie@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

watchdog/mpc8xxx_wdt.c does not use any miscdevice so this patch remove
this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/watchdog/mpc8xxx_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 5f2273a..366e5c7 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/miscdevice.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
-- 
2.10.2

