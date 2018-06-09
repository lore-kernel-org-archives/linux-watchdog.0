Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeFIGnq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 9 Jun 2018 02:43:46 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when watchdog is running
Date: Sat,  9 Jun 2018 08:43:13 +0200
Message-Id: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

As pointed out in the added comment resetting the rtc also stops the
included watchdog. This is bad if the bootloader started the watchdog to
secure the boot process. So don't reset if the watchdog is running.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index d578e40d5a50..b76318fd5bb0 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -288,10 +288,22 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc_data);
 
-	err = stmp_reset_block(rtc_data->io);
-	if (err) {
-		dev_err(&pdev->dev, "stmp_reset_block failed: %d\n", err);
-		return err;
+	/*
+	 * Resetting the rtc stops the watchdog timer that is potentially
+	 * running. So (assuming it is running on purpose) don't reset if the
+	 * watchdog is enabled.
+	 */
+	if (readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
+	    STMP3XXX_RTC_CTRL_WATCHDOGEN) {
+		dev_info(&pdev->dev,
+			 "Watchdog is running, skip resetting rtc\n");
+	} else {
+		err = stmp_reset_block(rtc_data->io);
+		if (err) {
+			dev_err(&pdev->dev, "stmp_reset_block failed: %d\n",
+				err);
+			return err;
+		}
 	}
 
 	/*
-- 
2.17.1

