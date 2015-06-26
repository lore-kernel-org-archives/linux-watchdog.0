Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:60819 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134AbbFZNbj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:39 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 3/5] watchdog: dw_wdt: only unregister restart handler if registered
Date: Fri, 26 Jun 2015 14:21:11 +0100
Message-Id: <1435324873-18318-4-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
References: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the platform driver "probe" function fails to register a restart
handler, it issues a warning and continues regardless.  The
corresponding "remove" function unregisters the restart handler
regardless.

Use bit 2 of `dw_wdt.state` to indicate whether the restart handler was
registered successfully in the "probe" function, and only unregister it
in the "remove" function if so.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/watchdog/dw_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cece633..1cd877b 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 /* dw_wdt.state bit numbers */
 #define DW_WDT_IN_USE		0
 #define DW_WDT_PROBED		1
+#define DW_WDT_RESTART_HANDLER	2
 
 static struct {
 	void __iomem		*regs;
@@ -366,6 +367,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	ret = register_restart_handler(&dw_wdt.restart_handler);
 	if (ret)
 		pr_warn("cannot register restart handler\n");
+	else
+		set_bit(DW_WDT_RESTART_HANDLER, &dw_wdt.state);
 
 	dw_wdt_set_next_heartbeat();
 	setup_timer(&dw_wdt.timer, dw_wdt_ping, 0);
@@ -384,7 +387,8 @@ out_unmark_probed:
 
 static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
-	unregister_restart_handler(&dw_wdt.restart_handler);
+	if (test_and_clear_bit(DW_WDT_RESTART_HANDLER, &dw_wdt.state))
+		unregister_restart_handler(&dw_wdt.restart_handler);
 
 	misc_deregister(&dw_wdt_miscdev);
 
-- 
2.1.4

