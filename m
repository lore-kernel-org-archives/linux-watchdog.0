Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088217;
	b=iNGm+jZ+ofccbTuwuUGzNAGNKfObbUbTFflvcsHFZVj+v/jG2ckdbSRIY9P/9OtZjf+Y
	 GfWrbc1U7O3doKj1HMn909zdNNDHvJbCKfEebO9mPFG748bRoF2BiXis7P/btzg6a7SAa
	 c2qZC/3wQlMQvr/St1PpEb25l2M3w8D5XDbMv1rlBb7yYGM7uOIgu/UChEZr3jgXZEQ7G
	 SKyQWXTv3jpyDgUg3foxSERSPJL/9FAqZcQjxhEW1zJsP1WfCNX9Zu1y5pxs6JPypqe+9
	 EhKya3YoNv0RxHkAtOvNIKEOyWUxWgLmTeVCKCwJwOKSn7XkEawR5Z/Df2pOjbsR41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088217;
	h=DMARC-Filter:From:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=P5c0ApmIJ3lAMNaYphnR5Mx0YPPl4nsPPZL16lmRKXY=;
	b=ipvDWlbYkazXee1tonHzIZ5RcZ+Yv8reIlM0JhzsVQlTtE2foD6GaKPRSw61dia+3HDN
	 n6Z83ELSLRaVF1hjosSa6Kj8aie6Z4KK4e0uhXLEiZUAhx7wdtJjPTOJSl9ZjqSU54F20
	 S1SviixC5gYPbqXVR+BfSt4QVI+5WRl9rKzoXk8ArC1m1gAP4ohhMvSVUMbfdINe9HAoB
	 LWpW4FgyG35vaO7mfUOJSNdMTJ79toKgJM1KezOkmb5wFWqCJghy/0OtIcW9IewGQ5r86
	 92Y3OT/3tJfpeHhkQ0xg4eh53DfpY877ScKImV1dhHUuu4SjeHj7ugFa97VP2ZX7xOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=crVEQopE;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDE606A31A;
	Tue, 27 Oct 2026 08:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9DDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=crVEQopE
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5c0ApmIJ3lAMNaYphnR5Mx0YPPl4nsPPZL16lmRKXY=;
	b=crVEQopEfm3vY6etwK7PdIB3SmLmyRWj8Epua/Soc+v5Rbpb7o+MA91lYVv9dA4lORKBQw
	4mjWnEQToB5OR/G7JHCcBrdfWMV83H8c0Esd3NJdj6D0SCOe0QCqPkKB5TaoHXvSMDQs/P
	EUuJISIwf1ADXGzbly7QiU3Vl3vIuls=
Subject: [PATCH 00/10] Initial Apple Silicon M5 device trees and
 dt-bindings
Date: Tue, 27 Oct 2026 09:03:20 +0100
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBG4Vcps3YgqbZSX0Vc5PKrIzWGTBSh9
 N2NuvwW5yykKAKlQ7dQwUtUHqnBbjoKV5cuYInN1Jt+tMaO7HKewfeBJUkVN3NsVUAtgPIuwvh
 pP0x+66ktcsFZ3r/98fS3Pv0NoX6ftK4f2RlBo4AAAAA=
X-Change-ID: 20261016-apple-m5-initial-devicetrees-4de0b9759b3b
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
 Yureka Lilian <yureka@cyberchaos.dev>

Hi,

This series adds initial device trees and dt-bindings for the Apple
Silicon devices using the M5 (t8142) SoCs.

This series covers only a minimal amount of hardware, which is useful
as a basis for future developments. The hardware added here has remained
largely unchanged from the earlier Apple Silicon generations.

I applied some version of dt-check-style formatting to all new files
with the exception of the generated pmgr nodes.

Merge strategy:
Since there are no actual driver changes, we'd prefer to merge the
dt-bindings changes through the apple-soc tree once Acked by the
respective maintainers.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (10):
      dt-bindings: watchdog: apple,wdt: Add t8142 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add t8142 compatible
      dt-bindings: arm: cpus: Add Apple M5 CPU core compatibles
      dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8142 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t8142 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8142 compatible
      dt-bindings: pinctrl: apple,pinctrl: Add t8142 compatible
      dt-bindings: i2c: apple,i2c: Add t8142 compatible
      dt-bindings: arm: apple: Add M5 based devices
      arm64: dts: apple: Add minimal t8142 (M5) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    3 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t8142-j704.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-j813.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-j815.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-jxxx.dtsi          |   50 +
 arch/arm64/boot/dts/apple/t8142-pmgr.dtsi          | 1131 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8142.dtsi               |  512 +++++++++
 16 files changed, 1830 insertions(+)
---
base-commit: 498a03715b45515444fe1fc6d7b34177cafb6c38
change-id: 20261016-apple-m5-initial-devicetrees-4de0b9759b3b

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

