Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753075AbdH2PnC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:43:02 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 3/8] MIPS: Octeon: Watchdog registers for 70xx, 73xx, 78xx, F75xx.
Date: Tue, 29 Aug 2017 10:40:33 -0500
Message-Id: <1504021238-3184-4-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 0dd0e40..6e61792 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -128,6 +128,7 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
@@ -143,6 +144,10 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
+	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
 	}
 	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
@@ -180,6 +185,7 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
@@ -195,6 +201,10 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
+	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
 	}
 	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
-- 
2.1.4

