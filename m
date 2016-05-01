Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33142 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAWnW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:43:22 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 02/10] isa: Implement the max_num_isa_dev macro
Date: Sun,  1 May 2016 18:43:10 -0400
Message-Id: <b39c697cb11924f7aa11a7305256425088cf731a.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
index e394917..5ab8528 100644
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

