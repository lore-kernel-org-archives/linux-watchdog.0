Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:33104 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbbFZNbi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:38 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5/5] watchdog: dw_wdt: unqueue timer synchronously on unexpected close
Date: Fri, 26 Jun 2015 14:21:13 +0100
Message-Id: <1435324873-18318-6-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
References: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The driver normally calls the timer function `dw_wdt_ping()` every half
a second to pat the dog while it is not in use, and while waiting for
the next heartbeat from the user that opened the device.  If the
watchdog device's "release" file operation determines that the watchdog
device is being closed unexpectedly, it calls `del_timer()` to remove
the timer from the queue and thus stop patting the dog.  However, since
the timer function re-queues the timer, there is a race condition on SMP
systems which could leave the timer re-queueing itself when it
shouldn't.  To prevent that, call `del_timer_sync()` instead of
`del_timer()`.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/watchdog/dw_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index daab90b..bf617e3 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -281,7 +281,7 @@ static int dw_wdt_release(struct inode *inode, struct file *filp)
 	clear_bit(DW_WDT_IN_USE, &dw_wdt.state);
 
 	if (!dw_wdt.expect_close) {
-		del_timer(&dw_wdt.timer);
+		del_timer_sync(&dw_wdt.timer);
 
 		if (!nowayout)
 			pr_crit("unexpected close, system will reboot soon\n");
-- 
2.1.4

