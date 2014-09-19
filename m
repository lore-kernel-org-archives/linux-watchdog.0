Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:32947 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811AbaISUgv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 16:36:51 -0400
Received: by mail-we0-f180.google.com with SMTP id u56so324017wes.11
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Sep 2014 13:36:50 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 4/4] ARM: defconfig: update multi_v7_defconfig
Date: Fri, 19 Sep 2014 22:36:29 +0200
Message-Id: <1411158989-8075-5-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-1-git-send-email-carlo@caione.org>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Update the multi_v7_defconfig enabling the watchdog driver for Meson
SoCs.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5b44796..560e6a9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -242,6 +242,7 @@ CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
-- 
1.9.1

