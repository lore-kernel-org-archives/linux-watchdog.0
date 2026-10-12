Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E04BF956;
	Mon, 12 Oct 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826378; cv=none; b=VkXotLT7khVysUQlJlpJdBtRqtjt4LUX2mI5vER4OGeBKHfYTrOkYfgf4boJCmRu2skXRL4d3pT9Pp343xFuD6tNOlbxVHi4UgzJEQGQADIc91U1yN9uZMgowivbYz7i+h9+HgkyIijhCyhzulSr0GSl7c3qXuthYESki/Dkm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826378; c=relaxed/simple;
	bh=LVXybKoszYAKk7+ZqXsYnEtv/pEeuvwZpKkZi4AyivI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWYJCafHBqWVLoecXoRdItT7H2kuw9+vGF2xUWCtCdojAxpRwPQEwqslgbcrEBqXGDx8vewoV2Hkf+Euh1jd6eWO2NO4sTocDaeZj21J3eQPYG4HF/uaZmbWHSURN7CE7ndoBti8/SUDL9J1glcnlRpuDL1mWyar2LgDHWN3/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvP4qnSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvP4qnSM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95D0AC32786;
	Mon, 12 Oct 2026 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791826378;
	bh=LVXybKoszYAKk7+ZqXsYnEtv/pEeuvwZpKkZi4AyivI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QvP4qnSM+j3yNjo43aDnrQRjKxbeohuXiGybzdelnYrZ0ltxDekOaEUAAacDTVIOF
	 7wrxPqNiriAFNegFZu2+kTwhzos1KvrpuGKUj97tFjsAVyqRtHxheNVA3g7r+6WL6v
	 9pf401UfPv+Ui4JCkjsBMKPEelGNYTlPRhRjf75bYudWn3JEX0R+HUs+NbJN78cxyD
	 4AWY+5PltwzYlh1BtYMUCZmsgBAucznW69zxfmL36FDIzu7ar2GyLjun9GfTZYQiAS
	 iBKknAZTVAc6mcrXjjNfEQ3Z9QSS4/2WZ74KLF+vllgVDzGdLCggUE8CyV1V8fybiQ
	 LMq2GqTRJAplA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8128ECA9EC5;
	Mon, 12 Oct 2026 17:32:58 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:33:03 +0300
Subject: [PATCH 08/11] ARM: dts: cortina: cs7542: Add interrupt controller,
 GPIO and I2C
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-s2-v1-8-8a7641b7b79c@gmail.com>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826375; l=2798;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=3Upc60FD1EM1O4fIft/ek4FPT0icYaZ8EOrDpkRXA2U=;
 b=YZY3DCEJTmviePTr87BPhuU9ZzNGL30NsJO1ljcBhckDD6PL2RZYId3QBGcz6f4XURPhXRiBm
 cxdQhgVoB66B7ZLrynrnuGufzvhe6uIcpTcbNaCGr16+/+kuBSRKTgR
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Describe the peripheral interrupt controller, the five GPIO banks and
the I2C controller of the CS7542.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/boot/dts/cortina/cs7542.dtsi | 75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/cortina/cs7542.dtsi b/arch/arm/boot/dts/cortina/cs7542.dtsi
index 29b0b7da8..c88449c54 100644
--- a/arch/arm/boot/dts/cortina/cs7542.dtsi
+++ b/arch/arm/boot/dts/cortina/cs7542.dtsi
@@ -44,6 +44,26 @@ soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		intc: interrupt-controller@f0070004 {
+			compatible = "cortina,cs7542-intc";
+			reg = <0xf0070004 0x8>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		i2c: i2c@f00700e8 {
+			compatible = "cortina,cs7542-i2c";
+			reg = <0xf00700e8 0x28>;
+			interrupt-parent = <&intc>;
+			interrupts = <11>;
+			clocks = <&apb_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		uart0: serial@f0070110 {
 			compatible = "cortina,cs7542-uart";
 			reg = <0xf0070110 0x30>;
@@ -80,6 +100,61 @@ uart3: serial@f00701a0 {
 			status = "disabled";
 		};
 
+		gpio0: gpio@f00701d0 {
+			compatible = "cortina,cs7542-gpio";
+			reg = <0xf00701d0 0x20>, <0xf000001c 0x4>;
+			interrupt-parent = <&intc>;
+			interrupts = <6>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@f00701f0 {
+			compatible = "cortina,cs7542-gpio";
+			reg = <0xf00701f0 0x20>, <0xf0000020 0x4>;
+			interrupt-parent = <&intc>;
+			interrupts = <7>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@f0070210 {
+			compatible = "cortina,cs7542-gpio";
+			reg = <0xf0070210 0x20>, <0xf0000024 0x4>;
+			interrupt-parent = <&intc>;
+			interrupts = <8>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@f0070230 {
+			compatible = "cortina,cs7542-gpio";
+			reg = <0xf0070230 0x20>, <0xf0000028 0x4>;
+			interrupt-parent = <&intc>;
+			interrupts = <9>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio4: gpio@f0070250 {
+			compatible = "cortina,cs7542-gpio";
+			reg = <0xf0070250 0x20>, <0xf000002c 0x4>;
+			interrupt-parent = <&intc>;
+			interrupts = <10>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		l2: cache-controller@f5010000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xf5010000 0x1000>;

-- 
2.53.0


