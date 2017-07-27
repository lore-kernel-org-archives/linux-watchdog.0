Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:34518 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdG0Mu6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Jul 2017 08:50:58 -0400
From: Huibin Hong <huibin.hong@rock-chips.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Huibin Hong <huibin.hong@rock-chips.com>
Subject: [PATCH] watchdog: dw_wdt: fix overflow issue in dw_wdt_top_in_seconds
Date: Thu, 27 Jul 2017 20:50:43 +0800
Message-Id: <1501159843-6623-1-git-send-email-huibin.hong@rock-chips.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If top is 15, (1 << (16 + top)) may be negative.

Change-Id: I76e4a603a54f093e64a4b266008570e3afcdb35a
Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---
 drivers/watchdog/dw_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6ea0634..059c974 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -81,7 +81,9 @@ static inline int dw_wdt_top_in_seconds(unsigned top)
 	 * There are 16 possible timeout values in 0..15 where the number of
 	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
 	 */
-	return (1 << (16 + top)) / clk_get_rate(dw_wdt.clk);
+	unsigned int cycles = 1 << (16 + top);
+
+	return cycles / clk_get_rate(dw_wdt.clk);
 }
 
 static int dw_wdt_get_top(void)
-- 
1.9.1


