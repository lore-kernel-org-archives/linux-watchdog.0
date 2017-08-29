Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752875AbdH2Pm7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:42:59 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 1/8] MIPS: Octeon: Add support for accessing the boot vector.
Date: Tue, 29 Aug 2017 10:40:31 -0500
Message-Id: <1504021238-3184-2-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Used by the Octeon watchdog driver to get the address of the
firmware boot vector.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     | 167 +++++++++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  85 +++++++++++
 arch/mips/include/asm/octeon/cvmx-boot-vector.h    |  53 +++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  28 ++++
 5 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-boot-vector.h

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index b6d6e84..50b4278 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -16,4 +16,4 @@ obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
 	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
 	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
 
-obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
+obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o cvmx-boot-vector.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
new file mode 100644
index 0000000..b7019d2
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
@@ -0,0 +1,167 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2017 Cavium, Inc.
+ */
+
+
+/*
+  We install this program at the bootvector:
+------------------------------------
+	.set noreorder
+	.set nomacro
+	.set noat
+reset_vector:
+	dmtc0	$k0, $31, 0	# Save $k0 to DESAVE
+	dmtc0	$k1, $31, 3	# Save $k1 to KScratch2
+
+	mfc0	$k0, $12, 0	# Status
+	mfc0	$k1, $15, 1	# Ebase
+
+	ori	$k0, 0x84	# Enable 64-bit addressing, set
+				# ERL (should already be set)
+	andi	$k1, 0x3ff	# mask out core ID
+
+	mtc0	$k0, $12, 0	# Status
+	sll	$k1, 5
+
+	lui	$k0, 0xbfc0
+	cache	17, 0($0)	# Core-14345, clear L1 Dcache virtual
+				# tags if the core hit an NMI
+
+	ld	$k0, 0x78($k0)	# k0 <- (bfc00078) pointer to the reset vector
+	synci	0($0)		# Invalidate ICache to get coherent
+				# view of target code.
+
+	daddu	$k0, $k0, $k1
+	nop
+
+	ld	$k0, 0($k0)	# k0 <- core specific target address
+	dmfc0	$k1, $31, 3	# Restore $k1 from KScratch2
+
+	beqz	$k0, wait_loop	# Spin in wait loop
+	nop
+
+	jr	$k0
+	nop
+
+	nop			# NOPs needed here to fill delay slots
+	nop			# on endian reversal of previous instructions
+
+wait_loop:
+	wait
+	nop
+
+	b	wait_loop
+	nop
+
+	nop
+	nop
+------------------------------------
+
+0000000000000000 <reset_vector>:
+   0:	40baf800	dmtc0	k0,c0_desave
+   4:	40bbf803	dmtc0	k1,c0_kscratch2
+
+   8:	401a6000	mfc0	k0,c0_status
+   c:	401b7801	mfc0	k1,c0_ebase
+
+  10:	375a0084	ori	k0,k0,0x84
+  14:	337b03ff	andi	k1,k1,0x3ff
+
+  18:	409a6000	mtc0	k0,c0_status
+  1c:	001bd940	sll	k1,k1,0x5
+
+  20:	3c1abfc0	lui	k0,0xbfc0
+  24:	bc110000	cache	0x11,0(zero)
+
+  28:	df5a0078	ld	k0,120(k0)
+  2c:	041f0000	synci	0(zero)
+
+  30:	035bd02d	daddu	k0,k0,k1
+  34:	00000000	nop
+
+  38:	df5a0000	ld	k0,0(k0)
+  3c:	403bf803	dmfc0	k1,c0_kscratch2
+
+  40:	13400005	beqz	k0,58 <wait_loop>
+  44:	00000000	nop
+
+  48:	03400008	jr	k0
+  4c:	00000000	nop
+
+  50:	00000000	nop
+  54:	00000000	nop
+
+0000000000000058 <wait_loop>:
+  58:	42000020	wait
+  5c:	00000000	nop
+
+  60:	1000fffd	b	58 <wait_loop>
+  64:	00000000	nop
+
+  68:	00000000	nop
+  6c:	00000000	nop
+
+ */
+
+#include <asm/octeon/cvmx-boot-vector.h>
+
+static unsigned long long _cvmx_bootvector_data[16] = {
+	0x40baf80040bbf803ull,  /* patch low order 8-bits if no KScratch*/
+	0x401a6000401b7801ull,
+	0x375a0084337b03ffull,
+	0x409a6000001bd940ull,
+	0x3c1abfc0bc110000ull,
+	0xdf5a0078041f0000ull,
+	0x035bd02d00000000ull,
+	0xdf5a0000403bf803ull,  /* patch low order 8-bits if no KScratch*/
+	0x1340000500000000ull,
+	0x0340000800000000ull,
+	0x0000000000000000ull,
+	0x4200002000000000ull,
+	0x1000fffd00000000ull,
+	0x0000000000000000ull,
+	OCTEON_BOOT_MOVEABLE_MAGIC1,
+	0 /* To be filled in with address of vector block*/
+};
+
+/* 2^10 CPUs */
+#define VECTOR_TABLE_SIZE (1024 * sizeof(struct cvmx_boot_vector_element))
+
+static void cvmx_boot_vector_init(void *mem)
+{
+	uint64_t kseg0_mem;
+	int i;
+
+	memset(mem, 0, VECTOR_TABLE_SIZE);
+	kseg0_mem = cvmx_ptr_to_phys(mem) | 0x8000000000000000ull;
+
+	for (i = 0; i < 15; i++) {
+		uint64_t v = _cvmx_bootvector_data[i];
+
+		if (OCTEON_IS_OCTEON1PLUS() && (i == 0 || i == 7))
+			v &= 0xffffffff00000000ull; /* KScratch not availble. */
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, v);
+	}
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, 15 * 8);
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, kseg0_mem);
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
+}
+
+/**
+ * Get a pointer to the per-core table of reset vector pointers
+ *
+ */
+struct cvmx_boot_vector_element *cvmx_boot_vector_get(void)
+{
+	struct cvmx_boot_vector_element *ret;
+
+	ret = cvmx_bootmem_alloc_named_range_once(VECTOR_TABLE_SIZE, 0,
+		(1ull << 32) - 1, 8, "__boot_vector1__", cvmx_boot_vector_init);
+	return ret;
+}
+EXPORT_SYMBOL(cvmx_boot_vector_get);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 8d54d77..94d97eb 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -44,6 +44,55 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 
 /* See header file for descriptions of functions */
 
