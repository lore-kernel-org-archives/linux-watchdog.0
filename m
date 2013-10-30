Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42101 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3J3X5h (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 19:57:37 -0400
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: imx2_wdt: add module device table
Message-Id: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
Date: Wed, 30 Oct 2013 23:57:00 +0000
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/watchdog/imx2_wdt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 693ac3f4de5a..ae1ac198d968 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -340,3 +340,4 @@ MODULE_DESCRIPTION("Watchdog driver for IMX2 and later");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
-- 
1.7.4.4

