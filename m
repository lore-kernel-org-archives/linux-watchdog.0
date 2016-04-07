Return-path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	wim@iguana.be,
	linux@roeck-us.net,
	linus.walleij@linaro.org,
	gnurou@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 01/10] isa: Implement the module_isa_driver macro
Date: Thu,  7 Apr 2016 10:47:22 -0400
Message-Id: <e15a74f1cc7a72f97060f0f1acb2991ffa82bd97.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The module_isa_driver macro is a helper macro for ISA drivers which do
not do anything special in module init/exit. This eliminates a lot of
boilerplate code. Each module may only use this macro once, and calling
it replaces module_init and module_exit.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/isa.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/isa.h b/include/linux/isa.h
index 2a02862..d410259 100644
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
