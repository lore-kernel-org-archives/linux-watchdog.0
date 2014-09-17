Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:60189 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbaIQUM3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 16:12:29 -0400
Received: by mail-we0-f181.google.com with SMTP id w62so1955543wes.26
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Sep 2014 13:12:28 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 4/4] ARM: defconfig: update multi_v7_defconfig
Date: Wed, 17 Sep 2014 22:12:06 +0200
Message-Id: <1410984726-18944-5-git-send-email-carlo@caione.org>
In-Reply-To: <1410984726-18944-1-git-send-email-carlo@caione.org>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
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

