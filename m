Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v7 5/6] of: documentation: add bindings documentation for TS-4800
Date: Mon, 30 Nov 2015 10:59:50 -0500
Message-Id: <1448899191-13891-6-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

This adds the documentation for the TS-4800 by Technologic Systems.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
new file mode 100644
index 0000000..8422988
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -0,0 +1,6 @@
+Technologic Systems Platforms Device Tree Bindings
+--------------------------------------------------
+
+TS-4800 board
+Required root node properties:
+	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
-- 
2.5.0
