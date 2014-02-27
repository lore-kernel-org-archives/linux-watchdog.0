Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54859 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0Ftm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:49:42 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N00LZY45N2V90@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:48:59 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Kim Milo' <Milo.Kim@ti.com>
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
In-reply-to: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
Subject: [PATCH 6/6] watchdog: softdog: remove unnecessary initialization of
 static variable
Date: Thu, 27 Feb 2014 14:48:59 +0900
Message-id: <004a01cf337f$9c6b3ad0$d541b070$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove unnecessary initialization of static variable in order to
fix the following checkpatch issue.

  ERROR: do not initialise statics to 0 or NULL

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/softdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index c04a1aa..0dc5e323d 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static int soft_noboot = 0;
+static int soft_noboot;
 module_param(soft_noboot, int, 0);
 MODULE_PARM_DESC(soft_noboot,
 	"Softdog action, set to 1 to ignore reboots, 0 to reboot (default=0)");
-- 
1.7.10.4


