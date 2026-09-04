Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17A38886A;
	Fri,  4 Sep 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551402; cv=none; b=uJCJI8uf/TVhrCjQ8+weqecSaRsatx5opQhqrXhB11t/mnBEguYIsFW5CJuPqnN2uA3jJuXvMkNZCnzZ0feIKqcYNWkFwW6FY9VqrSwDlo3CCbzjC0rfFy2A/7+gH1bzLHUn3XkgSiJeZw7oFoqQ2dWoIIvVkcg08xxB5lX5fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551402; c=relaxed/simple;
	bh=vUFojEKSu4nojjRgLmjYvWl3R/nDR5Y5OLHePAnI3/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tTNH3Yp05VN1FsKu3wEKyOcY85mUPIsirNhkfn1YvKKcmgJf6Mo4xVM57jt1QQhoR2VwDXH46w4PtLKc4Kkqvty2uSRLouZgJ6eV0qRO6yy9QpOopV653NqsGJ2RMAWxdApkZkIfmLns7pOWCBcKI7E8/HUJ+7zUv9VmKHbgv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=ns7uE3Cz; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="ns7uE3Cz"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788551390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G6nu6f3eskigT1nHIrz3vKzjlgiwHqGKGUwb4qaTnQM=;
	b=ns7uE3Czw/EgAaPZFvtJLPWiG+VFAvLxP7ByO9c0YnwiUl9vQXEO6wzKexI24xL5FtFmRh
	D98+3xxZZRZJsEw15PH6EcwGX1wO4egXQFAlTr1LooqmrGFyOnN6Q4SF/bKn3/1mHMAQs1
	kV5sIq8M1Y0pg40d/J5+k3c4W697PV4=
Subject: [PATCH 0/6] Initial Apple Silicon A18 Pro device trees and
 dt-bindings
Date: Fri, 04 Sep 2026 21:49:33 +0200
Message-Id: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07RjKwyq/Yli0w6BjeNkWYkL4d
 8sjcePyJPeeMwtHlsmJIpqFpYkd910AeYoEPnX3IOAqsEji5BLf4gz0MDQEWl5hsD1wx551A1W
 4InlL5ACzXFUyUVSjEcEzWKr5szXu5c5uNC9Cv4qPhaX3GOJ+n/3aRbSVVZwf5Tb7G60vZIxEp
 ROsiildrUY7Auzbln0RTeqcgkUpymX5Apb9/531AAAA
X-Change-ID: 20260904-apple-a18-pro-initial-devicetrees-c457d127efcb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Hi,

This series adds initial device trees and dt-bindings for the A18 Pro
(t8140) SoC and the MacBook Neo (the only Mac using this SoC).
It only covers a minimal amount of hardware, but is nontheless useful
for further development work. The hardware added here has remained
largely unchanged from the earlier generation Apple Silicon Macs.

Similar to the M4 devices, changes to the m1n1 bootloader are required
to boot Linux on the MacBook Neo.
Also, SMP boot depends on further patches to avoid WFI and WFIT
instructions [1][2].

Merge strategy:

Since there are no actual driver changes in this series, we'd prefer to
merge the dt-bindings changes through the apple-soc tree once Acked by
the respective maintainers.

Link[1]: https://lore.kernel.org/all/20260804-arm64-idle-param-v3-1-d10f8159062b@cyberchaos.dev/
Link[2]: https://lore.kernel.org/all/20260811-idreg-override-wfxt-v1-1-1c71228d0719@cyberchaos.dev/
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (6):
      dt-bindings: arm: cpus: Add Apple A18 Pro CPU core compatibles
      dt-bindings: arm: apple: apple,pmgr: Add t8140 compatible
      dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8140 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8140 compatible
      dt-bindings: watchdog: apple,wdt: Add t8140 compatible
      arm64: dts: apple: Add minimal MacBook Neo device tree

 Documentation/devicetree/bindings/arm/apple.yaml   |  11 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |   1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   1 +
 arch/arm64/boot/dts/apple/Makefile                 |   1 +
 arch/arm64/boot/dts/apple/t8140-j700.dts           |  52 ++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi          | 771 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140.dtsi               | 202 ++++++
 10 files changed, 1043 insertions(+)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260904-apple-a18-pro-initial-devicetrees-c457d127efcb
prerequisite-change-id: 20260705-apple-m4-initial-devicetrees-f6ebb1c7a2cd:v3
prerequisite-patch-id: 11762ddf0be3ad407ea90e5b01a0856a57ce1242
prerequisite-patch-id: d303d5493a501b215f43bd1ff9d40a889203f907
prerequisite-patch-id: 15a6a7981c2a70392f0a4c3d2fe274785c69c045
prerequisite-patch-id: aa33c268df85bae717859a0e70ac2be14cfc9a14
prerequisite-patch-id: 2a38f6f2f025888d93b0092f1188541f38e96747
prerequisite-patch-id: 0ffe9857d951e317ec349ee50a7acf827ed94cc5
prerequisite-patch-id: 66bfdc68d5b66325495b07f256117afa2b5c99af
prerequisite-patch-id: 4752b7d602d93b04ed879c6eaf7161b3546ad953
prerequisite-patch-id: 88d22cb297f45d9044363727d74864ed4ad95eee

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

