Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2360 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbbJEXpd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Oct 2015 19:45:33 -0400
From: David Cohen <david.a.cohen@linux.intel.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>
Subject: [PATCH] wdt: intel-mid: add Magic Closure flag
Date: Mon,  5 Oct 2015 16:49:58 -0700
Message-Id: <1444088998-20835-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Adding WDIOF_MAGICCLOSE to Intel MID watchdog driver. Once the watchdog
is opened, it makes sense to disable watchdog only if it was gracefully
released.

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 0a436b5d1e84..db36d12e2b52 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -101,7 +101,7 @@ static irqreturn_t mid_wdt_irq(int irq, void *dev_id)
 
 static const struct watchdog_info mid_wdt_info = {
 	.identity = "Intel MID SCU watchdog",
-	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
 static const struct watchdog_ops mid_wdt_ops = {
-- 
2.1.4

