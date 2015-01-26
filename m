Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45109 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbbAZX1Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Jan 2015 18:27:24 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so11953082iec.8
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Jan 2015 15:27:23 -0800 (PST)
From: Doug Anderson <dianders@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] watchdog: dw_wdt: Try to get a 30 second watchdog by default
Date: Mon, 26 Jan 2015 15:27:16 -0800
Message-Id: <1422314836-30516-2-git-send-email-dianders@chromium.org>
In-Reply-To: <1422314836-30516-1-git-send-email-dianders@chromium.org>
References: <1422314836-30516-1-git-send-email-dianders@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The dw_wdt_set_top() function takes in a value in seconds.  In
dw_wdt_open() we were calling it with a value that's supposed to
represent the maximum value programmed into the "top" register with a
comment saying that we were trying to set the watchdog to its maximum
value.  Instead we ended up setting the watchdog to ~15 seconds.

Let's fix this.  However, setting things to the "max" gives me an 86
second watchdog in the system I'm looking at.  86 seconds feels a
little too long.  We'll explicitly choose 30 seconds as a more
reasonable value.

NOTE: Ideally this driver should be transitioned to be a real watchdog
driver.  Then we could use "watchdog_init_timeout" and let the timeout
be specified in a number of ways (device tree, module parameter, etc).
This patch should be considered a bit of a stopgap solution.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v2: None

 drivers/watchdog/dw_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2c24882..3a5155d 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -51,6 +51,8 @@
 /* The maximum TOP (timeout period) value that can be set in the watchdog. */
 #define DW_WDT_MAX_TOP		15
 
+#define DW_WDT_DEFAULT_SECONDS	30
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
@@ -174,9 +176,9 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	if (!dw_wdt_is_enabled()) {
 		/*
 		 * The watchdog is not currently enabled. Set the timeout to
-		 * the maximum and then start it.
+		 * something reasonable and then start it.
 		 */
-		dw_wdt_set_top(DW_WDT_MAX_TOP);
+		dw_wdt_set_top(DW_WDT_DEFAULT_SECONDS);
 		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
 	}
-- 
2.2.0.rc0.207.ga3a616c

