Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B764C14E7;
	Mon, 12 Oct 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826379; cv=none; b=emDTpLjAesyFT49VEIAZFmRVPy47aVBRBUC219M5LKjbJ/HAEnccfKsbrBVay5hOQj5f5vFSCFR0ek/IcfWYX17c0nDKK1F31gu2Usa7NKuoww8Yjvy1lMXSyr/hsNgylIIBiVcqMO+mo61l9CzJbQqZe7YcKMf+Jma7WlmVOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826379; c=relaxed/simple;
	bh=Fc3v+sAfUFif61yc1m5RkBfsjoDptWTKM2sW8+Rf9hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0y6JoayFg4BdgnSNEeQIQ8ifC69ZEjXIPbXc/cChFlIR8jATxmRXAttHlCRFDMCVHqHCiSvCXU61Tj+NgfKLRQBP5X/18TSqVaNHABdRAMQ/SGuIvf0rWoN1nwnWuvZ6SxoCvwa7+n2He1x+i/Z4tvKo4lWlMA/2zvl4T3RCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNUFeczc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNUFeczc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F3AC2BCFB;
	Mon, 12 Oct 2026 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791826379;
	bh=Fc3v+sAfUFif61yc1m5RkBfsjoDptWTKM2sW8+Rf9hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gNUFeczc+9TzA+ux0eI/hC/MI40ioo1/ng3ALdqcO0dcvoiI2LdaKR7OsBx9Tnbqa
	 jXvicBe4Tj1g7+XozbxRwMB95vjlwm3d4p5+ZX0gF7dohWhAxEj67fmlqmGN87V2mM
	 Hugg570l2GZgbSCVp16qcn07Erx3EhUi65SRpcJ3Q8wkllPqqza+zsS9q5BWVbukZR
	 8zw6MHMD464g115JoJNLpOhjcKQMdYeShrgz2Cf94FirTUkkCv/Bjgkje+59p6Wiho
	 ECbu7xuUpCssWWWEBG36toA6XlIkGlqSsWReNYFetg6jc3GyT0OlgndmNkIbq7d9+h
	 8aep2IUn8BqWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F4CCC6B02;
	Mon, 12 Oct 2026 17:32:58 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:33:06 +0300
Subject: [PATCH 11/11] MAINTAINERS: Add Cortina Systems CS75xx interrupt
 controller, GPIO and I2C
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-s2-v1-11-8a7641b7b79c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826375; l=1164;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=8born+lqbJWHHfA9yx4+qhsEyHSP/MdbnsbUcNAg5HU=;
 b=McX5VFVIBMEiKok3MNRRKjOItUON1F9LNasVxMYv86Pj+kozqtVEJCdHF5REZibrZjO8sS/CK
 mQ3cEN0aUEVBZjXPo+BjmQZPwkBEMXH7/RcgqvzzXDb3kku788v0bzF
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

List the new Cortina Systems CS75xx interrupt controller, GPIO and I2C
drivers and their bindings in the CS75xx entry.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53f6fa1c5..604993705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2925,10 +2925,16 @@ M:	Fil Dunsky <filipp.dunsky@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/cortina.yaml
+F:	Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
+F:	Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/cortina,cs7542-intc.yaml
 F:	Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
 F:	arch/arm/boot/dts/cortina/
 F:	arch/arm/include/debug/cs75xx.S
 F:	arch/arm/mach-goldengate/
+F:	drivers/gpio/gpio-cs75xx.c
+F:	drivers/i2c/busses/i2c-cs75xx.c
+F:	drivers/irqchip/irq-cs75xx.c
 F:	drivers/tty/serial/cortina-uart.c
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE

-- 
2.53.0


