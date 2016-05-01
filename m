Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34172 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbcEAWm4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:42:56 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 01/10] isa: Implement the module_isa_driver macro
Date: Sun,  1 May 2016 18:42:47 -0400
Message-Id: <76b1401413d22c0b6e095a6fdeda59ca75f7ef4b.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The module_isa_driver macro is a helper macro for ISA drivers which do
not do anything special in module init/exit. This eliminates a lot of
boilerplate code. Each module may only use this macro once, and calling
it replaces module_init and module_exit.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/isa.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/isa.h b/include/linux/isa.h
index b0270e3..e394917 100644
--- a/include/linux/isa.h
+++ b/include/linux/isa.h
@@ -36,4 +36,25 @@ static inline void isa_unregister_driver(struct isa_driver *d)
 }
 #endif
 
+/**
+ * module_isa_driver() - Helper macro for registering a ISA driver
+ * @__isa_driver: isa_driver struct
+ * @__num_isa_dev: number of devices to register
+ *
+ * Helper macro for ISA drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate code. Each module may only
+ * use this macro once, and calling it replaces module_init and module_exit.
+ */
+#define module_isa_driver(__isa_driver, __num_isa_dev) \
+static int __init __isa_driver##_init(void) \
+{ \
+	return isa_register_driver(&(__isa_driver), __num_isa_dev); \
+} \
+module_init(__isa_driver##_init); \
+static void __exit __isa_driver##_exit(void) \
+{ \
+	isa_unregister_driver(&(__isa_driver)); \
+} \
+module_exit(__isa_driver##_exit);
+
 #endif /* __LINUX_ISA_H */
-- 
2.7.3

