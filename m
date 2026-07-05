Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F733DEE5;
	Sun,  5 Jul 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257455; cv=none; b=Sc20VlDjdNc3fGVBNWWhYgIfYhI+uzshNhZ6bHijEjrj9C4/pILGaR0apoUEh3j6eUV62Dluy1PibSJaUVJXTuKDYHtOzuCWiM1YW3IMkqagTQNv+05fSiWPVBg6yUdV15jCuI0lGtsVMNZDIfgRP0w8wYuwtH2EFoK9zqVlvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257455; c=relaxed/simple;
	bh=88WgTcQxIELrgXPhwOATMVGnRfncHW3z2HCk1A3KENI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TeeNNtTfLLdpr05gVn1B5OJJbdMoXOze9+qORasKUYN5m0oZ6jwB/LoggLzxpI1tOnRRQXjLiqvPdlIMgVuxQKrEXpkNMJDUgS05tHnKFcwbuhWufS4VWPAiHQsGOHlfyGeXmyVbo8NqSRZrij8r1tnvNtNsok8bgzI0iSsaAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=BAs3Kohd; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="BAs3Kohd"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D0MLfQhNF8T8fO41cpmP1lSHVOxzxRNWuMtKqBQpmUg=;
	b=BAs3Kohd3hdgr7zm9DPxh/rwI1TJQFF7YgEngCz1wn5FVQaLh3UP7Mv7zrm4SpvEGY7qk7
	0/3afM36i3+YsE9e1rLlkjDCiS83e+f3aggkQD8qSKpA/SxRuLAcv52W0PBpaPARycOdb0
	RE8q4aQgQ/XxRhtp8/+gdSi2ngdAIDg=
Subject: [PATCH 00/10] Initial Apple silicon M4 device trees and
 dt-bindings
Date: Sun, 05 Jul 2026 15:17:19 +0200
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF9ZSmoC/yXMywrCMBBG4Vcps3YgDbYFX0Vc5PJXR2oMmShC6
 bs36vJbnLOSogiUTt1KBW9ReaaG/tBRuLl0BUtsJmvsaCYzsMt5AT+OLEmquIVjqwJqAZTnEd7
 3YXI2RGqLXDDL57c/X/7Wl78j1O+Ttm0HefPGwIAAAAA=
X-Change-ID: 20260705-apple-m4-initial-devicetrees-f6ebb1c7a2cd
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>

Hi,

This series adds initial device trees and dt-bindings for the Apple
Silicon devices using the M4 (t8132) SoC. For the most part it mirrors
Janne's M3 (t8122) bringup series as it was merged in the 7.2 cycle.

This series covers only a minimal amount of hardware, which is useful
as a basis for future developments. The hardware added here has remained
largely unchanged between the M3 and M4 generations.

Most of the changes for bringing these M4 devices into a bootable state
have been happening in the m1n1 bootloader, which is no longer
responsible for setting the configuration bits (🐔-bits) of the CPU,
since these are now set and locked by iBoot.  

Additionally, SMP boot depends on the idle=nop patches I sent out earlier
today, and is still unstable, even with those.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (10):
      dt-bindings: arm: cpus: Add Apple M4 CPU core compatibles
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8132 compatible
      dt-bindings: watchdog: apple,wdt: Add t8132 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t8132 compatible
      dt-bindings: power: apple,pmgr-pwrstate: Add t8132 compatible
      dt-bindings: pinctrl: apple,pinctrl: Add t8132 compatible
      dt-bindings: i2c: apple,i2c: Add t8132 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8132 compatible
      dt-bindings: arm: apple: Add M4 based devices
      arm64: dts: apple: Add minimal t8132 (M4) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   12 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    6 +
 arch/arm64/boot/dts/apple/t8132-j604.dts           |   35 +
 arch/arm64/boot/dts/apple/t8132-j623.dts           |   18 +
 arch/arm64/boot/dts/apple/t8132-j624.dts           |   18 +
 arch/arm64/boot/dts/apple/t8132-j713.dts           |   35 +
 arch/arm64/boot/dts/apple/t8132-j715.dts           |   35 +
 arch/arm64/boot/dts/apple/t8132-j773g.dts          |   25 +
 arch/arm64/boot/dts/apple/t8132-jxxx.dtsi          |   48 +
 arch/arm64/boot/dts/apple/t8132-pmgr.dtsi          | 1125 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8132.dtsi               |  440 ++++++++
 19 files changed, 1806 insertions(+)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260705-apple-m4-initial-devicetrees-f6ebb1c7a2cd

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

