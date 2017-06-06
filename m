Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:20163 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbdFFJLo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 05:11:44 -0400
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        yamada.masahiro@socionext.com, hayashi.kunihiko@socionext.com,
        owada.kiyoshi@socionext.com,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH V2 1/3] devicetree: add UniPhier WDT devicetree bindings documentation
Date: Tue,  6 Jun 2017 18:11:32 +0900
Message-Id: <1496740294-12653-2-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add uniphier-wdt bindings documentation.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 .../devicetree/bindings/watchdog/uniphier-wdt.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
new file mode 100644
index 0000000..a59d1ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
@@ -0,0 +1,20 @@
+UniPhier watchdog timer controller
+
+This UniPhier watchdog timer controller must be under sysctrl compatible node.
+
+Required properties:
+- compatible: should be "socionext,uniphier-wdt"
+
+Example:
+
+	sysctrl@61840000 {
+		compatible = "socionext,uniphier-ld11-sysctrl",
+			     "simple-mfd", "syscon";
+		reg = <0x61840000 0x4000>;
+
+		sys_wdt: watchdog {
+			compatible = "socionext,uniphier-wdt";
+		}
+
+		other nodes ...
+	};
-- 
2.7.4

