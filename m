Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906593;
	b=cC5kBqY9+WIZi1Qy3wI6y8urupSquxAO1IHtwxKe7dLrAfneykkfwDFz+5uNfyqMqVTj
	 GGhLqqfeuQfrm4rvz4fU2+D74E9wF+QlvwxXYr+dD1Ll1ZkLfGMYTRaqfj9QCTswT6bXO
	 Rj1bZ5hen1642cMkvZB97rpuLo5RbgqzMqC9IVEYhg0w3B3ZkGB0eaX0kSyiuWta+lNif
	 SvJjEMMjkKSCRcWKnKKAFwxn7/gSabvLSteU7AcEml1vifkYqfy7xNBIN5F/xOehy6j4V
	 aKLiC4EMxS8VLufhvs4Fzi87UP9zOh33HHOz7DArSEkufLes2ul93EDy+Xx3gJYEEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906593;
	h=DMARC-Filter:DKIM-Signature:Message-Id:X-Original-From:
	 Content-Transfer-Encoding:Received:Content-Type:Cc:From:In-Reply-To:
	 Subject:X-Lms-Return-Path:X-Mailer:References:Date:Mime-Version:To;
	bh=gbKZTu7knUG4G8yOjg3Om2+jitixoefrUeV7mOS6Cv8=;
	b=rv19+MWyxO02aZ2uOD/ms0n9VHzHvduUmiTSUkKSKpjloMWuZvxG6VMy3djgh5PrJb7C
	 o52ojevB7Gh1LZDnfeTGuz4R11C5YJQO7lF6fJAwG+xVk7+6xc+LGn1wWhIgGuVZ/zbN+
	 FLYgGnrAEIqyBf7B0W+5qKNOtqk1eUSxfRKD+gwHNzp5SbskU2zoyk8eNOoBDBS5xzZL0
	 OlSreEqVPnpZHogkKYar0il1/oAZDH9DMp1qMZVklWpfFS1j+k5VcyfFxJHwtwgjyBriB
	 aO7TUWVSzOMHzXFRJHzD8s1uVrcRKg0b7o9gu9VlruPmdRo+h8JJ5WgkMnVIrlGDGNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b="R/NOYCis";
	arc=none smtp.remote-ip=209.127.231.48
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C49606A880
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C49606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=R/NOYCis
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906581;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gbKZTu7knUG4G8yOjg3Om2+jitixoefrUeV7mOS6Cv8=;
 b=R/NOYCisZAUas7YkThVDOkz3Ypzp6OnaPj0ZwZxrn+d0ZcTOSKYAOWibtlRwd2KKioT1Ui
 Qp0afCU1BooSGzkTZilMvrpu3pvP7CW82Z7MuftkZVFme+9BaXSzVTg6Crft5Oe176ix/D
 ZR3Oln8ohR3DCYSJaoNli9+0Xb5BHfQI4TkBKBCULEQuFmbtg6kTWEIFr2vH10sOjy6D8p
 C5Pc5tclji1edQfFwAGnk2T2GhBzTaLyZ8NxTpYcvYxomTFSv8vljWtaFn0vCUabB9yxA9
 GME0SYuAaZBQWonkXFoYgtZzHX2YWgSN0VYXsB70gEt1Dep6liX6MER7i0E6vA==
Message-Id: <20261117-mips-ls7a-wdt-v3-3-2e88f7e1d6c5@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:38 +0800
Content-Type: text/plain; charset=UTF-8
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>, 
	"Conor Dooley" <conor@kernel.org>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
In-Reply-To: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
Subject: [PATCH v3 3/7] MIPS: Loongson64: dts: ls7a-pch: Use hex in ranges and reg properties
X-Lms-Return-Path: <lba+26afc19d3+255a64+vger.kernel.org+rongrong@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1
References: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
Date: Tue, 17 Nov 2026 17:06:45 +0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>

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
index 71d4c882d3f6..1a0484fa2a96 100644
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
@@ -31,7 +31,7 @@ lpc: interrupt-controller@10002000 {
 
 		ls7a_uart0: serial@10080000 {
 			compatible = "ns16550a";
-			reg = <0 0x10080000 0 0x100>;
+			reg = <0x0 0x10080000 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -41,7 +41,7 @@ ls7a_uart0: serial@10080000 {
 		ls7a_uart1: serial@10080100 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080100 0 0x100>;
+			reg = <0x0 0x10080100 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -51,7 +51,7 @@ ls7a_uart1: serial@10080100 {
 		ls7a_uart2: serial@10080200 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080200 0 0x100>;
+			reg = <0x0 0x10080200 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -61,7 +61,7 @@ ls7a_uart2: serial@10080200 {
 		ls7a_uart3: serial@10080300 {
 			status = "disabled";
 			compatible = "ns16550a";
-			reg = <0 0x10080300 0 0x100>;
+			reg = <0x0 0x10080300 0x0 0x100>;
 			clock-frequency = <50000000>;
 			interrupt-parent = <&pic>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
@@ -70,7 +70,7 @@ ls7a_uart3: serial@10080300 {
 
 		rtc0: rtc@100d0100 {
 			compatible = "loongson,ls7a-rtc";
-			reg = <0 0x100d0100 0 0x78>;
+			reg = <0x0 0x100d0100 0x0 0x78>;
 			interrupt-parent = <&pic>;
 			interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
 		};
@@ -82,8 +82,8 @@ pci@1a000000 {
 			#size-cells = <2>;
 			msi-parent = <&msi>;
 
-			reg = <0 0x1a000000 0 0x02000000>,
-				<0xefe 0x00000000 0 0x20000000>;
+			reg = <  0x0 0x1a000000 0x0 0x02000000>,
+			      <0xefe 0x00000000 0x0 0x20000000>;
 
 			ranges = <0x01000000 0x0 0x00020000 0x0 0x18020000 0x0 0x00020000>,
 				 <0x02000000 0x0 0x40000000 0x0 0x40000000 0x0 0x40000000>;
@@ -478,7 +478,7 @@ isa@18000000 {
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
