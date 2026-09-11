Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA24A64EB;
	Fri, 11 Sep 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145956; cv=none; b=Av/y2GxF4aQudtrBmO2k/Ol8KtcwAHHDnWkXnAkXU/jbUzokkuHjboOmxSf+wtq1jWFdHC9JX5J4OYq1NgfFMFi5EtJO7GWDNt39Izm0ajTt4wnO3TgDGDPDe/3cd/d6lk3MON039xRZLoSFZR6ViUlPCH64WYGJS1Z6DX4zdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145956; c=relaxed/simple;
	bh=elc7WKWi1F0YB7bxaZ/ywv4IXKK5m81xTNzt4TQNReg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IzumEOp2RiBx7Sdbcewz7sBGoeO7eNYJy5j5SzhKgb7f3ZfPzhhHrKSTgCJ2HeewNOgcq8DZjfVKGgwIvfqjjV2j+FU6CYK4E9XXlmg0kIUHFRTzf+Sbh6U1ko4e0XhHlxzmC8xyHygaQeDU8AMJcAfh+cKacm7z01ELogQ1Tb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=HMluchDQ; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="HMluchDQ"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V2pzDXgQJTG2z18artCPOHnfkenDA9xNqA3wa8CBDNg=;
	b=HMluchDQPfveokt32jc3buWq13R7lpukUxlSzsabn+ukk9wYzX/z9MEriHsznweXkIcKW6
	X1llwW3G1XRQSW1aJojAIqb/gqhZTqz/l+SAzY9PB/m+zDUvkT6PXNTSUKlc3A8wvsw0py
	y2qpCR76CVl/nIvG2LdGbpw8N90Gk4E=
Subject: [PATCH v2 0/7] Initial Apple Silicon A18 Pro device trees and
 dt-bindings
Date: Fri, 11 Sep 2026 18:58:37 +0200
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPyw6CMBBFf4V07Zi24aGu/A/DorSDjCG0toVIC
 P9uQRPXLs/kzn0sLKAnDOySLczjRIHskEAeMqY7NdwRyCRmksuSn3kOyrkeQYkTOG+BBoqkejD
 pVWP0iAF0XlRGyApb3bDk4zy29NozbvWHw9g8UMfN+Kvw+BxTePzJOgrR+nlvNont+k+JSQAHr
 mWRc2FEWZirnhv0aZMNxyRk9bqub6OPH+T+AAAA
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
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

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
Changes in v2:
- Added " (A18 Pro, 2026)" to model name
- Fixed memory node alias inconsistency
- Fixed wdt and machine dt-bindings being in the same commit
- Reworded aic dt-bindings commit message
- Reformatted/reordered according to dt-check-style --mode=strict
- Link to v1: https://patch.msgid.link/20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Hector Martin <marcan@marcan.st>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-watchdog@vger.kernel.org

---
Yureka Lilian (7):
      dt-bindings: arm: cpus: Add Apple A18 Pro CPU core compatibles
      dt-bindings: arm: apple: apple,pmgr: Add t8140 compatible
      dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8140 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add t8140 compatible
      dt-bindings: watchdog: apple,wdt: Add t8140 compatible
      dt-bindings: arm: apple: Add A18 Pro based devices
      arm64: dts: apple: Add minimal MacBook Neo device tree

 Documentation/devicetree/bindings/arm/apple.yaml   |  11 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |   1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   1 +
 arch/arm64/boot/dts/apple/Makefile                 |   1 +
 arch/arm64/boot/dts/apple/t8140-j700.dts           |  53 ++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi          | 777 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140.dtsi               | 205 ++++++
 10 files changed, 1053 insertions(+)
---
base-commit: f3f2d38a606edf92259aa5e57e083484798d7ea8
change-id: 20260904-apple-a18-pro-initial-devicetrees-c457d127efcb

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

