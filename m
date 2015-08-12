Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40521 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933581AbbHLIQL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:11 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 7/7] watchdog: mpc8xxx: allow to compile for MPC512x
Date: Wed, 12 Aug 2015 10:15:58 +0200
Message-Id: <1439367358-5338-8-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The MPC5125 processor features a watchdog device that is identical to
the MPC8610 one. So allow to enable the driver for MPC512x kernel
configurations.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 241fafde42cb..8c43ae9bde2b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1333,7 +1333,7 @@ config MPC5200_WDT
 
 config 8xxx_WDT
 	tristate "MPC8xxx Platform Watchdog Timer"
-	depends on PPC_8xx || PPC_83xx || PPC_86xx
+	depends on PPC_8xx || PPC_83xx || PPC_86xx || PPC_MPC512x
 	select WATCHDOG_CORE
 	help
 	  This driver is for a SoC level watchdog that exists on some
-- 
2.4.6

