Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47816 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeEBJn7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 May 2018 05:43:59 -0400
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable RENESAS_WDT
Date: Wed,  2 May 2018 11:43:53 +0200
Message-Id: <20180502094353.27488-1-horms+renesas@verge.net.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
its driver by default. It is enabled as a module to avoid increasing
the kernel image size.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c6042475bece..374a40945b0f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -498,6 +498,7 @@ CONFIG_TEGRA_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
+CONFIG_RENESAS_WDT=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM47XX_WDT=y
 CONFIG_BCM7038_WDT=m
-- 
2.11.0

