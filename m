Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E393481666;
	Tue, 13 Oct 2026 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863221; cv=none; b=gV6RcOKeOohU8mf9VIlL9pbjKwUnUWooskHFH5ptAQu5Tgj+nfte1OK5kNFOOIZK01ZF9GNZ8GjykJkmvuawfSxLAUwKRry1fI8mjFVlszMfeYrp6RomQaYOiAB+VqjGH0qmxMyxvUM6wgaQC1jH3ur8uJX83C4+TBw6gdbFly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863221; c=relaxed/simple;
	bh=31t7A4ec1Xhu+LA6GuFAzpvU2Mlareg98Anh2jPt2bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L24MVZ4tVTK1x/lDPb4HE4WqTMiA1x0ng4YmphbEpzuYm0TGG4e1eZG1owXBVrPLmA0DXVwyq8XK2XWwEr44H0E3xXsFBhtiFXH85sZFSEb6ZVm410GIsOdYzNoH5AAksydYzugcgzOQLWWJPPKcBv6yF/x0YA58ETdLN/R2sCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czj03W+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czj03W+1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62D7C4DDE8;
	Tue, 13 Oct 2026 03:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863221;
	bh=31t7A4ec1Xhu+LA6GuFAzpvU2Mlareg98Anh2jPt2bA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=czj03W+1j+/sCUR5y+xkyOyUIv2vlbqth8Y/gZmJBxgCOfyNr3DXMhMSmjSEtqpmU
	 ZsUKTmmO4gGuprspho6Pt7AKEzGKdgMnIGJmFCF3kszrFPYbOMEcYCUylSZYA0vSyc
	 XRbDudEU61VeAwNS6QM1Uutg7Q+VPbL73QdrjM80zgS+5y8bdBQGnpQbuPGv/S00aE
	 SOPEKWoH2esR/EzmqI7jMsK2af+zxzw8SetjFXPB8FXKFKPSa4rDL7bxcAZgc//QHw
	 FBJoMhl8GhmSm1VBHc4BKLo70Wrzdo5Zi/4VQxAoRD+CxIsB/m1Db3JJs1v6Qv8Nqq
	 deviyxKc49qMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF9CA9ECF;
	Tue, 13 Oct 2026 03:47:00 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:47:03 +0300
Subject: [PATCH v2 05/11] dt-bindings: i2c: Add Cortina Systems CS7542 I2C
 controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-s2-v2-5-94f8c0a90cda@gmail.com>
References: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863218; l=1834;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=aHpVqUhA73R0k52i9jHgHCikRVBzEr4JeY2wk8AHGqM=;
 b=ekKpXYzC0XO6AI578jN3+5rLSx/f5aoJnY7HnRsb2LP6027sUxT50AFq+CGUQPz7Unp81U8E1
 32i5GephyemAEqlezrxEeFBr5PXqV3FT52ApABrarkom86Mbx8hxPrH
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add a binding for the I2C ("Bi-Wire") controller of the Cortina Systems
CS75xx SoCs.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/i2c/cortina,cs7542-i2c.yaml           | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml b/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
new file mode 100644
index 000000000..f70984bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/cortina,cs7542-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 I2C controller
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The I2C ("Bi-Wire") controller of the Cortina Systems CS75xx (Goldengate
+  G2) SoCs. It transfers one byte per command and runs from the peripheral
+  (APB) clock through a 16-bit prescaler.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    enum: [100000, 400000]
+    default: 100000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@f00700e8 {
+        compatible = "cortina,cs7542-i2c";
+        reg = <0xf00700e8 0x28>;
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+        clocks = <&apb_clk>;
+        clock-frequency = <400000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.53.0


