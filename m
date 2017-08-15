Return-Path: <huibin.hong@rock-chips.com>
Return-path: <huibin.hong@rock-chips.com>
From: Huibin Hong <huibin.hong@rock-chips.com>
To: linux@roeck-us.net
Cc: huangtao@rock-chips.com,
	Huibin Hong <huibin.hong@rock-chips.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: dw_wdt: fix overflow issue in dw_wdt_top_in_seconds
Date: Tue, 15 Aug 2017 10:45:13 +0800
Message-Id: <1502765113-1025-1-git-send-email-huibin.hong@rock-chips.com>
List-ID: <linux-watchdog@vger.kernel.org>

If top is 15, (1 << (16 + top)) may be negative.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---

Changes in v2:
    - Rebase mainline Linux 4.13-rc5

 drivers/watchdog/dw_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 36be987..59ed958 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -72,7 +72,9 @@ static inline int dw_wdt_top_in_seconds(struct dw_wdt *dw_wdt, unsigned top)
 	 * There are 16 possible timeout values in 0..15 where the number of
 	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
 	 */
-	return (1U << (16 + top)) / dw_wdt->rate;
+	unsigned int cycles = 1 << (16 + top);
+
+	return (cycles / clk_get_rate(dw_wdt.clk));
 }
 
 static int dw_wdt_get_top(struct dw_wdt *dw_wdt)
-- 
1.9.1
