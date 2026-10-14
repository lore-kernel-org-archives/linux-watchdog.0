Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AC47141E;
	Wed, 14 Oct 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960987; cv=none; b=g66zTCYiA5D/tUPP6fJmtqM9Sa8wy5caeZW6/nA4OW9udqAowKQ5DMud2csTqELaSEh8P826EZAliV3ZH5phwiF66oGMviGx9KyZ9WkRVLoghCiNED/WsI2rlaeqtz0qt0vW554VfM3V1NKyxmWHwNE4neh+uQ+V+zLEgeM46dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960987; c=relaxed/simple;
	bh=JIF3PfnEZtEAOC/gjKIJJfAtTAAX0Wcvin8jOshDjhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oqc6ygZY8DnmMzpVyLKuGi6DKVQtVf9wuQp+gN4DwjOn2iVpHoN1eDlqqR4hMR/tm59f2M2Np5oG60U3ufVmXnDe/tc/GQltSKp2A6OxGMkXy5ihWbAFIbv6HwEXAxbY6Hacsw7IHWkgUCAA5REj/loiPIpKmIAN91hEi3Z0o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=ewtApc37; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="ewtApc37"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0e2xAGWSt5cTDmnhY/Kf0rqC98uB8drPok4JKg9Zrg=;
	b=ewtApc37yl1BufuzBRMMeZEfySQO+80+x2cv1pbc1qaOl5FSwwvzaLEL4GnGyC3bNMijxc
	FDcmgLIfAy2gGeIFQwEvNcaUFOkCK6++OO4PN+MeSBswGth+OXE0kSUAhDBAWPIuu4mpkH
	K7E+obS1xYvRYMtxtv8lKuVKXksNMCw=
Date: Wed, 14 Oct 2026 08:56:10 +0200
Subject: [PATCH v2 03/10] dt-bindings: arm: cpus: Add Apple M4 Pro/Max CPU
 core compatibles
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-3-961edd8d661b@cyberchaos.dev>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
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

Add "apple,brava-e" and "apple,brava-p" compatibles for the M4 Pro/Max
efficiency and performance CPU cores respectively. As with the base M4
cores, there is no longer a generational codename, so we assign the core
compatible based on SoC codename ("Brava") plus core type (E-Core /
P-Core).

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5d79da63301b..aff78fc331c1 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -85,6 +85,8 @@ properties:
           - apm,strega
           - apple,avalanche
           - apple,blizzard
+          - apple,brava-e
+          - apple,brava-p
           - apple,cyclone
           - apple,donan-e
           - apple,donan-p

-- 
2.55.0

