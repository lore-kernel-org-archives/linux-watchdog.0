Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC823822A3;
	Thu, 24 Sep 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259437; cv=none; b=EkLg1WEsN7JAClkHIIA1TxrTK77nmklJONaLWbERRyXAQM6O87EKlLqTubhOu+MdWG4HwqV9jr3euErFF9NkuKif7ZgwnCmwONvK2f7MqsWUY1nzrhCKOmXSBxfLzm6d4czUAS/FwESnZKhnoFIToTKXL/9U3giVv3WyAMO1Aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259437; c=relaxed/simple;
	bh=RzaoDxfs8TtbNZRYD/n61tNpayQjwnQlpxtCVGpaTJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s2CR7fojKljTrDiAc9JU5hNlHgEgAnOcnVVO0BdRZyoioGORBI/x29GRiCfUW0629wJmHa77Pgwcl48Y79v2c9ofQm/fIOIPPCwW0k//yJa9ls6JJ/UgFr71hvyp85kj4/tQgmX4zZSO51zWqwQHQlKfIc5vkvWtBiPUMMZ74t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=gFoaIv5/; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="gFoaIv5/"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1790259433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=efEzw7LWloopRagtJOpmn/2eQbOHKy7Knyb992JBZcM=;
	b=gFoaIv5/8kHenRWWJaXAImJjzz3ORrwGo5gh04zQoMNGxZRljTfBLgBWZQxLXP5VhA10pp
	duPRYT870b5q0vKrc/Nm9w2542gOsBvXTnot6v/K0uo95d6kqlN6aD1BpoOiLbWscwCcLG
	fwYWCbCmu37QUQWmSogxQKMdqGv2ALU=
Subject: [PATCH v3 0/7] Initial Apple Silicon A18 Pro device trees and
 dt-bindings
Date: Thu, 24 Sep 2026 16:17:04 +0200
Message-Id: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPzQ6CMBCEX4X07Jpu5U9PvofxAO2iawxgW4iE8
 O4WNNHEix5nM/vNzCgcWSYndtEoLPXsuKmD2Kwioc9FfSJgE7RQUqVyK2Mo2vZKUGAOrW2Aa/Z
 cXMGEV03eEjnQcZIZVBlVuhSB01qq+L5kHI5P7bryQtrP4JfD0q0L4f5tO7PzjR2WZj3O139K9
 AgSpFZJLNFgmpi9HkqyYVPj1sEo5ohefWARf8GqGZsbmepKIpr4CztN0wNMIbr1VQEAAA==
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
Changes in v3:
- More dt-check-style --mode=strict reformatting
- Fix interrupt-controller dt-bindings commit message: AICv2 is only
  used since M3
- Link to v2: https://patch.msgid.link/20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev

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
 arch/arm64/boot/dts/apple/t8140-j700.dts           |  54 ++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi          | 777 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140.dtsi               | 207 ++++++
 10 files changed, 1056 insertions(+)
---
base-commit: eea4f3b5e9e19389af3b99af64cdf7352b67c298
change-id: 20260904-apple-a18-pro-initial-devicetrees-c457d127efcb

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

