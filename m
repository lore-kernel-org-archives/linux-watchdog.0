Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58188 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbcDAL4h (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Apr 2016 07:56:37 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: defconfig: enable Renesas Watchdog Timer
Date: Fri,  1 Apr 2016 13:56:26 +0200
Message-Id: <1459511786-4286-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f78360c08c1eca..795d40e810ff95 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -168,6 +168,8 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_RENESAS_WDT=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR=y
-- 
2.7.0

