Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752992AbdH2PnD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:43:03 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 4/8] MIPS: Octeon: Make CSR functions node aware.
Date: Tue, 29 Aug 2017 10:40:34 -0500
Message-Id: <1504021238-3184-5-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Updates CSR read/write functions to be aware of nodes present in
systems with CIU3 support.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index e638735..205ab2c 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -357,6 +357,34 @@ static inline unsigned int cvmx_get_local_core_num(void)
 	return cvmx_get_core_num() & ((1 << CVMX_NODE_NO_SHIFT) - 1);
 }
 
+#define CVMX_NODE_BITS         (2)     /* Number of bits to define a node */
+#define CVMX_MAX_NODES         (1 << CVMX_NODE_BITS)
+#define CVMX_NODE_IO_SHIFT     (36)
+#define CVMX_NODE_MEM_SHIFT    (40)
+#define CVMX_NODE_IO_MASK      ((uint64_t)CVMX_NODE_MASK << CVMX_NODE_IO_SHIFT)
+
+static inline void cvmx_write_csr_node(uint64_t node, uint64_t csr_addr,
+				       uint64_t val)
+{
+	uint64_t composite_csr_addr, node_addr;
+
+	node_addr = (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+	composite_csr_addr = (csr_addr & ~CVMX_NODE_IO_MASK) | node_addr;
+
+	cvmx_write64_uint64(composite_csr_addr, val);
+	if (((csr_addr >> 40) & 0x7ffff) == (0x118))
+		cvmx_read64_uint64(CVMX_MIO_BOOT_BIST_STAT | node_addr);
+}
+
+static inline uint64_t cvmx_read_csr_node(uint64_t node, uint64_t csr_addr)
+{
+	uint64_t node_addr;
+
+	node_addr = (csr_addr & ~CVMX_NODE_IO_MASK) |
+		    (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+	return cvmx_read_csr(node_addr);
+}
+
 /**
  * Returns the number of bits set in the provided value.
  * Simple wrapper for POP instruction.
-- 
2.1.4

