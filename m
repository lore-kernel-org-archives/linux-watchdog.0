Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:44140 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab3BNIOk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 03:14:40 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so1173697eek.16
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Feb 2013 00:14:39 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 2/8] watchdog: core: fix watchdog_check_min_max_timeout() return value
Date: Thu, 14 Feb 2013 09:14:24 +0100
Message-Id: <1360829670-10418-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The device tree support is not mandatory, so the function doesn't
return error when is not used.
Return -EINVAL when the module parameter or
timeout-sec property is out of bounds.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/watchdog_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 94590f6..05d18b4 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -73,22 +73,28 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 				unsigned int timeout_parm, struct device *dev)
 {
 	unsigned int t = 0;
+	int ret = 0;
 
 	watchdog_check_min_max_timeout(wdd);
 
 	/* try to get the tiemout module parameter first */
 	if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
 		wdd->timeout = timeout_parm;
-		return 0;
+		return ret;
 	}
+	if (timeout_parm)
+		ret = -EINVAL;
 
 	/* try to get the timeout_sec property */
 	if (dev == NULL || dev->of_node == NULL)
-		return -EINVAL;
+		return ret;
 	of_property_read_u32(dev->of_node, "timeout-sec", &t);
 	if (!watchdog_timeout_invalid(wdd, t))
 		wdd->timeout = t;
-	return 0;
+	else
+		ret = -EINVAL;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
-- 
1.8.1.1

