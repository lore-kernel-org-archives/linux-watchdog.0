Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:65303 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMWl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:22:41 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so545453eek.25
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:22:39 -0800 (PST)
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
Subject: [PATCH v8 2/7] watchdog: core: dt: add support for the timeout-sec dt property
Date: Wed, 13 Feb 2013 13:22:25 +0100
Message-Id: <1360758150-23004-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 10 ++++++++
 drivers/watchdog/watchdog_core.c               | 34 ++++++++++++++++++++++++++
 include/linux/watchdog.h                       |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 086638f..44098c2 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -212,3 +212,13 @@ driver specific data to and a pointer to the data itself.
 The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
+
+To initialize the timeout field use the following function:
+
+extern void watchdog_init_timeout(struct watchdog_device *wdd,
+                                  unsigned int parm_timeout,
+                                  struct device_node *node);
+
+The watchdog_init_timeout function allows you to initialize the timeout field
+using the module timeout parameter or retrieving the timeout-sec property from
+the device tree.
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index f10fa31..b9e9148 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/idr.h>		/* For ida_* macros */
 #include <linux/err.h>		/* For IS_ERR macros */
+#include <linux/of.h>		/* For of_get_timeout_sec */
 
 #include "watchdog_core.h"	/* For watchdog_dev_register/... */
 
@@ -57,6 +58,39 @@ bool watchdog_is_valid_timeout(struct watchdog_device *wdd, uint timeout)
 EXPORT_SYMBOL_GPL(watchdog_is_valid_timeout);
 
 /**
+ * watchdog_init_timeout() - initialize the timeout field
+ * @parm: timeout module parameter, it takes precedence over the
+ *        timeout-sec property.
+ * @node: Retrieve the timeout-sec property only if the parm_timeout
+ *        is out of bounds.
+ */
+int watchdog_init_timeout(struct watchdog_device *wdd, uint parm,
+			  struct device *dev)
+{
+	uint timeout = 0;
+	int ret = 0;
+
+	if (watchdog_is_valid_timeout(wdd, parm)) {
+		wdd->timeout = parm;
+		return ret;
+	}
+	if (parm)
+		ret = -EINVAL;
+
+	/* try to get the timeout_sec property */
+	if (!dev->of_node)
+		return ret;
+	of_property_read_u32(dev->of_node, "timeout-sec", &timeout);
+	if (watchdog_is_valid_timeout(wdd, timeout))
+		wdd->timeout = timeout;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_timeout);
+
+/**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
  *
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 9ae945e..b1023dd 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -132,6 +132,8 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 /* drivers/watchdog/watchdog_core.c */
 extern bool watchdog_is_valid_timeout(struct watchdog_device *wdd,
 				      uint timeout);
+extern int watchdog_init_timeout(struct watchdog_device *wdd,
+				  uint parm_timeout, struct device *dev);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.8.1.1

