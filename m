Return-Path: <postmaster@kaiser.cx>
Return-path: <postmaster@kaiser.cx>
From: Martin Kaiser <martin@kaiser.cx>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>,
	kernel@pengutronix.de,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Martin Kaiser <martin@kaiser.cx>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: imx2_wdt: restore previous timeout after suspend+resume
Date: Fri, 29 Dec 2017 14:59:10 +0100
Message-Id: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
List-ID: <linux-watchdog@vger.kernel.org>

When the watchdog device is suspended, its timeout is set to the maximum
value. During resume, the previously set timeout should be restored.
This does not work at the moment.

The suspend function calls

imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);

and resume reverts this by calling

imx2_wdt_set_timeout(wdog, wdog->timeout);

However, imx2_wdt_set_timeout() updates wdog->timeout. Therefore,
wdog->timeout is set to IMX2_WDT_MAX_TIME when we enter the resume
function.

Fix this by setting wdog->timeout to the previous value at the end of
the suspend function. This manual update makes wdog->timeout different
from the actual setting in the hardware. This should be ok in our case
as kernel code is not running while we're suspended.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Cc: stable@vger.kernel.org
---
 drivers/watchdog/imx2_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f..66efcc0 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -368,6 +368,7 @@ static int imx2_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdog = dev_get_drvdata(dev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+	unsigned int resume_timeout = wdog->timeout;
 
 	/* The watchdog IP block is running */
 	if (imx2_wdt_is_running(wdev)) {
@@ -377,6 +378,7 @@ static int imx2_wdt_suspend(struct device *dev)
 
 	clk_disable_unprepare(wdev->clk);
 
+	wdog->timeout = resume_timeout;
 	return 0;
 }
 
-- 
2.1.4
