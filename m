Return-Path: <loic.poulain@linaro.org>
Return-path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	andy.gross@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: pm8916: Add PON watchdog node
Date: Fri, 23 Nov 2018 09:44:38 +0100
Message-Id: <1542962678-13697-3-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1542962678-13697-1-git-send-email-loic.poulain@linaro.org>
References: <1542962678-13697-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Add watchdog child node to the PM8916 PON device.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Add interrupts and timeout-sec props
 v3: no change

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
