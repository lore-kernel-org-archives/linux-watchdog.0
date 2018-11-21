Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39182 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbeKVEDK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Nov 2018 23:03:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so6587854wmc.4
        for <linux-watchdog@vger.kernel.org>; Wed, 21 Nov 2018 09:27:52 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8916: Add PON watchdog node
Date: Wed, 21 Nov 2018 18:27:44 +0100
Message-Id: <1542821264-9200-3-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
References: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog child node to the PM8916 PON device.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: add timeout and interrupts

 arch/arm64/boot/dts/qcom/pm8916.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index a05ebaf..3230b88 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -32,6 +32,12 @@
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			watchdog {
+				compatible = "qcom,pm8916-wdt";
+				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
+				timeout-sec = <60>;
+			};
 		};
 
 		pm8916_gpios: gpios@c000 {
-- 
2.7.4
