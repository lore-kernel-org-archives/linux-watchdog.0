Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:33778 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0LCQwO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 11:52:14 -0500
From: Timur Tabi <timur@freescale.com>
To: <linux-watchdog@vger.kernel.org>, <kumar.gala@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC Book-E watchdog driver
Date: Fri, 3 Dec 2010 10:51:43 -0600
Message-ID: <1291395103-12394-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Normally, the watchdog is disabled when dev/watchdog is closed, but if
CONFIG_WATCHDOG_NOWAYOUT is defined, then it means that the watchdog should
remain enabled.  So we should disable it only if CONFIG_WATCHDOG_NOWAYOUT is
not defined.

Also ensure that /dev/watchdog is only opened by one process at a time.  That
way, a second process can't accidentally disable the watchdog while the first
process has it open.  There shouldn't be any need for more than one process to
open /dev/watchdog anyway.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, please pick up this patch for 2.6.37.

 drivers/watchdog/booke_wdt.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index d11ffb0..636e013 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -193,8 +193,15 @@ static long booke_wdt_ioctl(struct file *file,
 	return 0;
 }
 
+/* wdt_is_active stores wether or not the /dev/watchdog device is opened */
+static unsigned long wdt_is_active;
+
 static int booke_wdt_open(struct inode *inode, struct file *file)
 {
+	/* /dev/watchdog can only be opened once */
+	if (test_and_set_bit(0, &wdt_is_active))
+		return -EBUSY;
+
 	spin_lock(&booke_wdt_lock);
 	if (booke_wdt_enabled == 0) {
 		booke_wdt_enabled = 1;
@@ -210,8 +217,17 @@ static int booke_wdt_open(struct inode *inode, struct file *file)
 
 static int booke_wdt_release(struct inode *inode, struct file *file)
 {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	/* Normally, the watchdog is disabled when /dev/watchdog is closed, but
+	 * if CONFIG_WATCHDOG_NOWAYOUT is defined, then it means that the
+	 * watchdog should remain enabled.  So we disable it only if
+	 * CONFIG_WATCHDOG_NOWAYOUT is not defined.
+	 */
 	on_each_cpu(__booke_wdt_disable, NULL, 0);
 	booke_wdt_enabled = 0;
+#endif
+
+	clear_bit(0, &wdt_is_active);
 
 	return 0;
 }
-- 
1.7.2.3


