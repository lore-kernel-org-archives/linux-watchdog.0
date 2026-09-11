Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB04A5EA8;
	Fri, 11 Sep 2026 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145969; cv=none; b=D8m5gjC4j8/NW0ntRVgOP2fpbRkLKpGzKSYFuROiTIeevF5xT+UlbWqlMzCFZ7vZhGbHffbSpQ6t74Vs+LokDxoWRUDpq5pPpIegYoEyKjwRh2YB1dHwI/vu8bkfW8lUZKZ7npOX0PmeBgXRDY8ivz+29j2j/6lRGzCmjgyBET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145969; c=relaxed/simple;
	bh=orbFqWCYx6BVu/cxBBrD5OpuIgbGYEayn2hOEnNLU/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQuuDFbuVKxq3EJKyR6qHTUuaJ0R1C2RgPtO1khadRa2X8EiPOv7DANPD5EWcMAeV6uddUvrGMZDqnoNlIumJ9THBSs6RPytI1t1eH5rdQqW80CXBV90xuZYkWiTSXNi0nFQJjL3CuXGIG5hGjk3eu/QOscc6rtSU59ANG0HDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=Ykte0YaZ; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="Ykte0YaZ"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fhviTU5QVUP0OJ0YKEIWmBRz83Jwby6aVLM0ywJygY=;
	b=Ykte0YaZBT8fUla3SBhhgX8tEL+m4wdUetS0EsYVOhgyhQXnggxFcIgtk4RhDiqL5OSxor
	naokARm9FdyEGvkUX0QH9NNYGqE0q9VfxACJbQ36BP/ValjF8+C5BJnJmedhLYa4HAbm8u
	8/pZ9Sfw2SdcXxiTLKtoVvS2kbWSpW8=
Date: Fri, 11 Sep 2026 18:58:44 +0200
Subject: [PATCH v2 7/7] arm64: dts: apple: Add minimal MacBook Neo device
 tree
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-7-08d06cf011d4@cyberchaos.dev>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Added a device tree for the MacBook Neo, which uses the t8140 SoC
(A18 Pro) also found in the iPhone 16 Pro.

The device tree has a minimal set of devices limited to CPU cores,
interrupt controller, watchdog, serial and framebuffer.

Using the macOS 26.6.2 iBoot/firmware, the machine reliably boots
on a single core using the stock kernel.
Booting with smp requires avoiding the wfi and wfit instructions
in the idle loop and `delay()` respectively, since those instructions
cause a loss of architectural state on the secondary cores.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/Makefile        |   1 +
 arch/arm64/boot/dts/apple/t8140-j700.dts  |  53 ++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi | 777 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140.dtsi      | 205 ++++++++
 4 files changed, 1036 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 62999574a36b..4f31beeb11ac 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -109,3 +109,4 @@ dtb-$(CONFIG_ARCH_APPLE) += t8132-j624.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8132-j713.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8132-j715.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8132-j773g.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8140-j700.dtb
