Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221541D135;
	Wed, 14 Oct 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960985; cv=none; b=kfbYSly1xmLaohLYWrVwLvv8QnXpWpvh3NSXOufUMSMDX+rXACE1at8K/adPii60ebYvZIe2W8pPgf4loheiK62fOmxaTVh1aY2N+MFJdZSczZXndeI966Zx1gKGzEZqL5vKLn07LI4yMcDhi371aIcboOfiecGNg3O6hZi8dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960985; c=relaxed/simple;
	bh=pchHXEt1J4aJR0AWs0OX96hBjb602vhBljsRc6MgM7g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YhrvC1PWwsPKRfqgudG0/tXl6dD3RDZTv4RjMwro4O0FCA6anXz6vD+NY3HRj8J8s99+13zBGaic1vHDSM/bihF8jzMTF3D07/LdxEYBGI5WYc6KtV2blYdVONwcsLTYfBqNK6cdCl7Sseh1AJC4QNkLvrKTXhuPyDsWqLnnyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=cCZPlIQc; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="cCZPlIQc"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RFRhkU5N0xkY+h+ZZaHcxaa1ZMJtDptcbJ0QND+y2ZU=;
	b=cCZPlIQcPSnjvO680NjrZGy0BG6CEKO524p5wCykGaevyWasCNuGYmGtaMmcEvn9oM89hq
	b8zrbS8P0V+Gu2GfoUfdPbZV/YOqmP1DnY9rsCE4gp0zQ9NFmjghU0lItKy3GPrFV/OXmc
	+utiL/vJPVDjsmPooYSCUJ3YEf4Nl1k=
Subject: [PATCH v2 00/10] Initial Apple Silicon M4 Pro/Max device trees and
 dt-bindings
Date: Wed, 14 Oct 2026 08:56:07 +0200
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42PTQ6CMBCFr0K6dkxbDD+uvIdhUcpUxiBt2kogh
 Ltb0AO4/JJv3nuzsoCeMLBrtjKPEwWyYwJ5ypju1fhAoC4xk1wWgvMalHMDwusCzlt4qRlopEh
 qgC5da4weMYDOW5kbVaqqQpainEdD81Fzb74c3u0Tddyzd6OnEK1fjh2T2L1fpeD/VU4COJSVM
 G1uZFeb4qaXFn16woZzElmzbdsHS+3j9u8AAAA=
X-Change-ID: 20261009-apple-m4-pro-max-initial-devicetrees-c3b23fa7a88e
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Florian Klink <flokli@flokli.de>

Hi,

This series adds initial device trees and dt-bindings for the Apple
Silicon devices using the M4 Pro/Max (t6040/t6041) SoCs.

This series covers only a minimal amount of hardware, which is useful
as a basis for future developments. The hardware added here has remained
largely unchanged between the M3 and M4 generations.

The dt-bindings changes should be mostly boring (in a good way!). The
device trees themselves are roughly organized into the MacBook Pro
models on one side (t604x-j614-j616) and the Mac mini and Mac Studio on
the other side (t604x-j575-j773). I'm hoping to re-use these dtsi files
for the M5 Pro/Max versions of these machines in the future.
I applied some version of dt-check-style formatting to all new files
with the exception of the generated pmgr nodes.

Merge strategy:
Since there are no actual driver changes, we'd prefer to merge the
dt-bindings changes through the apple-soc tree once Acked by the
respective maintainers.

Thanks,

Yureka

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Changes in v2:
- Remove accidental t6050 hunk from "dt-bindings: interrupt-controller:
- Remove accidental Acked-By & Reviewed-By from "dt-bindings: interrupt-controller: 
- Fix missing "0x" hexadecimal prefix in cpu cache sizes
- Use _fe power domains instead of their disabled _cpu counterparts in
  Mac mini and Mac Studio framebuffer nodes
- Link to v1: https://patch.msgid.link/20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev

To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Hector Martin <marcan@marcan.st>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Sasha Finkelstein <k@chaosmail.tech>
To: Linus Walleij <linusw@kernel.org>
To: Mark Kettenis <kettenis@openbsd.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
apple,aic2: Add t6041 compatible"

---
Yureka Lilian (10):
      dt-bindings: watchdog: apple,wdt: Add t6041 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add t6041 compatible
      dt-bindings: arm: cpus: Add Apple M4 Pro/Max CPU core compatibles
      dt-bindings: arm: power: apple,pmgr-pwrstate: Add t6041 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t6041 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t6041 compatible
      dt-bindings: pinctrl: apple,pinctrl: Add t6041 compatible
      dt-bindings: i2c: apple,i2c: Add t6041 compatible
      dt-bindings: arm: apple: Add M4 Pro/Max based devices
      arm64: dts: apple: Add minimal t604x (M4 Pro/Max) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   27 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    2 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    6 +
 arch/arm64/boot/dts/apple/t6040-j614s.dts          |   24 +
 arch/arm64/boot/dts/apple/t6040-j616s.dts          |   24 +
 arch/arm64/boot/dts/apple/t6040-j773s.dts          |   28 +
 arch/arm64/boot/dts/apple/t6040.dtsi               |   65 +
 arch/arm64/boot/dts/apple/t6041-j575c.dts          |   22 +
 arch/arm64/boot/dts/apple/t6041-j614c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6041-j616c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6041-pmgr.dtsi          | 2297 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6041.dtsi               |  713 ++++++
 arch/arm64/boot/dts/apple/t604x-j575-j773.dtsi     |   47 +
 arch/arm64/boot/dts/apple/t604x-j614-j616.dtsi     |   65 +
 21 files changed, 3364 insertions(+)
---
base-commit: a8ac6027e82415f431bbba49ab535c44f2edaf4d
change-id: 20261009-apple-m4-pro-max-initial-devicetrees-c3b23fa7a88e

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

