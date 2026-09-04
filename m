Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240B37DE9F;
	Fri,  4 Sep 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551412; cv=none; b=qae8y4KH5Y7zTUp+U+9kqFLAYG3h5H5N6g2DVemeWEzeWVmeHjqWyu92DEkRS0a85TGRY38YDzmhf0aSw7Yr4en+Zr/3OQUThvEjGDxGHP6xYmuLo9ORDH29l+MUAeH48WFLPLmh/B6RmBq7DVPtOef96vE4psrQlmLtMGlb2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551412; c=relaxed/simple;
	bh=TUgrPk7LQlk6fJ6MiGWRKtJluvW2+jvjrJ24KS2adCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dinGN3qD0R80CAdMcdMpE9pc9J37k5/bZbNSOnd3VFBLollOF/yVscGOIRmKcqwy184vd8l3zPx4hyw0oTRjGWNfkkd/NWJ97nJkcwQ+YArf/e2K2BZSM3g8yqWtaW+ODR6D6AoSvhwBXQRNNtMvb27U+EBsoKyVS7sH5em1w6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=x9bSw8lm; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="x9bSw8lm"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788551399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBwuTdxte3hCBRhbW+JPwJ8NkC6n0iOPKgCj3HD8aEA=;
	b=x9bSw8lmjHHHlHNi/voq1IUaxLaUFxwgcPYyAU/sAnVpPYI2eSh9Lpn6U2S+jZdyhn/3Pp
	we3/+rrXC7M0RBrbP+uqJMn5oJgACgHeO6MjZLxWq1PVlt+usYHMnBXLZ6BCN2wRcKIQ9a
	or3191oVDjPb4mTqer5NMAP+RypDyeQ=
