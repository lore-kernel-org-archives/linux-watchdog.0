Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 6/6] watchdog: tangox_wdt: test clock rate to avoid division by 0
Date: Wed,  2 Mar 2016 23:33:37 +0100
Message-Id: <1456958018-7849-7-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Should go individually via subsystem tree.

 drivers/watchdog/tangox_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index 709c1ed6fd79b9..cc702718ae4dbb 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -139,6 +139,8 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 		return err;
 
 	dev->clk_rate = clk_get_rate(dev->clk);
+	if (!dev->clk_rate)
+		return -EINVAL;
 
 	dev->wdt.parent = &pdev->dev;
 	dev->wdt.info = &tangox_wdt_info;
-- 
2.7.0
