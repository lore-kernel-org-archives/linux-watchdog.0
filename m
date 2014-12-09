Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:42560 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653AbaLILW5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Dec 2014 06:22:57 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig
Date: Tue,  9 Dec 2014 12:22:49 +0100
Message-Id: <1418124169-7123-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This allows to restart koelsch on watchdog timeout or manual system
restart request.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Restart by watchdog timeout is working now.
Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
handler support".
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index dfc1efcb4a866ef3..5863128b06be8551 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -106,6 +106,9 @@ CONFIG_GPIO_RCAR=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_RCAR_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=y
+CONFIG_MFD_DA9063=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
-- 
1.9.1

