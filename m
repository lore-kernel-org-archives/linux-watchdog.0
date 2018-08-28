Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41484 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeH1XHh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:07:37 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 3/4] watchdog: core: add module_watchdog_pci_driver()
Date: Tue, 28 Aug 2018 21:14:15 +0200
Message-Id: <20180828191416.7781-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Allow PCI drivers to prevent removing if NOWAYOUT, too.

Note: This is only a build-tested proof-of-concept!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/watchdog.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 5768fb6b5cde..07c01e8050e8 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -236,4 +236,8 @@ module_exit(__driver##_exit)
 	module_watchdog_driver(__platform_driver, platform_driver_register, \
 				platform_driver_unregister, __nowayout)
 
+#define module_watchdog_pci_driver(__pci_driver, __nowayout) \
+	module_watchdog_driver(__pci_driver, pci_register_driver, \
+				pci_unregister_driver, __nowayout)
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
2.11.0
