Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23090 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbcAHLDa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jan 2016 06:03:30 -0500
Date: Fri, 8 Jan 2016 14:02:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] watchdog: pnx833x_wdt: fix typo in MODULE_PARM_DESC
Message-ID: <20160108110239.GI32195@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The module_param() is "pnx833x_wdt_timeout" and MODULE_PARM_DESC()
should match.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/watchdog/pnx833x_wdt.c b/drivers/watchdog/pnx833x_wdt.c
index 882fdcb..69da25a 100644
--- a/drivers/watchdog/pnx833x_wdt.c
+++ b/drivers/watchdog/pnx833x_wdt.c
@@ -52,8 +52,9 @@ static int pnx833x_wdt_alive;
 /* Set default timeout in MHZ.*/
 static int pnx833x_wdt_timeout = PNX_WATCHDOG_TIMEOUT;
 module_param(pnx833x_wdt_timeout, int, 0);
-MODULE_PARM_DESC(timeout, "Watchdog timeout in Mhz. (68Mhz clock), default="
-			__MODULE_STRING(PNX_TIMEOUT_VALUE) "(30 seconds).");
+MODULE_PARM_DESC(pnx833x_wdt_timeout,
+		 "Watchdog timeout in Mhz. (68Mhz clock), default="
+		 __MODULE_STRING(PNX_TIMEOUT_VALUE) "(30 seconds).");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