diff --git a/arch/arm64/boot/dts/apple/t8140-j700.dts b/arch/arm64/boot/dts/apple/t8140-j700.dts
new file mode 100644
index 000000000000..8e386ae7350c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140-j700.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Neo (A18 Pro, 2026)
+ *
+ * target-type: J700
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8140.dtsi"
+
+/ {
+	model = "Apple MacBook Neo (A18 Pro, 2026)";
+	compatible = "apple,j700", "apple,t8140", "apple,arm-platform";
+
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
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
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
diff --git a/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
new file mode 100644
index 000000000000..dd43520394ac
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
@@ -0,0 +1,777 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8140 "A18 Pro" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pmgr {
+	ps_sep_aon: power-controller@60 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		label = "sep_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_msg: power-controller@108 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		label = "msg";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_aic: power-controller@110 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		label = "aic";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_dwi: power-controller@118 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		label = "dwi";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		label = "gpio";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pmc: power-controller@138 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		label = "pmc";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm0: power-controller@140 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		label = "pms_fpwm0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm1: power-controller@148 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		label = "pms_fpwm1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm2: power-controller@150 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		label = "pms_fpwm2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm3: power-controller@158 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		label = "pms_fpwm3";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_fpwm4: power-controller@160 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		label = "pms_fpwm4";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_pms_c1ppt: power-controller@168 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		label = "pms_c1ppt";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_soc_rc: power-controller@170 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		label = "soc_rc";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_soc_dpe: power-controller@178 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		label = "soc_dpe";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_pmgr_soc_ocla: power-controller@180 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		label = "pmgr_soc_ocla";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ispsens0: power-controller@188 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x188 4>;
+		label = "ispsens0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ispsens1: power-controller@190 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		label = "ispsens1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ap_tmm: power-controller@1a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		label = "ap_tmm";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_afggfxni0: power-controller@1b8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		label = "afggfxni0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_gfx: power-controller@1f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		label = "gfx";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_jpg: power-controller@230 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		label = "jpg";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_msr: power-controller@238 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x238 4>;
+		label = "msr";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc0_sys: power-controller@240 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		label = "venc0_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_prores: power-controller@250 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		label = "prores";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_gp: power-controller@258 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x258 4>;
+		label = "apcie_gp";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_isp_sys: power-controller@268 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		label = "isp_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ans: power-controller@278 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		label = "ans";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_disp_sys: power-controller@280 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		label = "disp_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext0_sys: power-controller@288 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		label = "dispext0_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_ane_sys: power-controller@290 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		label = "ane_sys";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_msr_ase_core: power-controller@298 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		label = "msr_ase_core";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_msr>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_sys_gp: power-controller@2a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		label = "apcie_sys_gp";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_sio_cpu: power-controller@2a8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		label = "sio_cpu";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_fpwm0: power-controller@2b0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		label = "fpwm0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_fpwm1: power-controller@2b8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		label = "fpwm1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_fpwm2: power-controller@2c0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		label = "fpwm2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c0: power-controller@2c8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		label = "i2c0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c1: power-controller@2d0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		label = "i2c1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c2: power-controller@2d8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		label = "i2c2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c3: power-controller@2e0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		label = "i2c3";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_i2c4: power-controller@2e8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		label = "i2c4";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi_p: power-controller@2f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		label = "spi_p";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart_p: power-controller@2f8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		label = "uart_p";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_dpa_p: power-controller@300 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		label = "dpa_p";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_aes: power-controller@308 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		label = "aes";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_st: power-controller@310 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		label = "apcie_st";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ans>;
+		#reset-cells = <0>;
+	};
+
+	ps_disp_fe: power-controller@318 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x318 4>;
+		label = "disp_fe";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_disp_sys>;
+		#reset-cells = <0>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext0_fe: power-controller@320 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		label = "dispext0_fe";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext0_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_dispext0_cpu: power-controller@328 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x328 4>;
+		label = "dispext0_cpu";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dispext0_fe>;
+		#reset-cells = <0>;
+
+		status = "disabled"; /* Locked, don't touch it */
+	};
+
+	ps_spi0: power-controller@330 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		label = "spi0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi1: power-controller@338 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x338 4>;
+		label = "spi1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi2: power-controller@340 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		label = "spi2";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_spi3: power-controller@348 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		label = "spi3";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_qspi: power-controller@350 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x350 4>;
+		label = "qspi";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_spi_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart_n: power-controller@358 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x358 4>;
+		label = "uart_n";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart0: power-controller@360 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		label = "uart0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart1: power-controller@368 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x368 4>;
+		label = "uart1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart2: power-controller@370 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		label = "uart2";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart3: power-controller@378 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		label = "uart3";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart4: power-controller@380 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		label = "uart4";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_uart5: power-controller@388 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		label = "uart5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_uart_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_dpa0: power-controller@390 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		label = "dpa0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dpa_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_dpa1: power-controller@398 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		label = "dpa1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_dpa_p>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_sys_st: power-controller@3a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		label = "apcie_sys_st";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_ans>, <&ps_apcie_st>;
+		#reset-cells = <0>;
+	};
+
+	ps_apcie_phy_sw: power-controller@3c0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		label = "apcie_phy_sw";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
+		#reset-cells = <0>;
+	};
+
+	ps_pmp: power-controller@3d0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		label = "pmp";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@3d8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		label = "pms_sram";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@3e0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		label = "atc0_usb_aon";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_common: power-controller@3e8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		label = "atc0_common";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_usb_aon>;
+		#reset-cells = <0>;
+	};
+
+	ps_atc0_usb: power-controller@3f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		label = "atc0_usb";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_atc0_common>;
+		#reset-cells = <0>;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		label = "sep";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_venc0_dma: power-controller@8000 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		label = "venc0_dma";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc0_sys>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc0_pipe4: power-controller@8008 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		label = "venc0_pipe4";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc0_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc0_pipe5: power-controller@8010 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		label = "venc0_pipe5";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc0_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc0_me0: power-controller@8018 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		label = "venc0_me0";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc0_dma>;
+		#reset-cells = <0>;
+	};
+
+	ps_venc0_me1: power-controller@8020 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		label = "venc0_me1";
+		#power-domain-cells = <0>;
+		power-domains = <&ps_venc0_me0>;
+		#reset-cells = <0>;
+	};
+};
+
+&pmgr_mini {
+	ps_debug_gated: power-controller@0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		label = "debug_gated";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@58 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		label = "nub_spmi0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@60 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		label = "nub_spmi1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@68 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		label = "nub_spmi_a0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_aon_nogate: power-controller@78 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		label = "nub_aon_nogate";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_ocla: power-controller@80 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x80 4>;
+		label = "nub_ocla";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@88 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		label = "nub_gpio";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_fabric: power-controller@a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		label = "nub_fabric";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_nub_sram: power-controller@a8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		label = "nub_sram";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_debug_switch: power-controller@b0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		label = "debug_switch";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_smc_i2cm0: power-controller@8028 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8028 4>;
+		label = "smc_i2cm0";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_smc_i2cm1: power-controller@8030 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8030 4>;
+		label = "smc_i2cm1";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+
+	ps_smc_i2cm2: power-controller@8038 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8038 4>;
+		label = "smc_i2cm2";
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		apple,always-on;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
new file mode 100644
index 000000000000..ee7804dc2301
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8140 "A18 Pro" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "apple,t8140", "apple,arm-platform";
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
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-e";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x10000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e1: cpu@1 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-e";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x10000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e2: cpu@2 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-e";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x10000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_e3: cpu@3 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-e";
+			reg = <0x0 0x3>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x10000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x20000>;
+			next-level-cache = <&l2_cache_0>;
+		};
+
+		cpu_p0: cpu@10100 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-p";
+			reg = <0x0 0x10100>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x20000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		cpu_p1: cpu@10101 {
+			device_type = "cpu";
+			compatible = "apple,tahiti-p";
+			reg = <0x0 0x10101>;
+			cpu-release-addr = <0 0>;
+			d-cache-size = <0x20000>;
+			enable-method = "spin-table";
+			i-cache-size = <0x30000>;
+			next-level-cache = <&l2_cache_1>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <0x400000>;
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
+		pmgr: power-management@300700000 {
+			compatible = "apple,t8140-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			reg = <0x3 0x700000 0 0x14000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* child nodes are added in t8140-pmgr.dtsi */
+		};
+
+		aic: interrupt-controller@301000000 {
+			compatible = "apple,t8140-aic3", "apple,t8122-aic3";
+			reg = <0x3 0x01000000 0x0 0x1cc000>,
+			      <0x3 0x01040000 0x0 0x4000>;
+			reg-names = "core", "event";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			power-domains = <&ps_aic>;
+		};
+
+		pmgr_mini: power-management@308280000 {
+			compatible = "apple,t8140-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			reg = <0x3 0x8280000 0 0xc000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* child nodes are added in t8140-pmgr.dtsi */
+		};
+
+		wdt: watchdog@3082b0000 {
+			compatible = "apple,t8140-wdt", "apple,t8103-wdt";
+			reg = <0x3 0x082b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 507 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		serial0: serial@385200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3 0x85200000 0x0 0x1000>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1092 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_uart0>;
+			reg-io-width = <4>;
+
+			status = "disabled";
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
+#include "t8140-pmgr.dtsi"

-- 
2.55.0

