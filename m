Return-path: <jszhang@marvell.com>
From: Jisheng Zhang <jszhang@marvell.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/2] watchdog: dw_wdt: restart the counter immediately after enabling WDT
Date: Fri, 19 Sep 2014 14:29:58 +0800
Message-ID: <1411108199-1280-2-git-send-email-jszhang@marvell.com>
In-Reply-To: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
References: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The TOP_INIT may be zero, so the timeout period may be very short after
initialization is done, thus the system may be reset soon after enabling.
We fix this problem by restarting the counter immediately after enabling
WDT.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/watchdog/dw_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 9f21029..ad0619d 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -146,6 +146,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 		dw_wdt_set_top(DW_WDT_MAX_TOP);
 		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+		dw_wdt_keepalive();
 	}
 
 	dw_wdt_set_next_heartbeat();
-- 
2.1.0
