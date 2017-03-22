Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36294 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935030AbdCVPGB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Mar 2017 11:06:01 -0400
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
Subject: [PATCH v3 1/5] dt-bindings: Document STM32 IWDG bindings
Date: Wed, 22 Mar 2017 16:04:39 +0100
Message-ID: <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Yannick Fertre <yfertre.stm32@gmail.com>

This adds documentation of device tree bindings for the STM32 IWDG
(Independent WatchDoG).

Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558
Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
new file mode 100644
index 0000000..036b040
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -0,0 +1,15 @@
+STM32 Independent WatchDoG (IWDG)
+---------------------------------
+
+Required properties:
+- compatible: "st,stm32-iwdg"
+- reg: physical base address and length of the registers set for the device
+- clocks: must contain a single entry describing the clock input
+
+Example:
+
+iwdg@40003000 {
+	compatible = "st,stm32-iwdg";
+	reg = <0x40003000 0x400>;
+	clocks = <&clk_lsi>;
+};
-- 
1.9.1

