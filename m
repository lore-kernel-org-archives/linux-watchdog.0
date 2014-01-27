Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v5 01/20] ARM: Introduce atomic MMIO modify
Date: Mon, 27 Jan 2014 12:27:01 -0300
Message-Id: <1390836440-12744-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Some SoC have MMIO regions that are shared across orthogonal
subsystems. This commit implements a possible solution for the
thread-safe access of such regions through a spinlock-protected API.

Concurrent access is protected with a single spinlock for the
entire MMIO address space. While this protects shared-registers,
it also serializes access to unrelated/unshared registers.

We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
respectively. The rationale for this is that some users may not require
register write completion but only thread-safe access to a register.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Russell,

Can you confirm this patch is on its way to v3.14?

 arch/arm/include/asm/io.h |  6 ++++++
 arch/arm/kernel/io.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index fbeb39c..8aa4cca 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -38,6 +38,12 @@
 #define isa_bus_to_virt phys_to_virt
 
 /*
+ * Atomic MMIO-wide IO modify
+ */
+extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
+extern void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set);
+
+/*
  * Generic IO read/write.  These perform native-endian accesses.  Note
  * that some architectures will want to re-define __raw_{read,write}w.
  */
diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index dcd5b4d..9203cf8 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -1,6 +1,41 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
+
+static DEFINE_RAW_SPINLOCK(__io_lock);
+
+/*
+ * Generic atomic MMIO modify.
+ *
+ * Allows thread-safe access to registers shared by unrelated subsystems.
+ * The access is protected by a single MMIO-wide lock.
+ */
+void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&__io_lock, flags);
+	value = readl_relaxed(reg) & ~mask;
+	value |= (set & mask);
+	writel_relaxed(value, reg);
+	raw_spin_unlock_irqrestore(&__io_lock, flags);
+}
+EXPORT_SYMBOL(atomic_io_modify_relaxed);
+
+void atomic_io_modify(void __iomem *reg, u32 mask, u32 set)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&__io_lock, flags);
+	value = readl_relaxed(reg) & ~mask;
+	value |= (set & mask);
+	writel(value, reg);
+	raw_spin_unlock_irqrestore(&__io_lock, flags);
+}
+EXPORT_SYMBOL(atomic_io_modify);
 
 /*
  * Copy data from IO memory space to "real" memory space.
-- 
1.8.1.5
