Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:54537 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752264AbbFZNbk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:40 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/5] watchdog: dw_wdt: prepare for more atomic bits
Date: Fri, 26 Jun 2015 14:21:09 +0100
Message-Id: <1435324873-18318-2-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
References: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Bit 0 of `dw_wdt.in_use` is tested and set atomically to indicate that
the watchdog has been opened exclusively.  The other bits are unused.
Some parts of the code also treat the whole of the `in_use` member as a
boolean value.

In preparation for making use of the unused bits, rename the `in_use`
member to `state`, define a new macro `DW_WDT_IN_USE` to identify bit 0
as the "in-use" bit, and replace conditional tests on the whole of
`in_use` with single-bit tests on the appropriate bit of `state`.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/watchdog/dw_wdt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6ea0634..249ef09 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -59,10 +59,13 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 
 #define WDT_TIMEOUT		(HZ / 2)
 
+/* dw_wdt.state bit numbers */
+#define DW_WDT_IN_USE		0
+
 static struct {
 	void __iomem		*regs;
 	struct clk		*clk;
-	unsigned long		in_use;
+	unsigned long		state;
 	unsigned long		next_heartbeat;
 	struct timer_list	timer;
 	int			expect_close;
@@ -160,7 +163,7 @@ static int dw_wdt_restart_handle(struct notifier_block *this,
 static void dw_wdt_ping(unsigned long data)
 {
 	if (time_before(jiffies, dw_wdt.next_heartbeat) ||
-	    (!nowayout && !dw_wdt.in_use)) {
+	    (!nowayout && !test_bit(DW_WDT_IN_USE, &dw_wdt.state))) {
 		dw_wdt_keepalive();
 		mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
 	} else
@@ -169,7 +172,7 @@ static void dw_wdt_ping(unsigned long data)
 
 static int dw_wdt_open(struct inode *inode, struct file *filp)
 {
-	if (test_and_set_bit(0, &dw_wdt.in_use))
+	if (test_and_set_bit(DW_WDT_IN_USE, &dw_wdt.state))
 		return -EBUSY;
 
 	/* Make sure we don't get unloaded. */
@@ -273,7 +276,7 @@ static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static int dw_wdt_release(struct inode *inode, struct file *filp)
 {
-	clear_bit(0, &dw_wdt.in_use);
+	clear_bit(DW_WDT_IN_USE, &dw_wdt.state);
 
 	if (!dw_wdt.expect_close) {
 		del_timer(&dw_wdt.timer);
-- 
2.1.4

