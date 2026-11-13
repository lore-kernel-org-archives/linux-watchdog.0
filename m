Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567094;
	b=w03Cl5T+VBTt0FglNv8m3ratsYrqB0B67nLUYZKxkJwlnb0611IFMTC40EYiEwxxWVGH
	 I1qp2n2IhH+e2Nc8445oWjipvDMV+Ucwv3cMnjo9qz/gFrkUQ2kfeJ7+fBiURCxSnyJNK
	 oYfM+mrupkHTlzw1q6E3AXROFO5NOEs2R7CJewcycSpCxQ0ToAICHonyYMMFEIDLiNPyz
	 ygnaWOuLSaFIuns/DIzqdKSX8NUxOqsHGzjmlQEY1QqQwUl9imO93npSa/rf/RuCqhr7W
	 tX2SC9L3hUeNyI3Q4D66KVb1CFvyal9VWE8L1Sdr5Cnb6LNXYOR69b3/70UQZwDhKkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567094;
	h=DMARC-Filter:DKIM-Signature:Mime-Version:X-Mailer:
	 Content-Transfer-Encoding:References:Content-Type:To:Cc:Subject:
	 X-Lms-Return-Path:Received:In-Reply-To:From:X-Original-From:Date:
	 Message-Id;
	bh=C7jaf+mqJ3nEpBUCe1nWvnKMcYg9nKNjEb/4DZ1aYO0=;
	b=S7YUCUyEWfDgzbRmw6m9w+mt/fgIljHCBCj1CJE8F3FLbNpOZZ/fkMdNvvwZhn19v58d
	 koxNjiGLFzWX6Hn641oVLLO93mAwAoiYN1GfiI2YUpo++h+MvhuvKVThkEGvONPo+AHDR
	 WbU07q1ePLzFQXICA0RE7VXBz8VFU1asj1kmPIMms9H70XQLxXl99BANG78FaFLNFnUtF
	 r1EG6Rw5Yg8JH4houEsYQ1DIveAf1nNUo0VOAUWGeuZVd+n9NSb/hojnNL6AbNkWyGpg5
	 3sOZ+hDtDl4nlgCeLemWzR++GxBOe3bnoHPxkiGd8QRSVOrLiJ5eVx5WodgQacnPvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=XyW2uR6J;
	arc=none smtp.remote-ip=209.127.231.42
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397D60A261D
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 10:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9397D60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=XyW2uR6J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794567088;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=C7jaf+mqJ3nEpBUCe1nWvnKMcYg9nKNjEb/4DZ1aYO0=;
 b=XyW2uR6JjzFK/plBSCiTKjwRAjuHeGFRgicvBZa4ps2D0kVHXFG39DsVIndJ5Z07ZO691i
 GHq3Ts7MxK7Or+ijk4IdgO2bNVqrbph8RGk97EheBkcWKxPMotByXajHCumECSEqOgzPXx
 bLk2OvrnjWGsslq9fZA18nTqo9m0RQA7OE00qplMYzOjZuOGvMP8QLwHNmGm9X+4bmtuGp
 0BIIvjO4gkk3LvX5tnP1SHwONRVDos3FVf1GV1p0ki9cJFnaofCrz30ec5j6A6QdHlkU6Z
 m/oyPOmzLuxdxDFVhW2lqouIuMpDicafqfdY3ONFvlmJaVhgU+3fyhJ8YO+GTQ==
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: b4 0.17-dev-ce4c1
Content-Transfer-Encoding: 7bit
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>, 
	"Conor Dooley" <conor@kernel.org>
Subject: [PATCH v2 4/8] MIPS: Loongson64: dts: ls7a-pch: Use hex in ranges and reg properties
X-Lms-Return-Path: <lba+26af6ebae+97c36b+vger.kernel.org+rongrong@oss.cipunited.com>
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 18:51:25 +0800
In-Reply-To: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Date: Fri, 13 Nov 2026 18:51:11 +0800
Message-Id: <20261113-mips-ls7a-wdt-v2-4-e8abd6b2f77c@oss.cipunited.com>

The ls7a-pch.dtsi mixes two different styles of addresses and sizes.
Some use a all-hex style while some use a semi-dec-semi-hex style.

