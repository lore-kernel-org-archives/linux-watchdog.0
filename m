Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32800 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbcEWXNi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 19:13:38 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 1/4] isa: Allow ISA-style drivers on modern systems
Date: Mon, 23 May 2016 19:13:31 -0400
Message-Id: <8b451e5892f0e610d7899f77be77b1cc57ce712b.1464044853.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464044853.git.vilhelm.gray@gmail.com>
References: <cover.1464044853.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Several modern devices, such as PC/104 cards, are expected to run on
modern systems via an ISA bus interface. Since ISA is a legacy interface
for most modern architectures, ISA support should remain disabled in
general. Support for ISA-style drivers should be enabled on a per driver
basis.

To allow ISA-style drivers on modern systems, this patch introduces the
ISA_BUS_API and ISA_BUS Kconfig options. The ISA bus driver will now
build conditionally on the ISA_BUS_API Kconfig option, which defaults to
the legacy ISA Kconfig option. The ISA_BUS Kconfig option allows the
ISA_BUS_API Kconfig option to be selected on architectures which do not
enable ISA (e.g. X86_64).

The ISA_BUS Kconfig option is currently only implemented for X86
architectures. Other architectures may have their own ISA_BUS Kconfig
options added as required.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 arch/Kconfig          |  3 +++
 arch/x86/Kconfig      | 10 ++++++++++
 drivers/base/Makefile |  2 +-
 include/linux/isa.h   |  2 +-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b16e74e..9d9942f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -598,6 +598,9 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config ISA_BUS_API
+	def_bool ISA
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a7b885..a5338a6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,6 +2439,16 @@ config PCI_CNB20LE_QUIRK
 
 source "drivers/pci/Kconfig"
 
+config ISA_BUS
+	bool "ISA-style bus support on modern systems" if EXPERT
+	default n
+	select ISA_BUS_API
+	help
+	  Enables ISA-style drivers on modern systems. This is necessary to
+	  support PC/104 devices on X86_64 platforms.
+
+	  If unsure, say N.
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
diff --git a/include/linux/isa.h b/include/linux/isa.h
index 5ab8528..384ab9b 100644
--- a/include/linux/isa.h
+++ b/include/linux/isa.h
@@ -22,7 +22,7 @@ struct isa_driver {
 
 #define to_isa_driver(x) container_of((x), struct isa_driver, driver)
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_ISA_BUS_API
 int isa_register_driver(struct isa_driver *, unsigned int);
 void isa_unregister_driver(struct isa_driver *);
 #else
-- 
2.7.3

