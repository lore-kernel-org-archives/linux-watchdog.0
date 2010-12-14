Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from fw.wantstofly.org ([80.101.37.227]:37392 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399Ab0LNP3d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Dec 2010 10:29:33 -0500
Date: Tue, 14 Dec 2010 16:29:31 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Andrew Victor <andrew@sanpeople.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] ks8695_wdt: include mach/hardware.h instead of mach/timex.h.
Message-ID: <20101214152931.GI15575@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

ks8695_wdt needs KS8695_CLOCK_RATE, which is defined in
mach/hardware.h, which is pulled in by the include of mach/timex.h,
but the latter is going away, so just include mach/hardware.h
directly.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 drivers/watchdog/ks8695_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 2852bb2..8114719 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -21,7 +21,7 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <mach/timex.h>
+#include <mach/hardware.h>
 #include <mach/regs-timer.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
-- 
1.7.1
