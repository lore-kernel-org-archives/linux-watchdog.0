Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44876 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeH2LiT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Aug 2018 07:38:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v3 3/4] watchdog: core: add module_watchdog_pci_driver()
Date: Wed, 29 Aug 2018 09:42:40 +0200
Message-Id: <20180829074241.1943-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
References: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Allow PCI drivers to prevent removing if NOWAYOUT, too.

Note: This is only a build-tested proof-of-concept!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/watchdog.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index c8ecbc53c807..7f097d6f94d4 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -233,4 +233,8 @@ module_exit(__driver##_exit)
 	module_watchdog_driver(__platform_driver, platform_driver_register, \
 				platform_driver_unregister, __nowayout)
 
+#define module_watchdog_pci_driver(__pci_driver, __nowayout) \
+	module_watchdog_driver(__pci_driver, pci_register_driver, \
+				pci_unregister_driver, __nowayout)
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
2.11.0
