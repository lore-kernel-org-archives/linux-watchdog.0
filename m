Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40478 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966374AbcHBNQs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Aug 2016 09:16:48 -0400
From: Baole Ni <baolex.ni@intel.com>
To: wim@iguana.be, linux@roeck-us.net, tomi.valkeinen@ti.com,
	m.chehab@samsung.com, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com
Subject: [PATCH 1026/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:09:36 +0800
Message-Id: <20160802120936.18509-1-baolex.ni@intel.com>
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
 drivers/watchdog/diag288_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 861d3d3..75bfe07 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -60,13 +60,13 @@ MODULE_AUTHOR("Philipp Hachtmann <phacht@de.ibm.com>");
 
 MODULE_DESCRIPTION("System z diag288  Watchdog Timer");
 
-module_param_string(cmd, wdt_cmd, MAX_CMDLEN, 0644);
+module_param_string(cmd, wdt_cmd, MAX_CMDLEN, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cmd, "CP command that is run when the watchdog triggers (z/VM only)");
 
-module_param_named(conceal, conceal_on, bool, 0644);
+module_param_named(conceal, conceal_on, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(conceal, "Enable the CONCEAL CP option while the watchdog is active (z/VM only)");
 
-module_param_named(nowayout, nowayout_info, bool, 0444);
+module_param_named(nowayout, nowayout_info, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default = CONFIG_WATCHDOG_NOWAYOUT)");
 
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
2.9.2

