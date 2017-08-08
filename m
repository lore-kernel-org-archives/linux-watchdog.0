Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58480 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdHHWx1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 Aug 2017 18:53:27 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v9 06/16] MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
Date: Wed,  9 Aug 2017 00:52:37 +0200
Message-Id: <20170808225247.32266-7-hauke@hauke-m.de>
In-Reply-To: <20170808225247.32266-1-hauke@hauke-m.de>
References: <20170808225247.32266-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 177769dbb0e8..f5db4a426568 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -17,6 +17,7 @@ config SOC_XWAY
 	bool "XWAY"
 	select SOC_TYPE_XWAY
 	select HW_HAS_PCI
+	select MFD_SYSCON
 
 config SOC_FALCON
 	bool "FALCON"
-- 
2.11.0

