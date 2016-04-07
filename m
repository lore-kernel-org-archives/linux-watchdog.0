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
Subject: [PATCH 02/10] isa: Implement the max_num_isa_dev macro
Date: Thu,  7 Apr 2016 10:47:23 -0400
Message-Id: <34d77952d94c05b187e83e2de78b4de4533c5650.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

max_num_isa_dev is a macro to determine the maximum possible number of
ISA devices which may be registered in the I/O port address space given
the address extent of the ISA devices.

The highest base address possible for an ISA device is 0x3FF; this
results in 1024 possible base addresses. Dividing the number of possible
base addresses by the address extent taken by each device results in the
maximum number of devices on a system.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/isa.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/isa.h b/include/linux/isa.h
index d410259..bc0a7c0 100644
--- a/include/linux/isa.h
+++ b/include/linux/isa.h
@@ -57,4 +57,15 @@ static void __exit __isa_driver##_exit(void) \
 } \
 module_exit(__isa_driver##_exit);
 
+/**
+ * max_num_isa_dev() - Maximum possible number registered of an ISA device
+ * @__ida_dev_ext: ISA device address extent
+ *
+ * The highest base address possible for an ISA device is 0x3FF; this results in
+ * 1024 possible base addresses. Dividing the number of possible base addresses
+ * by the address extent taken by each device results in the maximum number of
+ * devices on a system.
+ */
+#define max_num_isa_dev(__isa_dev_ext) (1024 / __isa_dev_ext)
+
 #endif /* __LINUX_ISA_H */
-- 
2.7.3
