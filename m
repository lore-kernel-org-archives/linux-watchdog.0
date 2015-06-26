Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:36912 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbbFZNbi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:38 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4/5] watchdog: dw_wdt: unqueue timer on device removal
Date: Fri, 26 Jun 2015 14:21:12 +0100
Message-Id: <1435324873-18318-5-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
References: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog device's timer may be queued when the platform driver
"remove" function is called.  Call `del_timer_sync` to remove it from
the queue.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/watchdog/dw_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 1cd877b..daab90b 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -387,6 +387,8 @@ out_unmark_probed:
 
 static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
+	del_timer_sync(&dw_wdt.timer);
+
 	if (test_and_clear_bit(DW_WDT_RESTART_HANDLER, &dw_wdt.state))
 		unregister_restart_handler(&dw_wdt.restart_handler);
 
-- 
2.1.4

