Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28910 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934656AbdCVNiD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Mar 2017 09:38:03 -0400
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
Subject: [PATCH v1 4/5] ARM: dts: stm32ap: Add watchdog support for STM32F429 eval board
Date: Wed, 22 Mar 2017 14:36:25 +0100
Message-ID: <1490189786-19232-5-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
References: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 3c99466..aab81ed 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -181,3 +181,7 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&iwdg {
+	status = "okay";
+};
-- 
1.9.1

