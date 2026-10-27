Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088221;
	b=gwboiCGQztuxCvfiIiMGHLMUDRPnC9USYGH/45JQbyAXMJj/k7iLNPLlyW+Z63rdaDUa
	 XkXJ8xsqACYKfDoweaiLrLBZk4pgSy82woRXuhiOcSchzuf/CllzFanJ9PU63qcnLNfah
	 t5Ol4OgmaHDbLr57JNVQN5oZUrkFo4ACj6fils1b+FdCN4af9MdFOl3GdRt9FOqb9EOoV
	 AAFtNuXJRB9H1TXaOZHP9SWWsYR4EdSZj2pGWwVnecJGuWfiziaGuG5kdjHuNdb8yadsU
	 5b9bg1HuG4tD9j7GTSVa7t15zC0OfLQLvf+PW6QgMgYNClwsN5Bg5BWCdVxhPpvOWLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088221;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=R1R8DjkF1GUSBKkv0amCsM96AgRJpEzTdpc7j/awlcs=;
	b=rKt5wYxP5MLxuEI2Ck1WTNKTFy0ZokdfvqUnZVhyVQyVbfno1qeu8Cna/Fhl+n335OK6
	 zbiGrVIVp61pbMtUBNPuyNm8GqfO1u8IESjmpo55m+eYbqIN2mwCtRNF8Xta0eY1YoLWZ
	 tROGdrpy1oarQ9++tfA1vjxkAwbpJJGgWG3ZNE8nSpdS5rMk/E9FqIAGZH5s9mYOXUgGh
	 WqQGXuyGAhNHI3Ft0xu0SGEQP2iAivUePBUSI/7aF/Nu38mXRssa8r39HrgogE+1LC2s7
	 eCArVNA2QIz+jVgowmyqedyZIkxHdyZkKs0Cs0wt40l4NEFK772R8cTUBDT04N5HAdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=JwGkERLG;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298D606A33A;
	Tue, 27 Oct 2026 08:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7298D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=JwGkERLG
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1R8DjkF1GUSBKkv0amCsM96AgRJpEzTdpc7j/awlcs=;
	b=JwGkERLG+EBynwkpozOIyjBEqbJzHs2yR4I07aa3lCGEJhhASYkJ7vHbbuKOC3y0FTt2KH
	x5ccqfz6of64QaYHkfC1/TApcjN3mK37xq5NbGUD459kyaWzoDyJMMypS/iSGNOPvOnCPt
	3+9t0tJvUVVj9pt12IEC1oWaU7u9eRw=
Date: Tue, 27 Oct 2026 09:03:30 +0100
Subject: [PATCH 10/10] arm64: dts: apple: Add minimal t8142 (M5) device
 trees
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-10-1356181bc50d@cyberchaos.dev>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>

Added device trees for the following devices:
- apple,j704 - MacBook Pro (14-inch, M5, 2026)
- apple,j813 - MacBook Air (13-inch, M5, 2026)
- apple,j815 - MacBook Air (15-inch, M5, 2026)

The device trees have a minimal set of devices limited to CPU cores,
interrupt controller, watchdog, serial, pin controllers, i2c and
framebuffer.

Boot-tested on j704 with macOS 26.6 iBoot/firmware and the latest m1n1.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/Makefile        |    3 +
 arch/arm64/boot/dts/apple/t8142-j704.dts  |   36 +
 arch/arm64/boot/dts/apple/t8142-j813.dts  |   36 +
 arch/arm64/boot/dts/apple/t8142-j815.dts  |   36 +
 arch/arm64/boot/dts/apple/t8142-jxxx.dtsi |   50 ++
 arch/arm64/boot/dts/apple/t8142-pmgr.dtsi | 1131 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8142.dtsi      |  512 +++++++++++++
 7 files changed, 1804 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 12fc777405b3..933a299a9e01 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -116,3 +116,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t8132-j713.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8132-j715.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8132-j773g.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8140-j700.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8142-j704.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8142-j813.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8142-j815.dtb
