Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36274 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbbGYGZ0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jul 2015 02:25:26 -0400
Message-ID: <55B32BCE.5050506@gmail.com>
Date: Sat, 25 Jul 2015 08:25:18 +0200
From: Francesco Lavra <francescolavra.fl@gmail.com>
MIME-Version: 1.0
To: wim@iguana.be, maxime.ripard@free-electrons.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: sunxi: fix activation of system reset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
strings") introduced a regression in sunxi_wdt_start(), by which
the system reset function of the watchdog is not enabled upon
starting the watchdog. As a result, the system is not reset when the
watchdog expires. Fix it. 

Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible strings")
Cc: stable@vger.kernel.org
---
Changes in v2:
  - Added Reviewed-by, Fixes, and Cc tags
  - Fixed commit message
---
 drivers/watchdog/sunxi_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index a29afb3..47bd8a1 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -184,7 +184,7 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set system reset function */
 	reg = readl(wdt_base + regs->wdt_cfg);
 	reg &= ~(regs->wdt_reset_mask);
-	reg |= ~(regs->wdt_reset_val);
+	reg |= regs->wdt_reset_val;
 	writel(reg, wdt_base + regs->wdt_cfg);
 
 	/* Enable watchdog */
-- 
1.9.1
