Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42924 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966367AbcHBNQr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Aug 2016 09:16:47 -0400
From: Baole Ni <baolex.ni@intel.com>
To: wim@iguana.be, linux@roeck-us.net, tomi.valkeinen@ti.com,
	m.chehab@samsung.com, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com
Subject: [PATCH 1027/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:09:40 +0800
Message-Id: <20160802120940.18576-1-baolex.ni@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/watchdog/f71808e_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index d4ba262..92871c7 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -108,7 +108,7 @@ MODULE_PARM_DESC(f71862fg_pin,
 			" (default=" __MODULE_STRING(WATCHDOG_F71862FG_PIN)")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, 0444);
+module_param(nowayout, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
 
 static unsigned int start_withtimeout;
-- 
2.9.2

