Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33752 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbcEWO6t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 10:58:49 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] isa: Allow ISA-style drivers on modern systems
Date: Mon, 23 May 2016 10:58:41 -0400
Message-Id: <484d20f0a177f48a6d9a93520933b830d4412cca.1464014576.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464014576.git.vilhelm.gray@gmail.com>
References: <cover.1464014576.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Several modern devices, such as PC/104 cards, are expected to run on
modern systems via an ISA bus interface. Since ISA is a legacy interface
for most modern architectures, ISA support should remain disabled in
general. Support for ISA-style drivers should be enabled on a per driver
basis.

To allow ISA-style drivers on modern systems, this patch introduces the
ISA_BUS_API and ISA_BUS Kconfig options. The X86 ISA bus driver will now
build conditionally on the ISA_BUS_API Kconfig option, which defaults to
the legacy ISA Kconfig option. The ISA_BUS Kconfig option allows the
ISA_BUS_API Kconfig option to be selected on architectures which do not
enable ISA (e.g. X86_64).

For now, the ISA_BUS Kconfig option is only be available on X86
architectures. Support for other architectures may be added as required.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 arch/x86/Kconfig      | 13 +++++++++++++
 drivers/base/Makefile |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a7b885..a41c0b8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,6 +2439,19 @@ config PCI_CNB20LE_QUIRK
 
 source "drivers/pci/Kconfig"
 
+config ISA_BUS_API
+	def_bool ISA
+
+config ISA_BUS
+	bool "ISA-style bus support on modern systems" if (X86 && EXPERT)
+	default y
+	select ISA_BUS_API
+	help
+	  Enables ISA-style drivers on modern systems. This is necessary to
+	  support PC/104 devices on X86_64 platforms.
+
+	  If unsure, say Y.
+
 # x86_64 have no ISA slots, but can have ISA-style DMA.
 config ISA_DMA_API
 	bool "ISA-style DMA support" if (X86_64 && EXPERT)
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 6b2a84e..2609ba2 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
 obj-$(CONFIG_HAS_DMA)	+= dma-mapping.o
 obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += dma-coherent.o
-obj-$(CONFIG_ISA)	+= isa.o
+obj-$(CONFIG_ISA_BUS_API)	+= isa.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
-- 
2.7.3

