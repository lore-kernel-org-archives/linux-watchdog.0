Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33331 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab2HGJpj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Aug 2012 05:45:39 -0400
Received: by pbbrr13 with SMTP id rr13so4053439pbb.19
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Aug 2012 02:45:38 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org, patches@linaro.org
Subject: [PATCH] watchdog: da9052: Remove duplicate inclusion of delay.h
Date: Tue,  7 Aug 2012 15:14:12 +0530
Message-Id: <1344332652-9455-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

delay.h header file was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/da9052_wdt.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 3f75129..f7abbae 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -21,7 +21,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
-#include <linux/delay.h>
 
 #include <linux/mfd/da9052/reg.h>
 #include <linux/mfd/da9052/da9052.h>
-- 
1.7.4.1

