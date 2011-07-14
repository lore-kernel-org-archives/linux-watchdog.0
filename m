Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:34961 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964770Ab1GOGET (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2011 02:04:19 -0400
Received: from mail187.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 68DFDFFB04A
	for <linux-watchdog@vger.kernel.org>; Fri, 15 Jul 2011 02:08:52 +0200 (CEST)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 7/7] at91sam9/wdt: move register header to drivers
Date: Fri, 15 Jul 2011 01:52:05 +0200
Message-Id: <1310687525-22486-7-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c                    |    2 +-
 .../at91_wdt.h => drivers/watchdog/at91sam9_wdt.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-at91/include/mach/at91_wdt.h => drivers/watchdog/at91sam9_wdt.h (96%)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index eac2602..98ee810 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -31,7 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 
-#include <mach/at91_wdt.h>
+#include "at91sam9_wdt.h"
 
 #define DRV_NAME "AT91SAM9 Watchdog"
 
diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/drivers/watchdog/at91sam9_wdt.h
similarity index 96%
rename from arch/arm/mach-at91/include/mach/at91_wdt.h
rename to drivers/watchdog/at91sam9_wdt.h
index fecc2e9..757f9ca 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-at91/include/mach/at91_wdt.h
+ * drivers/watchdog/at91sam9_wdt.h
  *
  * Copyright (C) 2007 Andrew Victor
  * Copyright (C) 2007 Atmel Corporation.
-- 
1.7.5.4

