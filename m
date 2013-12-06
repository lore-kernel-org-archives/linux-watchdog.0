Return-Path: <l.krishna@samsung.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be
Cc: dianders@chromium.org, kgene.kim@samsung.com, t.figa@samsung.com,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, cpgs@samsung.com,
 linux@roeck-us.net
Subject: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
Date: Fri, 06 Dec 2013 11:17:46 +0530
Message-id: <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
In-reply-to: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
handle PMU register accesses in a centralized way using syscon driver

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
 arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
 3 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
new file mode 100644
index 0000000..f1f1552
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -0,0 +1,15 @@
+SAMSUNG Exynos SoC series PMU Registers
+
+Properties:
+ - compatible : should contain two values. First value must be one from following list:
+		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
+		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		second value must be always "syscon".
+
+ - reg : offset and length of the register set.
+
+Example :
+pmu_system_controller: system-controller@10040000 {
+	compatible = "samsung,exynos5250-pmu", "syscon";
+	reg = <0x10040000 0x5000>;
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b98ffc3..62f9e36 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -163,6 +163,11 @@
 		interrupts = <0 47 0>;
 	};
 
+	pmu_system_controller: system-controller@10040000 {
+		compatible = "samsung,exynos5250-pmu", "syscon";
+		reg = <0x10040000 0x5000>;
+	};
+
 	watchdog {
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b1fa334..cd47db0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -402,4 +402,9 @@
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
+
+	pmu_system_controller: system-controller@10040000 {
+		compatible = "samsung,exynos5420-pmu", "syscon";
+		reg = <0x10040000 0x5000>;
+	};
 };
-- 
1.7.10.4