Date: Fri, 04 Sep 2026 21:49:39 +0200
Subject: [PATCH 6/6] arm64: dts: apple: Add minimal MacBook Neo device tree
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
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
 arch/arm64/boot/dts/apple/t8140-j700.dts  |  52 ++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi | 771 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140.dtsi      | 202 ++++++++
 4 files changed, 1026 insertions(+)

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
index 000000000000..029d6fdda3ad
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140-j700.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Neo
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
+	compatible = "apple,j700", "apple,t8140", "apple,arm-platform";
+	model = "Apple MacBook Neo";
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		/* To be filled by loader */
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
new file mode 100644
index 000000000000..91bdb84510fd
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
@@ -0,0 +1,771 @@
+&pmgr {
+	ps_sep_aon: power-controller@60 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep_aon";
+		apple,always-on;
+	};
+
+	ps_msg: power-controller@108 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+	};
+
+	ps_aic: power-controller@110 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on;
+	};
+
+	ps_dwi: power-controller@118 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pmc: power-controller@138 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmc";
+	};
+
+	ps_pms_fpwm0: power-controller@140 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm0";
+	};
+
+	ps_pms_fpwm1: power-controller@148 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm1";
+	};
+
+	ps_pms_fpwm2: power-controller@150 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm2";
+	};
+
+	ps_pms_fpwm3: power-controller@158 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm3";
+	};
+
+	ps_pms_fpwm4: power-controller@160 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm4";
+	};
+
+	ps_pms_c1ppt: power-controller@168 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_c1ppt";
+		apple,always-on;
+	};
+
+	ps_soc_rc: power-controller@170 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_rc";
+	};
+
+	ps_soc_dpe: power-controller@178 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on;
+	};
+
+	ps_pmgr_soc_ocla: power-controller@180 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+	};
+
+	ps_ispsens0: power-controller@188 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@190 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ap_tmm: power-controller@1a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ap_tmm";
+	};
+
+	ps_afggfxni0: power-controller@1b8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "afggfxni0";
+		apple,always-on;
+	};
+
+	ps_gfx: power-controller@1f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_jpg: power-controller@230 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+	};
+
+	ps_msr: power-controller@238 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+	};
+
+	ps_venc0_sys: power-controller@240 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_sys";
+	};
+
+	ps_prores: power-controller@250 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "prores";
+	};
+
+	ps_apcie_gp: power-controller@258 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+	};
+
+	ps_isp_sys: power-controller@268 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+	};
+
+	ps_ans: power-controller@278 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+		apple,always-on;
+	};
+
+	ps_disp_sys: power-controller@280 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_sys";
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext0_sys: power-controller@288 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_sys";
+	};
+
+	ps_ane_sys: power-controller@290 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+	};
+
+	ps_msr_ase_core: power-controller@298 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+		power-domains = <&ps_msr>;
+	};
+
+	ps_apcie_sys_gp: power-controller@2a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_gp";
+		power-domains = <&ps_apcie_gp>;
+	};
+
+	ps_sio_cpu: power-controller@2a8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+	};
+
+	ps_fpwm0: power-controller@2b0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+	};
+
+	ps_fpwm1: power-controller@2b8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+	};
+
+	ps_fpwm2: power-controller@2c0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+	};
+
+	ps_i2c0: power-controller@2c8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+	};
+
+	ps_i2c1: power-controller@2d0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+	};
+
+	ps_i2c2: power-controller@2d8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+	};
+
+	ps_i2c3: power-controller@2e0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+	};
+
+	ps_i2c4: power-controller@2e8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+	};
+
+	ps_spi_p: power-controller@2f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+	};
+
+	ps_uart_p: power-controller@2f8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+	};
+
+	ps_dpa_p: power-controller@300 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa_p";
+		apple,always-on;
+	};
+
+	ps_aes: power-controller@308 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+	};
+
+	ps_apcie_st: power-controller@310 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_ans>;
+	};
+
+	ps_disp_fe: power-controller@318 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_fe";
+		power-domains = <&ps_disp_sys>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext0_fe: power-controller@320 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_fe";
+		power-domains = <&ps_dispext0_sys>;
+	};
+
+	ps_dispext0_cpu: power-controller@328 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_cpu";
+		power-domains = <&ps_dispext0_fe>;
+
+		status = "disabled"; /* Locked, don't touch it */
+	};
+
+	ps_spi0: power-controller@330 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi1: power-controller@338 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi2: power-controller@340 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@348 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_qspi: power-controller@350 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "qspi";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_uart_n: power-controller@358 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@360 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@368 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@370 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@378 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@380 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@388 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_dpa0: power-controller@390 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_dpa1: power-controller@398 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		power-domains = <&ps_dpa_p>;
+	};
+
+	ps_apcie_sys_st: power-controller@3a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_st";
+		power-domains = <&ps_ans>, <&ps_apcie_st>;
+	};
+
+	ps_apcie_phy_sw: power-controller@3c0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_phy_sw";
+		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
+	};
+
+	ps_pmp: power-controller@3d0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@3d8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@3e0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+	};
+
+	ps_atc0_common: power-controller@3e8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+		power-domains = <&ps_atc0_usb_aon>;
+	};
+
+	ps_atc0_usb: power-controller@3f0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on;
+	};
+
+	ps_venc0_dma: power-controller@8000 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_dma";
+		power-domains = <&ps_venc0_sys>;
+	};
+
+	ps_venc0_pipe4: power-controller@8008 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_pipe4";
+		power-domains = <&ps_venc0_dma>;
+	};
+
+	ps_venc0_pipe5: power-controller@8010 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_pipe5";
+		power-domains = <&ps_venc0_dma>;
+	};
+
+	ps_venc0_me0: power-controller@8018 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_me0";
+		power-domains = <&ps_venc0_dma>;
+	};
+
+	ps_venc0_me1: power-controller@8020 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc0_me1";
+		power-domains = <&ps_venc0_me0>;
+	};
+};
+
+&pmgr_mini {
+	ps_debug_gated: power-controller@0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_gated";
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@58 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@60 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@68 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a0";
+		apple,always-on;
+	};
+
+	ps_nub_aon_nogate: power-controller@78 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_aon_nogate";
+		apple,always-on;
+	};
+
+	ps_nub_ocla: power-controller@80 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_ocla";
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@88 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on;
+	};
+
+	ps_nub_fabric: power-controller@a0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_fabric";
+		apple,always-on;
+	};
+
+	ps_nub_sram: power-controller@a8 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on;
+	};
+
+	ps_debug_switch: power-controller@b0 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_switch";
+		apple,always-on;
+	};
+
+	ps_smc_i2cm0: power-controller@8028 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_i2cm0";
+		apple,always-on;
+	};
+
+	ps_smc_i2cm1: power-controller@8030 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_i2cm1";
+		apple,always-on;
+	};
+
+	ps_smc_i2cm2: power-controller@8038 {
+		compatible = "apple,t8140-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_i2cm2";
+		apple,always-on;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
new file mode 100644
index 000000000000..a1c6976abd50
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -0,0 +1,202 @@
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
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			compatible = "apple,tahiti-e";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,tahiti-e";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,tahiti-e";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,tahiti-e";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_p0: cpu@10100 {
+			compatible = "apple,tahiti-p";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p1: cpu@10101 {
+			compatible = "apple,tahiti-p";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		nonposted-mmio;
+		ranges;
+
+		pmgr: power-management@300700000 {
+			compatible = "apple,t8140-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x3 0x700000 0 0x14000>;
+			/* child nodes are added in t8140-pmgr.dtsi */
+		};
+
+		aic: interrupt-controller@301000000 {
+			compatible = "apple,t8140-aic3", "apple,t8122-aic3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x00000003 0x01000000 0x00000000 0x1cc000>,
+			      <0x00000003 0x01040000 0x00000000 0x4000>;
+			reg-names = "core", "event";
+			power-domains = <&ps_aic>;
+		};
+
+		pmgr_mini: power-management@308280000 {
+			compatible = "apple,t8140-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x3 0x8280000 0 0xc000>;
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
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1092 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+		             <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+#include "t8140-pmgr.dtsi"

-- 
2.55.0

