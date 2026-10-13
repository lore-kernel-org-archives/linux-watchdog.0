Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8534A3A5;
	Tue, 13 Oct 2026 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863221; cv=none; b=mnRMa5uWHV5WWhnc6T/FIwiCGk1fMi1NYdFzX3Aio+RIkq6tozEVdlElKewxquhkCMvhbBPFNqzO3nvGQFnk0KMnZ8B5eFSFPFyKp3eq9vaGUImrGDLzPGZPVktUR2YP6WLjgSGD3MmNHOAb6nnjqtjQTwBLIiKQZJwsWXN4PT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863221; c=relaxed/simple;
	bh=Ben9ds7l5snlJMg8NPMQQZULDqBGhQj1SfVWHLiwrlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvIKjanI6C2+7xv/zlqGAJ8ElMYscg339eDIzoCYCoAIwWP5uN442YmvDsaqA8iaPRT9YKP/IfnEujyn5te8CxlCOpeJJ4JM031i+2tm9wUs5q0Tzc3R2+8SEJ9sbKciPFGuO77nsiZlITNJT0Y2VGxb5WJjT9yR3MYw40N0a1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvVidnrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvVidnrO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C500DC2BD04;
	Tue, 13 Oct 2026 03:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863220;
	bh=Ben9ds7l5snlJMg8NPMQQZULDqBGhQj1SfVWHLiwrlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kvVidnrOt+EMKSU0H0MJejrpz0szqmRk7TNMKrX0SG2QMTt5vOxLZVwA9zTd2B7/z
	 IPacdwzYZydyPZOw7dsRKHLFm40H1wsVCzvoEu186IUmPjor9lf9LPKzjo8raF9BFQ
	 tdAIxg6o1QG1p1aDyr5xFsO9zzKz+uQdU7EVXSwLwucpC/r4tZsJbYiqN/qkEOzQEv
	 doIKlsGtRiWsajHv3iMQT/SssRqS+yMhzEMilWH4s/nAjntxO6doBe5oJbt08ePY3J
	 O5/jhM4ddf5ouiMrIrOfDjadlA2snI0WB+8H91Zh1B0c3vx4zqzkDXBHS8fOIClIrA
	 LVs8HjJmNOMXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3337CC6B0A;
	Tue, 13 Oct 2026 03:47:00 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:47:01 +0300
Subject: [PATCH v2 03/11] dt-bindings: gpio: Add Cortina Systems CS7542
 GPIO controller
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-s2-v2-3-94f8c0a90cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863218; l=2368;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=uz2ou1IT1ghc6GBy1z+YYFHHajTQ9VyMONdxfzPSdIk=;
 b=a6YF2bz41Jf284u1KNjw9EVPy79jB7fizH+pEX2gOtD1euIkXWWPX68AT6k+DC65yulTJqywN
 bTh1ssyUvw1DZBZcKqRy9Yq2CD4RuA3dD5N8ruzYNIvQRId91QkjS6S
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

The Cortina Systems CS75xx SoCs have five banks of 32 GPIO lines. Each
pin is shared between a GPIO line and a peripheral function, selected by
the bank's GPIO_MUX register in the global control block, which is
described as the second register region of the bank.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/gpio/cortina,cs7542-gpio.yaml         | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml b/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
new file mode 100644
index 000000000..b54421d65
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/cortina,cs7542-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 GPIO controller
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The Cortina Systems CS75xx (Goldengate G2) SoCs have five banks of 32
+  GPIO lines, each with its own interrupt. Every pin is shared between a
+  GPIO line and a peripheral function; the choice is made per pin in the
+  GPIO_MUX register of the bank, which is part of the global control
+  block.
+
+properties:
+  compatible:
+    const: cortina,cs7542-gpio
+
+  reg:
+    items:
+      - description: GPIO bank registers
+      - description: GPIO_MUX register of the bank
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    maxItems: 32
+
+  gpio-reserved-ranges: true
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@f00701f0 {
+        compatible = "cortina,cs7542-gpio";
+        reg = <0xf00701f0 0x20>, <0xf0000020 0x4>;
+        interrupt-parent = <&intc>;
+        interrupts = <7>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };

-- 
2.53.0


