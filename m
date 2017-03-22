Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22079 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934855AbdCVOOY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Mar 2017 10:14:24 -0400
From: Yannick Fertre <yannick.fertre@st.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/5] ARM: configs: Add watchdog support in STM32 defconfig
Date: Wed, 22 Mar 2017 15:12:54 +0100
Message-ID: <1490191974-29722-6-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
References: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds STM32 watchdog support in stm32_defconfig file

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..83afa73 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -48,6 +48,7 @@ CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
-- 
1.9.1

