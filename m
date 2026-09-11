Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113D4A68A0;
	Fri, 11 Sep 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145972; cv=none; b=aoYhp6R7FtzH4KeS2q5q8FH1ixp4nsAffuPLr93ebhNeOt2RmbMeKC0rojP24HWeMpXna1dmqz6f5GY06ffwIBqamUAl4V+sseAYtX/hn1JO6LokZ8zNqGBynBcBhAEj+E6WdO+5gd4uo3PYk1TR5qnN6BCMvaSzIhwf/YVoiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145972; c=relaxed/simple;
	bh=CXj+icXWNtP+kWIdP0einQIx1r24LE2szcQxXlI1FL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dw6QRvLkTG186DlaH9U1OTBDoarjHp6crtWXbvZiHXQ8wGRKJ0UBMY3wROtVYtniFRb55vkMR4BCpi7FommPuQxkiakkrdzzJz6IFkLIrUVIR2qA8FuPRxP3/m88AljaeDp95iH0Cw0RpYs9WEFXJWkZIQVJIEt0mtRHvU0iG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=2ow8XYnl; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="2ow8XYnl"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03++u1hMJUN4CZOnETD7tedBCxAbjIXy0LEGbGeWhRE=;
	b=2ow8XYnlexIJTa++XuE6SrigvBbIqOQNk/EaVKNguwGKckb1wqBunE+9Qu9U/VqIUE8MY5
	vl1AyOhE40hmaFQjEMshux7J76r3mAs6rN5uCTvI+ehsChbGpG+NvcmcwCxhSPjsGNFDZF
	KywPxcUCYNzr2I41U9zlyaRLa0F1M+Q=
Date: Fri, 11 Sep 2026 18:58:42 +0200
Subject: [PATCH v2 5/7] dt-bindings: watchdog: apple,wdt: Add t8140
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-5-08d06cf011d4@cyberchaos.dev>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
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

The watchdog on the Apple t8140 (A18 Pro) SoC is compatible with the
M1-M4 SoCs. Add "apple,t8140-wdt" as SoC specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index ca4cf01db59f..1af924157f7c 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -22,6 +22,7 @@ properties:
               - apple,t6031-wdt
               - apple,t8122-wdt
               - apple,t8132-wdt
+              - apple,t8140-wdt
           - const: apple,t8103-wdt
       - items:
           - enum:

-- 
2.55.0

