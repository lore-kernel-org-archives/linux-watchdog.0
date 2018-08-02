Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30773 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbeHBXRP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:15 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 4/4] watchdog: hpwdt: Update version number.
Date: Thu,  2 Aug 2018 15:15:41 -0600
Message-Id: <1533244541-42310-5-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Bump version number to reflect recent bug fixes.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index f098371..27091f3 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -26,7 +26,7 @@
 #include <linux/watchdog.h>
 #include <asm/nmi.h>
 
-#define HPWDT_VERSION			"2.0.0"
+#define HPWDT_VERSION			"2.0.1"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
-- 
1.8.3.1

