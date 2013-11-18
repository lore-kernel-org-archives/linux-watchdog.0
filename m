Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22715 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab3KRJaI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Nov 2013 04:30:08 -0500
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org, linux@roeck-us.net
Subject: [PATCH V9 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
Date: Mon, 18 Nov 2013 15:19:47 +0530
Message-id: <1384768189-2839-2-git-send-email-l.krishna@samsung.com>
In-reply-to: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
handle PMU register accesses in a centralized way using syscon driver

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
 arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
 3 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
new file mode 100644
index 0000000..307e727
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -0,0 +1,16 @@
+SAMSUNG Exynos SoC series PMU Registers
+
+Properties:
+ - name : should be 'syscon';
+ - compatible : should contain two values. First value must be one from following list:
+		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
+		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		second value must be always "syscon".
+
+ - reg : offset and length of the register set.
+
+Example :
+pmu_syscon: syscon@10040000 {
+	compatible = "samsung,exynos5250-pmu", "syscon";
+	reg = <0x10040000 0x5000>;
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index c4a8662..6056a83 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -158,6 +158,11 @@
 		interrupts = <0 47 0>;
 	};
 
+	pmu_syscon: syscon@10040000 {
+		compatible = "samsung,exynos5250-pmu", "syscon";
+		reg = <0x10040000 0x5000>;
+	};
+
 	watchdog {
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 6ffefd1..39ce15a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -369,4 +369,9 @@
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
+
+	pmu_syscon: syscon@10040000 {
+		compatible = "samsung,exynos5420-pmu", "syscon";
+		reg = <0x10040000 0x5000>;
+	};
 };
-- 
1.7.10.4

