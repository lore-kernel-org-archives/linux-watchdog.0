Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753075AbdH2PnE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:43:04 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 5/8] MIPS: Octeon: Allow access to CIU3 IRQ domains.
Date: Tue, 29 Aug 2017 10:40:35 -0500
Message-Id: <1504021238-3184-6-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Add accessor function octeon_irq_get_block_domain() for cores
with a CIU3.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c  | 9 +++++++++
 arch/mips/include/asm/octeon/octeon.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index c1eb1ff..5b3a3f6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2963,3 +2963,12 @@ void octeon_fixup_irqs(void)
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
+
+struct irq_domain *octeon_irq_get_block_domain(int node, uint8_t block)
+{
+	struct octeon_ciu3_info *ciu3_info;
+
+	ciu3_info = octeon_ciu3_info_per_node[node & CVMX_NODE_MASK];
+	return ciu3_info->domain[block];
+}
+EXPORT_SYMBOL(octeon_irq_get_block_domain);
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 07c0516..c99c4b6 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -362,4 +362,6 @@ extern void octeon_fixup_irqs(void);
 
 extern struct semaphore octeon_bootbus_sem;
 
+struct irq_domain *octeon_irq_get_block_domain(int node, uint8_t block);
+
 #endif /* __ASM_OCTEON_OCTEON_H */
-- 
2.1.4

