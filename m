Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37474 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752924AbaCLVM3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:12:29 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 2/8] watchdog: orion: Remove unneeded atomic access
Date: Wed, 12 Mar 2014 18:11:49 -0300
Message-Id: <1394658715-2017-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The RSTOUT register on the Armada 370 SoC variant is a dedicated register
(not shared across orthogonal subsystems) and so it's not needed to write
it atomically.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 76ebcdd..9c25012 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -146,6 +146,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 static int armada370_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
 
 	/* Set watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
@@ -158,8 +159,10 @@ static int armada370_start(struct watchdog_device *wdt_dev)
 	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
 						dev->data->wdt_enable_bit);
 
-	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
-				      dev->data->rstout_enable_bit);
+	/* Enable reset on watchdog */
+	reg = readl(dev->rstout);
+	reg |= dev->data->rstout_enable_bit;
+	writel(reg, dev->rstout);
 	return 0;
 }
 
-- 
1.9.0

