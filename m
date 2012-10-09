Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46214 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab2JIMEU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Oct 2012 08:04:20 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3446960eek.19
        for <linux-watchdog@vger.kernel.org>; Tue, 09 Oct 2012 05:04:19 -0700 (PDT)
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
Subject: [PATCH v4 2/8] watchdog: core: dt: add support for the timeout-sec dt property
Date: Tue,  9 Oct 2012 14:04:05 +0200
Message-Id: <1349784251-28261-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
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
index 3796434..37dde68 100644
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
+	of_get_timeout_sec(node, &t);
+	if (watchdog_is_valid_timeout(wdd, t))
+		wdd->timeout = t;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_timeout);
+
 /**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..b8eec8d 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -175,6 +175,9 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/core/watchdog_core.c */
+extern void watchdog_init_timeout(struct watchdog_device *wdd,
+				  unsigned int parm_timeout,
+				  struct device_node *node);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.7.11.3