diff --git a/arch/arm64/boot/dts/apple/t8142-j704.dts b/arch/arm64/boot/dts/apple/t8142-j704.dts
new file mode 100644
index 000000000000..ef8cc463f910
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142-j704.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Pro (14-inch, M5, 2026)
+ *
+ * target-type: J704
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8142.dtsi"
+#include "t8142-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Apple MacBook Pro (14-inch, M5, 2026)";
+	compatible = "apple,j704", "apple,t8142", "apple,arm-platform";
+
+	led-controller {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_WHITE>;
+			default-state = "keep";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			label = "kbd_backlight";
+			max-brightness = <255>;
+			pwms = <&fpwm0 0 40000>;
+		};
+	};
+};
+
+&fpwm0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8142-j813.dts b/arch/arm64/boot/dts/apple/t8142-j813.dts
new file mode 100644
index 000000000000..d956390403f9
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142-j813.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (13-inch, M5, 2026)
+ *
+ * target-type: J813
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8142.dtsi"
+#include "t8142-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Apple MacBook Air (13-inch, M5, 2026)";
+	compatible = "apple,j813", "apple,t8142", "apple,arm-platform";
+
+	led-controller {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_WHITE>;
+			default-state = "keep";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			label = "kbd_backlight";
+			max-brightness = <255>;
+			pwms = <&fpwm0 0 40000>;
+		};
+	};
+};
+
+&fpwm0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8142-j815.dts b/arch/arm64/boot/dts/apple/t8142-j815.dts
new file mode 100644
index 000000000000..cb326336c65b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142-j815.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (15-inch, M5, 2026)
+ *
+ * target-type: J815
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8142.dtsi"
+#include "t8142-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Apple MacBook Air (15-inch, M5, 2026)";
+	compatible = "apple,j815", "apple,t8142", "apple,arm-platform";
+
+	led-controller {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_WHITE>;
+			default-state = "keep";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			label = "kbd_backlight";
+			max-brightness = <255>;
+			pwms = <&fpwm0 0 40000>;
+		};
+	};
+};
+
+&fpwm0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8142-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8142-jxxx.dtsi
new file mode 100644
index 000000000000..9e19f61c1057
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142-jxxx.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M5 MacBook Air/Pro (M5, 2026)
+ *
+ * This file contains parts common to all Apple M5 devices using the t8142.
+ *
+ * target-type: J704, J813, J815
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		stdout-path = "serial0";
+
+		framebuffer@0 {
+			compatible = "apple,simple-framebuffer",
+			             "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp_fe>;
+			/* Format properties will be added by loader */
+
+			status = "disabled";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0x2 0>; /* To be filled by loader */
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		/* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8142-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8142-pmgr.dtsi
new file mode 100644
index 000000000000..b89c7720cf23
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142-pmgr.dtsi
@@ -0,0 +1,1131 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for Apple T8142 "M5" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pmgr {
+	ps_msg: power-controller@110 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		label = "msg";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_aic: power-controller@118 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		label = "aic";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		label = "gpio";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_awl: power-controller@138 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		label = "pms_awl";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pmc: power-controller@140 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		label = "pmc";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm0: power-controller@148 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		label = "pms_fpwm0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm1: power-controller@150 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		label = "pms_fpwm1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+
+		status = "disabled"; /* Locked, don't touch */
+	};
+
+	ps_pms_fpwm2: power-controller@158 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		label = "pms_fpwm2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm3: power-controller@160 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		label = "pms_fpwm3";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm4: power-controller@168 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		label = "pms_fpwm4";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_c1ppt: power-controller@170 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		label = "pms_c1ppt";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_soc_rc: power-controller@178 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		label = "soc_rc";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_soc_dpe: power-controller@180 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		label = "soc_dpe";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ispsens0: power-controller@190 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		label = "ispsens0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ispsens1: power-controller@198 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x198 4>;
+		label = "ispsens1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_global_aux_ctrl0: power-controller@1a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		label = "global_aux_ctrl0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_global_aux_ctrl1: power-controller@1a8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		label = "global_aux_ctrl1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ap_tmm: power-controller@1b0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		label = "ap_tmm";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_disp_sys: power-controller@290 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		label = "disp_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_venc_sys: power-controller@298 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		label = "venc_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_jpg: power-controller@2a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		label = "jpg";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_msr: power-controller@2a8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		label = "msr";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext1_sys: power-controller@2b8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		label = "dispext1_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_scodec: power-controller@2c0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		label = "scodec";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_common: power-controller@2c8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		label = "atc0_common";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_common: power-controller@2d0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		label = "atc1_common";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_common: power-controller@2d8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		label = "atc2_common";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_common: power-controller@2e0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		label = "atc3_common";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ane_sys: power-controller@2e8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		label = "ane_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_gp: power-controller@2f0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		label = "apcie_gp";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_isp_sys: power-controller@2f8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		label = "isp_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ans: power-controller@300 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		label = "ans";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on; /* Device reboots after 3-5 mintues if disabled */
+	};
+
+	ps_dispext0_sys: power-controller@308 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		label = "dispext0_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_avd_sys: power-controller@310 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		label = "avd_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_disp_fe: power-controller@318 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x318 4>;
+		label = "disp_fe";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_disp_sys>;
+		#reset-cells = <0>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_msr_ase_core: power-controller@320 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		label = "msr_ase_core";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_msr>;
+		#reset-cells = <0>;
+	};
+
+	ps_sio_cpu: power-controller@328 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x328 4>;
+		label = "sio_cpu";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_fpwm0: power-controller@330 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		label = "fpwm0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_fpwm2: power-controller@340 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		label = "fpwm2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c0: power-controller@348 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		label = "i2c0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c1: power-controller@350 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x350 4>;
+		label = "i2c1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c2: power-controller@358 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x358 4>;
+		label = "i2c2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c3: power-controller@360 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		label = "i2c3";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c4: power-controller@368 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x368 4>;
+		label = "i2c4";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c5: power-controller@370 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		label = "i2c5";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c6: power-controller@378 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		label = "i2c6";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c7: power-controller@380 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		label = "i2c7";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c8: power-controller@388 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		label = "i2c8";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi_p: power-controller@390 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		label = "spi_p";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart_p: power-controller@398 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		label = "uart_p";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_aes: power-controller@3a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		label = "aes";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext1_fe: power-controller@3a8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		label = "dispext1_fe";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext1_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext1_adma: power-controller@3b0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		label = "dispext1_adma";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext1_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext1_cpu: power-controller@3b8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		label = "dispext1_cpu";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext1_fe>;
+		#reset-cells = <0>;
+
+		status = "disabled"; /* Locked, don't touch */
+	};
+
+	ps_scodec_streaming: power-controller@3c0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		label = "scodec_streaming";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_scodec>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_pcie: power-controller@3c8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c8 4>;
+		label = "atc0_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_cio: power-controller@3d0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		label = "atc0_cio";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_pcie: power-controller@3d8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		label = "atc1_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc1_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_cio: power-controller@3e0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		label = "atc1_cio";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc1_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_pcie: power-controller@3e8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		label = "atc2_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc2_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_cio: power-controller@3f0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		label = "atc2_cio";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc2_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_pcie: power-controller@3f8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		label = "atc3_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc3_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_cio: power-controller@400 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x400 4>;
+		label = "atc3_cio";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc3_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_sys_gp: power-controller@408 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x408 4>;
+		label = "apcie_sys_gp";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_gp>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_st: power-controller@410 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x410 4>;
+		label = "apcie_st";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ans>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext0_fe: power-controller@418 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x418 4>;
+		label = "dispext0_fe";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext0_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext0_adma: power-controller@420 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x420 4>;
+		label = "dispext0_adma";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext0_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext0_cpu: power-controller@428 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x428 4>;
+		label = "dispext0_cpu";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext0_fe>;
+		#reset-cells = <0>;
+
+		status = "disabled"; /* Locked, don't touch */
+	};
+
+	ps_spi0: power-controller@430 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x430 4>;
+		label = "spi0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi1: power-controller@438 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x438 4>;
+		label = "spi1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi2: power-controller@440 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x440 4>;
+		label = "spi2";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi3: power-controller@448 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x448 4>;
+		label = "spi3";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi4: power-controller@450 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x450 4>;
+		label = "spi4";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi5: power-controller@458 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x458 4>;
+		label = "spi5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_qspi: power-controller@460 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x460 4>;
+		label = "qspi";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart_n: power-controller@468 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x468 4>;
+		label = "uart_n";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart0: power-controller@470 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x470 4>;
+		label = "uart0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart1: power-controller@478 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x478 4>;
+		label = "uart1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart2: power-controller@480 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x480 4>;
+		label = "uart2";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart3: power-controller@488 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x488 4>;
+		label = "uart3";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart4: power-controller@490 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x490 4>;
+		label = "uart4";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart5: power-controller@498 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x498 4>;
+		label = "uart5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart6: power-controller@4a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		label = "uart6";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@4d8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d8 4>;
+		label = "atc0_cio_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_cio_usb: power-controller@4e0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e0 4>;
+		label = "atc0_cio_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@4e8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e8 4>;
+		label = "atc1_cio_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc1_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_cio_usb: power-controller@4f0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f0 4>;
+		label = "atc1_cio_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc1_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_cio_pcie: power-controller@4f8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f8 4>;
+		label = "atc2_cio_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc2_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_cio_usb: power-controller@500 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x500 4>;
+		label = "atc2_cio_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc2_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_cio_pcie: power-controller@508 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x508 4>;
+		label = "atc3_cio_pcie";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc3_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_cio_usb: power-controller@510 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x510 4>;
+		label = "atc3_cio_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc3_cio>;
+		#reset-cells = <0>;
+	};
+
+	ps_sys_gp_ocla: power-controller@518 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x518 4>;
+		label = "sys_gp_ocla";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_sys_gp>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_sys_st: power-controller@520 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x520 4>;
+		label = "apcie_sys_st";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ans>, <&ps_apcie_st>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_phy_sw: power-controller@560 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x560 4>;
+		label = "apcie_phy_sw";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
+		#reset-cells = <0>;
+	};
+
+	ps_sys_st_ocla: power-controller@568 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x568 4>;
+		label = "sys_st_ocla";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_sys_st>;
+		#reset-cells = <0>;
+	};
+
+	ps_st0_aus5_aon: power-controller@578 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x578 4>;
+		label = "st0_aus5_aon";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_phy_sw>;
+		#reset-cells = <0>;
+	};
+
+	ps_st0_aus5: power-controller@580 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x580 4>;
+		label = "st0_aus5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_st0_aus5_aon>;
+		#reset-cells = <0>;
+	};
+
+	ps_pmp: power-controller@598 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x598 4>;
+		label = "pmp";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_sram: power-controller@5a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a0 4>;
+		label = "pms_sram";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		label = "sep";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		label = "venc_dma";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		label = "venc_pipe4";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		label = "venc_pipe5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		label = "venc_me0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		label = "venc_me1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc_me0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ane_cpu: power-controller@c000 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc000 4>;
+		label = "ane_cpu";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ane_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_ane_tdbase: power-controller@c008 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc008 4>;
+		label = "ane_tdbase";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ane_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_ane_mpm: power-controller@c010 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc010 4>;
+		label = "ane_mpm";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ane_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_disp_cpu: power-controller@10000 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x10000 4>;
+		label = "disp_cpu";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_disp_fe>;
+		#reset-cells = <0>;
+
+		status = "disabled"; /* Locked, don't touch */
+	};
+
+	ps_disp_adma: power-controller@10068 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x10068 4>;
+		label = "disp_adma";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_disp_sys>;
+		#reset-cells = <0>;
+	};
+};
+
+&pmgr_mini {
+	ps_debug_gated: power-controller@58 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		label = "debug_gated";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@60 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		label = "nub_spmi0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@68 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		label = "nub_spmi1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@70 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x70 4>;
+		label = "nub_spmi_a0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a1: power-controller@78 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		label = "nub_spmi_a1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_aon_nogate: power-controller@88 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		label = "nub_aon_nogate";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_dock_ch: power-controller@98 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x98 4>;
+		label = "nub_dock_ch";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_awl: power-controller@a0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		label = "nub_awl";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@a8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		label = "nub_gpio";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@c8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc8 4>;
+		label = "atc0_usb_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_usb: power-controller@d0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd0 4>;
+		label = "atc0_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_common>, <&ps_atc0_usb_aon>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_usb_aon: power-controller@d8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd8 4>;
+		label = "atc1_usb_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc1_usb: power-controller@e0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe0 4>;
+		label = "atc1_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc1_common>, <&ps_atc1_usb_aon>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_usb_aon: power-controller@e8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe8 4>;
+		label = "atc2_usb_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc2_usb: power-controller@f0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xf0 4>;
+		label = "atc2_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc2_common>, <&ps_atc2_usb_aon>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_usb_aon: power-controller@f8 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xf8 4>;
+		label = "atc3_usb_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc3_usb: power-controller@100 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		label = "atc3_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc3_common>, <&ps_atc3_usb_aon>;
+		#reset-cells = <0>;
+	};
+};
+
+&pmgr_gfx {
+	ps_gpx: power-controller@0 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		label = "gpx";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_gfx: power-controller@110 {
+		compatible = "apple,t8142-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		label = "gfx";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8142.dtsi b/arch/arm64/boot/dts/apple/t8142.dtsi
new file mode 100644
index 000000000000..3663677f7b14
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8142.dtsi
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8142 "M5" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	compatible = "apple,t8142", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+
+				core4 {
+					cpu = <&cpu_e4>;
+				};
+
+				core5 {
+					cpu = <&cpu_e5>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+
+				core2 {
+					cpu = <&cpu_p2>;
+				};
+
+				core3 {
+					cpu = <&cpu_p3>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e1: cpu@1 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e2: cpu@2 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e3: cpu@3 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x3>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e4: cpu@4 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x4>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e5: cpu@5 {
+			device_type = "cpu";
+			compatible = "apple,hidra-e";
+			reg = <0x0 0x5>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_p0: cpu@10100 {
+			device_type = "cpu";
+			compatible = "apple,hidra-p";
+			reg = <0x0 0x10100>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p1: cpu@10101 {
+			device_type = "cpu";
+			compatible = "apple,hidra-p";
+			reg = <0x0 0x10101>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p2: cpu@10102 {
+			device_type = "cpu";
+			compatible = "apple,hidra-p";
+			reg = <0x0 0x10102>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p3: cpu@10103 {
+			device_type = "cpu";
+			compatible = "apple,hidra-p";
+			reg = <0x0 0x10103>;
+			cpu-release-addr = <0 0>;
+			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x600000>;
+			cache-unified;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x1000000>;
+			cache-unified;
+		};
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <2>;
+		nonposted-mmio;
+		#size-cells = <2>;
+
+		pmgr: power-management@380700000 {
+			compatible = "apple,t8142-pmgr", "apple,t8103-pmgr",
+			             "syscon", "simple-mfd";
+			reg = <0x3 0x80700000 0 0x14000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* child nodes are added in t8142-pmgr.dtsi */
+		};
+
+		aic: interrupt-controller@381000000 {
+			compatible = "apple,t8142-aic3", "apple,t8122-aic3";
+			reg = <0x3 0x81000000 0x0 0x1cc000>,
+			      <0x3 0x81040000 0x0 0x4000>;
+			reg-names = "core", "event";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2
+					        &cpu_e3 &cpu_e4 &cpu_e5>;
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+				};
+
+				p-core-pmu-affinity {
+					cpus = <&cpu_p0 &cpu_p1
+					        &cpu_p2 &cpu_p3>;
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+				};
+			};
+		};
+
+		pinctrl_nub: pinctrl@3881f0000 {
+			compatible = "apple,t8142-pinctrl",
+			             "apple,t8140-pinctrl";
+			reg = <0x3 0x881f0000 0x0 0x4000>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl_nub 0 0 40>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 574 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 575 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 576 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 577 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 578 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 579 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 580 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&ps_nub_gpio>;
+			apple,npins = <40>;
+		};
+
+		pmgr_mini: power-management@388280000 {
+			compatible = "apple,t8142-pmgr", "apple,t8103-pmgr",
+			             "syscon", "simple-mfd";
+			reg = <0x3 0x88280000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* child nodes are added in t8142-pmgr.dtsi */
+		};
+
+		wdt: watchdog@3882b0000 {
+			compatible = "apple,t8142-wdt", "apple,t8103-wdt";
+			reg = <0x3 0x882b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 507 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@38c820000 {
+			compatible = "apple,t8142-pinctrl",
+			             "apple,t8140-pinctrl";
+			reg = <0x3 0x8c820000 0x0 0x4000>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl_smc 0 0 18>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 624 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 625 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 627 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 628 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 629 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 630 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <18>;
+		};
+
+		pinctrl_aop: pinctrl@390824000 {
+			compatible = "apple,t8142-pinctrl",
+			             "apple,t8140-pinctrl";
+			reg = <0x3 0x90824000 0x0 0x4000>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl_aop 0 0 77>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 480 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 481 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 482 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 483 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 484 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 485 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 486 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <77>;
+		};
+
+		pinctrl_ap: pinctrl@39a000000 {
+			compatible = "apple,t8142-pinctrl",
+			             "apple,t8140-pinctrl";
+			reg = <0x3 0x9a000000 0x0 0x100000>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl_ap 0 0 224>;
+			gpio-reserved-ranges = <78 1>, <203 1>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 347 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 348 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 349 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 350 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 351 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 352 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 353 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&ps_gpio>;
+			apple,npins = <224>;
+
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(106, 1)>,
+				         <APPLE_PINMUX(105, 1)>;
+			};
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(108, 1)>,
+				         <APPLE_PINMUX(107, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(45, 1)>,
+				         <APPLE_PINMUX(44, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(43, 1)>,
+				         <APPLE_PINMUX(42, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(110, 1)>,
+				         <APPLE_PINMUX(109, 1)>;
+			};
+		};
+
+		i2c0: i2c@3a5010000 {
+			compatible = "apple,t8142-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xa5010000 0x0 0x4000>;
+
+			#address-cells = <0x1>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1062 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_i2c0>;
+			#size-cells = <0x0>;
+
+			status = "disabled";
+		};
+
+		i2c1: i2c@3a5014000 {
+			compatible = "apple,t8142-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xa5014000 0x0 0x4000>;
+
+			#address-cells = <0x1>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1063 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_i2c1>;
+			#size-cells = <0x0>;
+
+			status = "disabled";
+		};
+
+		i2c2: i2c@3a5018000 {
+			compatible = "apple,t8142-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xa5018000 0x0 0x4000>;
+
+			#address-cells = <0x1>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1064 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_i2c2>;
+			#size-cells = <0x0>;
+
+			status = "disabled";
+		};
+
+		i2c3: i2c@3a501c000 {
+			compatible = "apple,t8142-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xa501c000 0x0 0x4000>;
+
+			#address-cells = <0x1>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1065 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_i2c3>;
+			#size-cells = <0x0>;
+
+			status = "disabled";
+		};
+
+		i2c4: i2c@3a5020000 {
+			compatible = "apple,t8142-i2c", "apple,t8103-i2c";
+			reg = <0x3 0xa5020000 0x0 0x4000>;
+
+			#address-cells = <0x1>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1066 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_i2c4>;
+			#size-cells = <0x0>;
+
+			status = "disabled";
+		};
+
+		fpwm0: pwm@3a5040000 {
+			compatible = "apple,t8142-fpwm", "apple,s5l-fpwm";
+			reg = <0x3 0xa5040000 0x0 0x4000>;
+
+			clocks = <&clkref>;
+			power-domains = <&ps_fpwm0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		serial0: serial@3a5200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3 0xa5200000 0x0 0x1000>;
+
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1231 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_uart0>;
+			reg-io-width = <4>;
+
+			status = "disabled";
+		};
+
+		pmgr_gfx: power-management@580e80000 {
+			compatible = "apple,t8142-pmgr", "apple,t8103-pmgr",
+			             "syscon", "simple-mfd";
+			reg = <0x5 0x80e80000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+	};
+};
+
+#include "t8142-pmgr.dtsi"

-- 
2.56.0

