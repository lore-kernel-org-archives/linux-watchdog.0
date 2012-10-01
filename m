Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2JAMYt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Oct 2012 08:24:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4894647bkc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Oct 2012 05:24:48 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v6 1/5] watchdog: core: dt: add support for the timeout device tree property
Date: Mon,  1 Oct 2012 14:24:37 +0200
Message-Id: <1349094281-28889-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  3 +++
 include/linux/watchdog.h                       | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 086638f..decd981 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -212,3 +212,6 @@ driver specific data to and a pointer to the data itself.
 The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
+
+The watchdog_probe_dt function allows you to retrieve the timeout property
+from the device tree.
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..06f9384 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -11,6 +11,7 @@
 
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
@@ -174,6 +175,16 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
+/* Use the following function to retrieve the timeout property from dt */
+static inline void watchdog_probe_dt(struct watchdog_device *wdd,
+				     struct device_node *node)
+{
+	if (!node)
+		return;
+
+	of_property_read_u32(node, "timeout", &wdd->timeout);
+}
+
 /* drivers/watchdog/core/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
-- 
1.7.11.3

