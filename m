Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39389 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754006AbdIDXQI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Sep 2017 19:16:08 -0400
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: watchdog: Add Realtek RTD1295
Date: Tue,  5 Sep 2017 01:16:00 +0200
Message-Id: <20170904231602.29787-2-afaerber@suse.de>
In-Reply-To: <20170904231602.29787-1-afaerber@suse.de>
References: <20170904231602.29787-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a binding for the Realtek RTD1295 watchdog.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 
 .../devicetree/bindings/watchdog/realtek,rtd119x.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt

diff --git a/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
new file mode 100644
index 000000000000..05653054bd5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
@@ -0,0 +1,17 @@
+Realtek RTD1295 Watchdog
+========================
+
+Required properties:
+
+- compatible :  Should be "realtek,rtd1295-watchdog"
+- reg        :  Specifies the physical base address and size of registers
+- clocks     :  Specifies one clock input
+
+
+Example:
+
+	watchdog@98007680 {
+		compatible = "realtek,rtd1295-watchdog";
+		reg = <0x98007680 0x100>;
+		clocks = <&osc27M>;
+	};
-- 
2.13.5

