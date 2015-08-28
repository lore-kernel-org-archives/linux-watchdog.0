Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:24988 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbbH1V6v (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Aug 2015 17:58:51 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
Date: Fri, 28 Aug 2015 14:58:06 -0700
Message-ID: <1440799086-14683-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently there is no way to easily differentiate multiple
watchdog devices. The watchdogs are named by the order they
are probed.
1st probed watchdog: /dev/watchdog0
2nd probed watchdog: /dev/watchdog1
...

This change uses the alias of the watchdog device node for
the name of the watchdog.
aliases {
	watchdog0 = "/...../...."
	watchdog3 = "/..../....."
	watchdog2 = "/..../....."
	...
}

This will translate to...
/dev/watchdog0
/dev/watchdog3
/dev/watchdog2

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/watchdog/watchdog_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..52b1f0b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -41,6 +41,7 @@
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/of.h>
 
 #include "watchdog_core.h"
 
@@ -522,7 +523,13 @@ static struct miscdevice watchdog_miscdev = {
 
 int watchdog_dev_register(struct watchdog_device *watchdog)
 {
-	int err, devno;
+	int err, devno, ret;
+
+	if (watchdog->parent) {
+		ret = of_alias_get_id(watchdog->parent->of_node, "watchdog");
+		if (ret >= 0)
+			watchdog->id = ret;
+	}
 
 	if (watchdog->id == 0) {
 		old_wdd = watchdog;
-- 
2.1.0

