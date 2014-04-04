Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from yotta.elopez.com.ar ([31.220.24.173]:41521 "EHLO
	yotta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbaDDR1O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 13:27:14 -0400
From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, wim@iguana.be,
	carlo.caione@gmail.com
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Subject: [PATCH] watchdog: sunxi: Fix compilation with C=2
Date: Fri,  4 Apr 2014 14:24:25 -0300
Message-Id: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When compiling sunxi_defconfig while using C=2, the following error
causes the compilation to fail:

    drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not a valid number

Fix it by using hex notation instead of the non-standard binary one

Signed-off-by: Emilio López <emilio@elopez.com.ar>
---
 drivers/watchdog/sunxi_wdt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index cd00a78..693b9d2 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -57,17 +57,17 @@ struct sunxi_wdt_dev {
  */
 
 static const int wdt_timeout_map[] = {
-	[1] = 0b0001,  /* 1s  */
-	[2] = 0b0010,  /* 2s  */
-	[3] = 0b0011,  /* 3s  */
-	[4] = 0b0100,  /* 4s  */
-	[5] = 0b0101,  /* 5s  */
-	[6] = 0b0110,  /* 6s  */
-	[8] = 0b0111,  /* 8s  */
-	[10] = 0b1000, /* 10s */
-	[12] = 0b1001, /* 12s */
-	[14] = 0b1010, /* 14s */
-	[16] = 0b1011, /* 16s */
+	[1] = 0x1,  /* 1s  */
+	[2] = 0x2,  /* 2s  */
+	[3] = 0x3,  /* 3s  */
+	[4] = 0x4,  /* 4s  */
+	[5] = 0x5,  /* 5s  */
+	[6] = 0x6,  /* 6s  */
+	[8] = 0x7,  /* 8s  */
+	[10] = 0x8, /* 10s */
+	[12] = 0x9, /* 12s */
+	[14] = 0xA, /* 14s */
+	[16] = 0xB, /* 16s */
 };
 
 static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
-- 
1.9.1

