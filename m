Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35242 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752122AbaEEDaL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 4 May 2014 23:30:11 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>, wim@iguana.be, dbaryshkov@gmail.com,
	dwmw2@infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-sunxi@googlegroups.com,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 5/6] ARM: sunxi: Add A31 reset driver to sunxi_defconfig
Date: Sun,  4 May 2014 22:08:03 -0500
Message-Id: <1399259284-6282-6-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that the A31 reset code is a driver of its own, we need it in the
defconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 81ba78eaf54a..e0c91b23fde7 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -52,6 +52,9 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SUN6I=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
-- 
1.9.1

