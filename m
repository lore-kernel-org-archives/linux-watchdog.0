Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808974;
	b=wG9SbusT1/3bpe2OxQkRamJO11nozgn1kvIyfilCj89zmYEuDxQKjGflG/qmEPYcAqRE
	 LF6ltII20OH1S4cEInba7dp2xcvO1fjfoHWLmULdSbgUjmO/BxHvXo6pvsNbr8mEN9zmA
	 GnnPCHgnlgrs8U7NvyTymdtjK9AXKSXtNe67xO634zKzU9G/WAfov4FtCfmeliy0MjnxS
	 oZjbAOXD8a7UJFTy0witkKFoQd0CwlzJBarzBSLi0sGaeRGrw9Jbnkql5xm+fO1D8D/AB
	 Ki0gpCT1tQHYm5UC9o2mMqSazHDpdHHVtzhhEEGfWidiB8cBregI5heqhTmbioN99yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HJM7/PuFDUDOwqvZxCE1CMPyZQc4Y2DCZuVTcSLNH0M=;
	b=qtX1kiH0HBt8MfJ42asLJddW6bvZzIXTAzztK+U58f5OJRHh9z4YO7dmYZNfkzm3tQj0
	 IyO6yvTKedjraySbKyjNm7H2M8JvDlY/UPz93l4kRyRy3VeOZG1FgVuLdDa5URh07JZ5a
	 LFKv3pyh05amaKy0HnMyIYCCDHiGSLHegLzeqzMmv+I3H2lzufTU3oD9ajJ/mPrkQjc4w
	 zYoi9X0cqtkUasWOjYZowo8FcqvcmXwyLnTYUs+5fUDU7OLMqKp+RUlwPRWw6J356n0wi
	 VcjdUEvA8sDorbQszCYxhi3nNmLe3VD6BGkmbSPUM0d4SzJjyoBm292KTXhZcuJcLEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=bWYCGMD0;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E7606D838
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 551E7606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=bWYCGMD0
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CD4D4240101
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 17:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793808972;
	bh=HJM7/PuFDUDOwqvZxCE1CMPyZQc4Y2DCZuVTcSLNH0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=bWYCGMD0qJP+YwmDPWOA+XFnLEjJLabifZ/qVezj8x28+07HdAXuPlPE38aNz0+Es
	 njakRp7uW8MqLGLcvdXB8uIThbmyIkcX5Df9ndhLj5vTVPwr9X2Lz3HEzXURpdcP/T
	 lK2k7L1yud5POYULLH4HMcXeHF/1ARE07+i9veXB1QLLCOmKQKFiuzlWtSoCV2/I+v
	 ZmbpobO6RvHSXp+6E4qX+VEfcU6Gd93blhbP7LqznnUnTNXHaTcoY89s3RtZJwvt9j
	 85C1jM3CpNGEZgjREDgOv/O7tL7oPPrpIpYiN841dMwOR2sdHCy266bwcozhMtMx7t
	 FrjRqsA2QY2qA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKVtG5m16z6tyK;
	Wed,  4 Nov 2026 17:16:06 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Julius Werner <jwerner@chromium.org>,
	Evan Benn <evanbenn@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Marek Vasut <marex@nabladev.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] arm64: dts: st: list both watchdog SMC ids on stm32mp23 and stm32mp25
Date: Wed, 04 Nov 2026 16:16:08 +0000
Message-ID: <20261104161553.30115-4-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id of the SMC watchdog
on stm32mp2") changed the watchdog SMC id from 0xb200005a to
0xbc000000, the OP-TEE default for the platform. That fixed the watchdog
with such firmware but broke it on boards whose firmware still uses
0xb200005a. List both ids, the driver takes the first one the firmware
accepts. Kernels that read a single id keep using 0xbc000000.

Fixes: ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id of the SMC watchdog on stm32mp2")
Reported-by: Marek Vasut <marex@nabladev.com>
Closes: https://lore.kernel.org/all/1b14e1e4-962f-4391-91fd-b09143641643@nabladev.com/
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 2 +-
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index fefbf6f4f153..7526e86f5a1d 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -35,7 +35,7 @@ arm-pmu {
 
 	arm_wdt: watchdog {
 		compatible = "arm,smc-wdt";
-		arm,smc-id = <0xbc000000>;
+		arm,smc-id = <0xbc000000 0xb200005a>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dac3d2d23ff0..143d83216530 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -36,7 +36,7 @@ arm-pmu {
 
 	arm_wdt: watchdog {
 		compatible = "arm,smc-wdt";
-		arm,smc-id = <0xbc000000>;
+		arm,smc-id = <0xbc000000 0xb200005a>;
 		status = "disabled";
 	};
 
-- 
2.56.0

