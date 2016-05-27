Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36634 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbcE0Pdq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 11:33:46 -0400
Received: by mail-wm0-f51.google.com with SMTP id n129so278391944wmn.1
        for <linux-watchdog@vger.kernel.org>; Fri, 27 May 2016 08:33:45 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] watchdog: Add a device managed API for watchdog_register_device()
Date: Fri, 27 May 2016 17:33:54 +0200
Message-Id: <1464363234-9777-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This helps in reducing code in .remove callbacks and sometimes
dropping .remove callbacks entirely.

Changes since v1 at http://lkml.kernel.org/r/1464251510-15554-1-git-send-email-narmstrong@baylibre.com :
- Fix brackets in devm_watchdog_register_device()

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/driver-model/devres.txt |  3 +++
 drivers/watchdog/watchdog_core.c      | 37 +++++++++++++++++++++++++++++++++++
 include/linux/watchdog.h              |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index c63eea0..589296b 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -357,3 +357,6 @@ SLAVE DMA ENGINE
 
 SPI
   devm_spi_register_master()
+
+WATCHDOG
+  devm_watchdog_register_device()
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 981a668..7c5e3dc 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -329,6 +329,43 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
+static void devm_watchdog_unregister_device(struct device *dev, void *res)
+{
+	watchdog_unregister_device(*(struct watchdog_device **)res);
+}
+
+/**
+ * devm_watchdog_register_device() - resource managed watchdog_register_device()
+ * @dev: device that is registering this watchdog device
+ * @wdd: watchdog device
+ *
+ * Managed watchdog_register_device(). For watchdog device registered by this
+ * function,  watchdog_unregister_device() is automatically called on driver
+ * detach. See watchdog_register_device() for more information.
+ */
+int devm_watchdog_register_device(struct device *dev,
+				struct watchdog_device *wdd)
+{
+	struct watchdog_device **rcwdd;
+	int ret;
+
+	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*wdd),
+			     GFP_KERNEL);
+	if (!rcwdd)
+		return -ENOMEM;
+
+	ret = watchdog_register_device(wdd);
+	if (!ret) {
+		*rcwdd = wdd;
+		devres_add(dev, rcwdd);
+	} else {
+		devres_free(rcwdd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_watchdog_register_device);
+
 static int __init watchdog_deferred_registration(void)
 {
 	mutex_lock(&wtd_deferred_reg_mutex);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 51732d6c..6b75e38 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -180,4 +180,7 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+/* devres register variant */
+int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
2.7.0

