Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55726 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3AHKEX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Jan 2013 05:04:23 -0500
Received: by mail-ee0-f47.google.com with SMTP id e51so112093eek.34
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Jan 2013 02:04:22 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v7 1/6] watchdog: core: dt: add support for the timeout-sec dt property
Date: Tue,  8 Jan 2013 11:04:10 +0100
Message-Id: <1357639455-21935-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 10 +++++++
 drivers/watchdog/watchdog_core.c               | 37 ++++++++++++++++++++++++++
 include/linux/watchdog.h                       |  3 +++
 3 files changed, 50 insertions(+)

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
index 3796434..758a285 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -36,12 +36,49 @@
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/idr.h>		/* For ida_* macros */
 #include <linux/err.h>		/* For IS_ERR macros */
+#include <linux/of.h>		/* For of_get_timeout_sec */
 
 #include "watchdog_core.h"	/* For watchdog_dev_register/... */
 
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+static bool watchdog_is_valid_timeout(struct watchdog_device *wdd,
+				      unsigned int t)
+
+{
+	if (wdd->min_timeout < wdd->max_timeout)
+		return (wdd->min_timeout <= t) && (t <= wdd->max_timeout);
+	else
+		return (t > 0);
+}
+
+/**
+ * watchdog_init_timeout() - initialize the timeout field
+ * @parm: timeout module parameter, it takes precedence over the
+ *        timeout-sec property.
+ * @node: Retrieve the timeout-sec property only if the parm_timeout
+ *        is out of bounds.
+ */
+void watchdog_init_timeout(struct watchdog_device *wdd, unsigned int parm,
+			   struct device_node *node)
+{
+	unsigned int t = 0;
+
+	if (watchdog_is_valid_timeout(wdd, parm)) {
+		wdd->timeout = parm;
+		return;
+	}
+
+	/* try to get the timeout_sec property */
+	if (!node)
+		return;
+	of_property_read_u32(node, "timeout-sec", &t);
+	if (watchdog_is_valid_timeout(wdd, t))
+		wdd->timeout = t;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_timeout);
+
 /**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 3a9df2f..e40cc2b 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -130,6 +130,9 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/watchdog_core.c */
+extern void watchdog_init_timeout(struct watchdog_device *wdd,
+				  unsigned int parm_timeout,
+				  struct device_node *node);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.8.0.3