The latter style is confusing and hard to read, so convent all ranges
and reg properties into the former style.

Suggested-by: Conor Dooley <conor@kernel.org>
Link: https://msgid.link/20261111-unlucky-parrot-eb416eb0c794@spud
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
The following changes will replace ls7a_uart*'s clock-frequency
properties. There are reg properties with the unfavoured style around
the context, so I decided that this series should fix them as well as
other properties for address and size.
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 28038b8cdd14..9f0a183bd348 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -5,14 +5,14 @@ pch: bus@10000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0 0x10000000 0 0x10000000 0 0x10000000 /* PIO & CONF & APB */
-				0 0x20000000 0 0x20000000 0 0x10000000
-				0 0x40000000 0 0x40000000 0 0x40000000 /* PCI MEM */
-				0xe00 0x00000000 0xe00 0x00000000 0x100 0x0000000>;
+		ranges = <  0x0 0x10000000   0x0 0x10000000   0x0 0x10000000 /* PIO & CONF & APB */
+			    0x0 0x20000000   0x0 0x20000000   0x0 0x10000000
+			    0x0 0x40000000   0x0 0x40000000   0x0 0x40000000 /* PCI MEM */
+			  0xe00 0x00000000 0xe00 0x00000000 0x100 0x00000000>;
 
 		pic: interrupt-controller@10000000 {
 			compatible = "loongson,pch-pic-1.0";
-			reg = <0 0x10000000 0 0x400>;
+			reg = <0x0 0x10000000 0x0 0x400>;
 			interrupt-controller;
 			interrupt-parent = <&htvec>;
 			loongson,pic-base-vec = <0>;
@@ -22,7 +22,7 @@ pic: interrupt-controller@10000000 {
 
 		lpc: interrupt-controller@10002000 {
 			compatible = "loongson,ls7a-lpc";
-			reg = <0 0x10002000 0 0x1000>;
+			reg = <0x0 0x10002000 0x0 0x1000>;
 			interrupt-controller;
 			interrupt-parent = <&pic>;
 			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
@@ -32,7 +32,7 @@ lpc: interrupt-controller@10002000 {
 
 		ls7a_uart0: serial@10080000 {
 			compatible = "ns16550a";
-			reg = <0 0x10080000 0 0x100>;
+			reg = <0x0 0x10080000 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -42,7 +42,7 @@ ls7a_uart0: serial@10080000 {
 		ls7a_uart1: serial@10080100 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080100 0 0x100>;
+			reg = <0x0 0x10080100 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -52,7 +52,7 @@ ls7a_uart1: serial@10080100 {
 		ls7a_uart2: serial@10080200 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080200 0 0x100>;
+			reg = <0x0 0x10080200 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -62,7 +62,7 @@ ls7a_uart2: serial@10080200 {
 		ls7a_uart3: serial@10080300 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080300 0 0x100>;
+			reg = <0x0 0x10080300 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -71,7 +71,7 @@ ls7a_uart3: serial@10080300 {
 
 		rtc0: rtc@100d0100 {
 			compatible = "loongson,ls7a-rtc";
-			reg = <0 0x100d0100 0 0x78>;
+			reg = <0x0 0x100d0100 0x0 0x78>;
 			interrupt-parent = <&pic>;
 			interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
 		};
@@ -83,8 +83,8 @@ pci@1a000000 {
 			#size-cells = <2>;
 			msi-parent = <&msi>;
 
-			reg = <0 0x1a000000 0 0x02000000>,
-				<0xefe 0x00000000 0 0x20000000>;
+			reg = <  0x0 0x1a000000 0x0 0x02000000>,
+			      <0xefe 0x00000000 0x0 0x20000000>;
 
 			ranges = <0x01000000 0x0 0x00020000 0x0 0x18020000 0x0 0x00020000>,
 				 <0x02000000 0x0 0x40000000 0x0 0x40000000 0x0 0x40000000>;
@@ -479,7 +479,7 @@ isa@18000000 {
 			compatible = "isa";
 			#address-cells = <2>;
 			#size-cells = <1>;
-			ranges = <1 0 0 0x18000000 0x20000>;
+			ranges = <0x1 0x00000000 0x0 0x18000000 0x20000>;
 		};
 	};
 };

-- 
2.55.0
