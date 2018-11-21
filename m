Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36820 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeKVEDI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Nov 2018 23:03:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so6601386wmh.1
        for <linux-watchdog@vger.kernel.org>; Wed, 21 Nov 2018 09:27:50 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: watchdog: Add Qualcomm PM8916 watchdog
Date: Wed, 21 Nov 2018 18:27:43 +0100
Message-Id: <1542821264-9200-2-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
References: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document support for the Watchdog Timer (WDT) Controller in the
Qualcomm PM8916 PMIC module.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Add interrupts and timeout-sec props

 .../bindings/watchdog/qcom,pm8916-wdt.txt          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
new file mode 100644
index 0000000..8a0d304
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
@@ -0,0 +1,29 @@
+QCOM PM8916 watchdog timer controller
+
+This pm8916 watchdog timer controller must be under pm8916-pon node.
+
+Required properties:
+- compatible: should be "qcom,pm8916-wdt"
+
+Optional properties :
+- interrupts : interrupt for pre-timeout (bark)
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+                if unset, the default timeout is 30 seconds
+
+Example:
+
+	pm8916_0: pm8916@0 {
+		compatible = "qcom,pm8916", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+
+		pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
+
+			watchdog {
+				compatible = "qcom,pm8916-wdt";
+				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
+				timeout-sec = <10>;
+			};
+		};
+	};
-- 
2.7.4
