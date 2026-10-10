Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B653C9EE5;
	Sat, 10 Oct 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651591; cv=none; b=TVS8C6qO8OgO0c38kvx3aPOv2Aeo1JHpzD8Vo6QmtY60aYTvrK0/FvPH4U/tgl0bEIk5CFmAhQV+05I/sdkZd6y1DGB4YLyrrgZWCKEn97Ejq5twlSz5Ib0nFD8KvMkLpXaiF/CchXP4DkAQRm3ZxZ/HXkmpM4fbuWSmnkwXyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651591; c=relaxed/simple;
	bh=8F7wkeiLXCmvIHB5hgWuGPoSDpqbd5Xc3K0BMKDdzpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XBFZcN1muyDm+dq4TrfaRcFhyMfl0gMzjeQH4zbCSlCoUdcyiaMBmqjDPYMh82owkyhWm1AukNrAdWzmz6ZB4MIUmxIFqL/RJMG2VUvYTOdG4NcRtQJqVrV9wZf7faxtFkM5LTZaDoA9882Ab2xA0YryscnU/JXk1f1izzGqjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=T1j59MlI; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="T1j59MlI"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fLXZZ1L151t45JkonBfBOtO5v8S6SRCwNhIl/Wras5E=;
	b=T1j59MlIQ02HMioEi8fSfn3jZTsHeZ22K09+7AWoJocubbDHljKcCSKRRhuhZrJo8cT9dg
	Bv6Kq6bxwDmCgsXblNc7hrQNX4dQKY5hbxaxlBMMKVTi5NA/Fke1E9wfx1DoYzinamUEkO
	ZM2QMKbpBMmatJxF1MdvGh3nZ2uAzoo=
Subject: [PATCH 00/10] Initial Apple Silicon M4 Pro/Max device trees and
 dt-bindings
Date: Sat, 10 Oct 2026 18:59:21 +0200
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMBCE4Vche3aTUoyir2I4LGXQNVCathoSw
 rtb9fgd5p+NEqIi0bXaKOKtSRdfUB8qcg/xd7AOxWSNPdXGXFhCmMDzkUNceJaV1WtWmXgoa4c
 cgcSu6W0zylnaFlRSIWLU9Xdz6/5Or/4Jl79t2vcPRsMu4ogAAAA=
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

 Documentation/devicetree/bindings/arm/apple.yaml   |   26 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    3 +
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

