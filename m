Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from botnar.kaiser.cx ([176.28.20.183]:42300 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeAAR1y (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 1 Jan 2018 12:27:54 -0500
From: Martin Kaiser <martin@kaiser.cx>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de, Fabio Estevam <fabio.estevam@freescale.com>,
        Martin Kaiser <martin@kaiser.cx>, stable@vger.kernel.org
Subject: [PATCH v3] watchdog: imx2_wdt: restore previous timeout after suspend+resume
Date: Mon,  1 Jan 2018 18:26:47 +0100
Message-Id: <1514827607-11580-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
References: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

Fix this by adding a new function __imx2_wdt_set_timeout() which
only updates the hardware settings. imx2_wdt_set_timeout() now calls
__imx2_wdt_set_timeout() and then saves the new timeout to
wdog->timeout.

During suspend, we call __imx2_wdt_set_timeout() directly so that
wdog->timeout won't be updated and we can restore the previous value
during resume. This approach makes wdog->timeout different from the
actual setting in the hardware which is usually not a good thing.
However, the two differ only while we're suspended and no kernel code is
running, so it should be ok in this case.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Cc: stable@vger.kernel.org
---
changes in v3:
 reformat
 remove return value of __imx2_wdt_set_timeout()

changes in v2:
 helper function that updates the hw settings, as per Guenter's proposal

 drivers/watchdog/imx2_wdt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f..518dfa1 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -169,15 +169,21 @@ static int imx2_wdt_ping(struct watchdog_device *wdog)
 	return 0;
 }
 
-static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
-				unsigned int new_timeout)
+static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
+				   unsigned int new_timeout)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	wdog->timeout = new_timeout;
-
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
+}
+
+static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
+				unsigned int new_timeout)
+{
+	__imx2_wdt_set_timeout(wdog, new_timeout);
+
+	wdog->timeout = new_timeout;
 	return 0;
 }
 
@@ -371,7 +377,11 @@ static int imx2_wdt_suspend(struct device *dev)
 
 	/* The watchdog IP block is running */
 	if (imx2_wdt_is_running(wdev)) {
-		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
+		/*
+		 * Don't update wdog->timeout, we'll restore the current value
+		 * during resume.
+		 */
+		__imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
 	}
 
-- 
2.1.4

