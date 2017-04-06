Return-path: <yannick.fertre@st.com>
From: Yannick Fertre <yannick.fertre@st.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob
 Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre
	<yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe
 Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/5] dt-bindings: watchdog: Document STM32 IWDG bindings
Date: Thu, 6 Apr 2017 14:19:24 +0200
Message-ID: <1491481168-22213-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This adds documentation of device tree bindings for the STM32 IWDG
(Independent WatchDoG).

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
new file mode 100644
index 0000000..cc13b10a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
@@ -0,0 +1,19 @@
+STM32 Independent WatchDoG (IWDG)
+---------------------------------
+
+Required properties:
+- compatible: "st,stm32-iwdg"
+- reg: physical base address and length of the registers set for the device
+- clocks: must contain a single entry describing the clock input
+
+Optional Properties:
+- timeout-sec: Watchdog timeout value in seconds.
+
+Example:
+
+iwdg: watchdog@40003000 {
+	compatible = "st,stm32-iwdg";
+	reg = <0x40003000 0x400>;
+	clocks = <&clk_lsi>;
+	timeout-sec = <32>;
+};
-- 
1.9.1
