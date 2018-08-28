Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41460 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH1XHg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:07:36 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 1/4] watchdog: core: add mechanism to prevent removing if NOWAYOUT
Date: Tue, 28 Aug 2018 21:14:13 +0200
Message-Id: <20180828191416.7781-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

To prevent removing if NOWAYOUT, we invalidate the .remove function and
suppress the bind/unbind attributes in sysfs. These are driver
capabilities, so we need to set it up at runtime during init. To avoid
boilerplate, introduce module_watchdog_driver() similar to
module_driver(). On top of that, we then build
module_watchdog_platform_driver(). Others may follow, if needed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/watchdog.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 44985c4a1e86..5768fb6b5cde 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -216,4 +216,24 @@ extern void watchdog_unregister_device(struct watchdog_device *);
 /* devres register variant */
 int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
 
+#define module_watchdog_driver(__driver, __register, __unregister, __nowayout, ...) \
+static int __init __driver##_init(void) \
+{ \
+	if (__nowayout) { \
+		__driver.driver.suppress_bind_attrs = true; \
+		__driver.remove = NULL; \
+	} \
+	return __register(&(__driver)  ##__VA_ARGS__); \
+} \
+module_init(__driver##_init); \
+static void __exit __driver##_exit(void) \
+{ \
+	__unregister(&(__driver), ##__VA_ARGS__); \
+} \
+module_exit(__driver##_exit)
+
+#define module_watchdog_platform_driver(__platform_driver, __nowayout) \
+	module_watchdog_driver(__platform_driver, platform_driver_register, \
+				platform_driver_unregister, __nowayout)
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
2.11.0
