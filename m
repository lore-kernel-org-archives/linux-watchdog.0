Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34469 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbcEYGiV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 02:38:21 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/7] watchdog: softdog: sort includes to avoid duplicates
Date: Wed, 25 May 2016 08:37:47 +0200
Message-Id: <1464158269-2447-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/softdog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 42faa3d424d5ca..ab0e02fc81a276 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -21,15 +21,15 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/types.h>
+#include <linux/reboot.h>
 #include <linux/timer.h>
+#include <linux/types.h>
 #include <linux/watchdog.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
 
 #define TIMER_MARGIN	60		/* Default is 60 seconds */
 static unsigned int soft_margin = TIMER_MARGIN;	/* in seconds */
-- 
2.8.1

