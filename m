Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29861 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeHHVm6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:58 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 4/5] watchdog: hpwdt: Module paramerter alias.
Date: Wed,  8 Aug 2018 13:13:26 -0600
Message-Id: <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add module parameter "timeout" as an alias to "soft_margin."
This aligns hpwdt usage more closely with other WDT while
retaining backwards compatibility.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 69a88b1..eb947bc 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -367,6 +367,9 @@ static void hpwdt_exit(struct pci_dev *dev)
 module_param(soft_margin, int, 0);
 MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
 
+module_param_named(timeout, soft_margin, int, 0);
+MODULE_PARM_DESC(timeout, "Alias of soft_margin");
+
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-- 
1.8.3.1