+/**
+ * This macro returns the size of a member of a structure.
+ * Logically it is the same as "sizeof(s::field)" in C++, but
+ * C lacks the "::" operator.
+ */
+#define SIZEOF_FIELD(s, field) sizeof(((s *)NULL)->field)
+
+/**
+ * This macro returns a member of the
+ * cvmx_bootmem_named_block_desc_t structure. These members can't
+ * be directly addressed as they might be in memory not directly
+ * reachable. In the case where bootmem is compiled with
+ * LINUX_HOST, the structure itself might be located on a remote
+ * Octeon. The argument "field" is the member name of the
+ * cvmx_bootmem_named_block_desc_t to read. Regardless of the type
+ * of the field, the return type is always a uint64_t. The "addr"
+ * parameter is the physical address of the structure.
+ */
+#define CVMX_BOOTMEM_NAMED_GET_FIELD(addr, field)			\
+	__cvmx_bootmem_desc_get(addr,					\
+		offsetof(struct cvmx_bootmem_named_block_desc, field),	\
+		SIZEOF_FIELD(struct cvmx_bootmem_named_block_desc, field))
+
+/**
+ * This function is the implementation of the get macros defined
+ * for individual structure members. The argument are generated
+ * by the macros inorder to read only the needed memory.
+ *
+ * @param base   64bit physical address of the complete structure
+ * @param offset Offset from the beginning of the structure to the member being
+ *               accessed.
+ * @param size   Size of the structure member.
+ *
+ * @return Value of the structure member promoted into a uint64_t.
+ */
+static inline uint64_t __cvmx_bootmem_desc_get(uint64_t base, int offset,
+					       int size)
+{
+	base = (1ull << 63) | (base + offset);
+	switch (size) {
+	case 4:
+		return cvmx_read64_uint32(base);
+	case 8:
+		return cvmx_read64_uint64(base);
+	default:
+		return 0;
+	}
+}
+
 /*
  * Wrapper functions are provided for reading/writing the size and
  * next block values as these may not be directly addressible (in 32
@@ -98,6 +147,42 @@ void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment)
 	return cvmx_bootmem_alloc_range(size, alignment, 0, 0);
 }
 
+void *cvmx_bootmem_alloc_named_range_once(uint64_t size, uint64_t min_addr,
+					  uint64_t max_addr, uint64_t align,
+					  char *name,
+					  void (*init) (void *))
+{
+	int64_t addr;
+	void *ptr;
+	uint64_t named_block_desc_addr;
+
+	named_block_desc_addr = (uint64_t)
+		cvmx_bootmem_phy_named_block_find(name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (named_block_desc_addr) {
+		addr = CVMX_BOOTMEM_NAMED_GET_FIELD(named_block_desc_addr,
+						    base_addr);
+		return cvmx_phys_to_ptr(addr);
+	}
+
+	addr = cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr,
+						  align, name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (addr < 0)
+		return NULL;
+	ptr = cvmx_phys_to_ptr(addr);
+
+	if (init)
+		init(ptr);
+	else
+		memset(ptr, 0, size);
+
+	return ptr;
+}
+EXPORT_SYMBOL(cvmx_bootmem_alloc_named_range_once);
+
 void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 				     uint64_t max_addr, uint64_t align,
 				     char *name)
diff --git a/arch/mips/include/asm/octeon/cvmx-boot-vector.h b/arch/mips/include/asm/octeon/cvmx-boot-vector.h
new file mode 100644
index 0000000..8db0824
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-boot-vector.h
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003-2017 Cavium, Inc.
+ */
+
+#ifndef __CVMX_BOOT_VECTOR_H__
+#define __CVMX_BOOT_VECTOR_H__
+
+#include <asm/octeon/octeon.h>
+
+/*
+ * The boot vector table is made up of an array of 1024 elements of
+ * struct cvmx_boot_vector_element.  There is one entry for each
+ * possible MIPS CPUNum, indexed by the CPUNum.
+ *
+ * Once cvmx_boot_vector_get() returns a non-NULL value (indicating
+ * success), NMI to a core will cause execution to transfer to the
+ * target_ptr location for that core's entry in the vector table.
+ *
+ * The struct cvmx_boot_vector_element fields app0, app1, and app2 can
+ * be used by the application that has set the target_ptr in any
+ * application specific manner, they are not touched by the vectoring
+ * code.
+ *
+ * The boot vector code clobbers the CP0_DESAVE register, and on
+ * OCTEON II and later CPUs also clobbers CP0_KScratch2.  All GP
+ * registers are preserved, except on pre-OCTEON II CPUs, where k1 is
+ * clobbered.
+ *
+ */
+
+
+/*
+ * Applications install the boot bus code in cvmx-boot-vector.c, which
+ * uses this magic:
+ */
+#define OCTEON_BOOT_MOVEABLE_MAGIC1 0xdb00110ad358eacdull
+
+struct cvmx_boot_vector_element {
+	/* kseg0 or xkphys address of target code. */
+	uint64_t target_ptr;
+	/* Three application specific arguments. */
+	uint64_t app0;
+	uint64_t app1;
+	uint64_t app2;
+};
+
+struct cvmx_boot_vector_element *cvmx_boot_vector_get(void);
+
+#endif /* __CVMX_BOOT_VECTOR_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 3745625..72d2e40 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -255,6 +255,34 @@ extern void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 					    uint64_t max_addr, uint64_t align,
 					    char *name);
 
+/**
+ * Allocate if needed a block of memory from a specific range of the
+ * free list that was passed to the application by the bootloader, and
+ * assign it a name in the global named block table.  (part of the
+ * cvmx_bootmem_descriptor_t structure) Named blocks can later be
+ * freed.  If the requested name block is already allocated, return
+ * the pointer to block of memory.  If request cannot be satisfied
+ * within the address range specified, NULL is returned
+ *
+ * @param size   Size in bytes of block to allocate
+ * @param min_addr  minimum address of range
+ * @param max_addr  maximum address of range
+ * @param align  Alignment of memory to be allocated. (must be a power of 2)
+ * @param name   name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ * @param init   Initialization function
+ *
+ * The initialization function is optional, if omitted the named block
+ * is initialized to all zeros when it is created, i.e. once.
+ *
+ * @return pointer to block of memory, NULL on error
+ */
+void *cvmx_bootmem_alloc_named_range_once(uint64_t size,
+					  uint64_t min_addr,
+					  uint64_t max_addr,
+					  uint64_t align,
+					  char *name,
+					  void (*init) (void *));
+
 extern int cvmx_bootmem_free_named(char *name);
 
 /**
-- 
2.1.4

