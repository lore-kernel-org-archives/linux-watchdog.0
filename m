Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:4435 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab3KSTIn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Nov 2013 14:08:43 -0500
From: "Markus Mayer" <markus.mayer@linaro.org>
To: "Wim Van Sebroeck" <wim@iguana.be>,
	"Guenter Roeck" <linux@roeck-us.net>,
	"Christian Daudt" <bcm@fixthebug.org>
cc: "Linaro Patches" <patches@linaro.org>,
	"Matt Porter" <matt.porter@linaro.org>,
	"One Thousand Gnomes" <gnomes@lxorguk.ukuu.org.uk>,
	"Linux Watchdog List" <linux-watchdog@vger.kernel.org>,
	"ARM Kernel List" <linux-arm-kernel@lists.infradead.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Markus Mayer" <markus.mayer@linaro.org>
Subject: [PATCH v4 2/2] ARM: bcm281xx: watchdog configuration
Date: Tue, 19 Nov 2013 11:07:54 -0800
Message-ID: <1384888074-19696-3-git-send-email-markus.mayer@linaro.org>
In-Reply-To: <1384888074-19696-1-git-send-email-markus.mayer@linaro.org>
References: <1384888074-19696-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit enables the watchdog driver for the BCM281xx family of SoCs.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/configs/bcm_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 6e49310..8b98e11 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -130,3 +130,6 @@ CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_XZ_DEC=y
 CONFIG_AVERAGE=y
+CONFIG_WATCHDOG=y
+CONFIG_BCM_KONA_WDT=y
+CONFIG_BCM_KONA_WDT_DEBUG=y
-- 
1.7.9.5


