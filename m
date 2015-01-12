Return-path: <matthias.bgg@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
To: wim@iguana.be,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	grant.likely@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	heiko@sntech.de,
	yingjoe.chen@gmail.com,
	ibanezchen@gmail.com,
	matthias.bgg@gmail.com,
	greta.zhang@mediatek.com,
	eddie.huang@mediatek.com,
	wens@csie.org,
	linux@roeck-us.net,
	joe@perches.com
Subject: [PATCH v4 2/2] ARM: mediatek: dts: Add bindings for watchdog
Date: Mon, 12 Jan 2015 16:34:44 +0100
Message-Id: <1421076884-15860-3-git-send-email-matthias.bgg@gmail.com>
In-Reply-To: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
new file mode 100644
index 0000000..af9eb5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -0,0 +1,13 @@
+Mediatek SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "mediatek,mt6589-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog@010000000 {
+	compatible = "mediatek,mt6589-wdt";
+	reg = <0x10000000 0x18>;
+};
-- 
1.9.1
