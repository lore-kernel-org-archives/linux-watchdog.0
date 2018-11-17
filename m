Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36334 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeKQSon (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 17 Nov 2018 13:44:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id s11so714659wmh.1
        for <linux-watchdog@vger.kernel.org>; Sat, 17 Nov 2018 00:28:46 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: pm8916: Add PON watchdog node
Date: Sat, 17 Nov 2018 09:28:39 +0100
Message-Id: <1542443319-23369-3-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1542443319-23369-1-git-send-email-loic.poulain@linaro.org>
References: <1542443319-23369-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog child node to the PM8916 PON device.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index a05ebaf..4dfaf9b 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -25,6 +25,10 @@
 			mode-bootloader = <0x2>;
 			mode-recovery = <0x1>;
 
+			watchdog {
+				compatible = "qcom,pm8916-wdt";
+			};
+
 			pwrkey {
 				compatible = "qcom,pm8941-pwrkey";
 				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-- 
2.7.4
