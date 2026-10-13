Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649464825AF;
	Tue, 13 Oct 2026 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863221; cv=none; b=MVO2q+Ro2EgREkwex8nTVL9oMImpMUoDnY5JnGZpN8aCBS7SkXGEnG78y/52zmWS8spl02RDxCZLWMdBWRG/e1uwicoYy6lK0qfpd5o4Cm59eKJg+yLpuQNQrX68cThA+/eqK5pDqlbZbcbkNCP0s1q4Rd8RO04ckXpD2d7Gvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863221; c=relaxed/simple;
	bh=2K57Ukhh2ZtD8p9cC8o3YJWWaJ88JHj5YgPFCwXr2bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijgsCR9x+UU//1WSk3CbYb+vA0Uv0/uWRW32b3qJx+kQBYT/w9/OtAW3Zy3t0QNG7okvEArIu5vtejCnRq3pjdOVQOzMCeJNmLOKZO77LalEZPoDpb7sEUVWTiRCquBQbY+8OL5fMR2d1LBUO2pYqXMVp4ziK/P+jqZ5c87Pkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMbT2gWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMbT2gWe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3205AC4AF0C;
	Tue, 13 Oct 2026 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863221;
	bh=2K57Ukhh2ZtD8p9cC8o3YJWWaJ88JHj5YgPFCwXr2bY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LMbT2gWemgBLuysQ9RBlFmfXPNW3MkkTYeluwEKCEUEDxoxqXxjA40/+JZFqIHIiR
	 MSXKs1S7oNMNfaYctFmAzkiln39NwggXloL3fWrTwKHRAFD3nL2nRIdTbgJOj+C6IG
	 /MVqIlVMNiwfJeSaF6Axh4V7Use0ptDrsht0BE6Gk5MRj5gFMFvvaDz3c8JfrKRT43
	 hhVUNKJI5Nm6UPSTR6/1xkXO/Ia+jhIQ5EDWkssGWCoJ6ZZ5s4lotSmU7zE9M2mGfS
	 rixreKNDaxO0ezdZiZjQIAFFWKXN9GEnGcBa0aYe1tHA/K2tMwvo8qhVvF97s03W28
	 +BZhcw09xyWLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F716CC6B03;
	Tue, 13 Oct 2026 03:47:01 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:47:07 +0300
Subject: [PATCH v2 09/11] ARM: dts: cortina: almondplus: Add reset button
 and enable I2C
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-s2-v2-9-94f8c0a90cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863218; l=1441;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=2Dx/b8/3JsG/5KBFCzsSYSUq7LHO1maolj27mYLmFbc=;
 b=NCZhojoHHDNDG3XNDmNssM8FdsHah1ATGHcI1qanJ/M9/p+ahGop8+fVJAwJYx6j7tdK1iRTh
 yxm/NFQhbfOBxY5fGdxo1PZuSCHumLV63eLgxipMwcjupcLIJABC2eG
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

The pinhole button on the back of the Almond+ is connected to GPIO 37
(bank 1, line 5), active low. The stock firmware uses it for restart
and factory reset.

Enable the I2C bus, which has the touchscreen controller on it; the
touchscreen itself will be added together with its driver changes.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../boot/dts/cortina/cs7542-securifi-almondplus.dts   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
index e2988c687..0619bd754 100644
--- a/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
+++ b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
@@ -5,6 +5,9 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
 #include "cs7542.dtsi"
 
 / {
@@ -19,6 +22,16 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	keys {
+		compatible = "gpio-keys";
+
+		button-reset {
+			label = "reset";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
@@ -50,6 +63,12 @@ &apb_clk {
 	clock-frequency = <150000000>;
 };
 
+&i2c {
+	clock-frequency = <400000>;
+
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.53.0


