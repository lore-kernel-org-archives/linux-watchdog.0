Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C553939B0;
	Fri,  4 Sep 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551408; cv=none; b=rSvw7zAG5z3UZlbuc2X29Mb2EIWp0vTq6O91vgG3eMKP5tj3nfUGlLeYA+2F9rA7/5nbSxUPjS0oCGEM7LWcc7DzMfqtzI9WHGQL9XfhQVQu3vwKHkJONiGzRFPcqZTlphPOlkEdvHO3b47nGy7qYLMQ+C36lbXokxDys0q3zMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551408; c=relaxed/simple;
	bh=CXj+icXWNtP+kWIdP0einQIx1r24LE2szcQxXlI1FL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhF3I2QlmOaP7P5IneeW2Lrb9a8030tZ9Lw94U3y0SdSRT+Huc3wcUnkw4eb/i22ANq0EU6vSOoy/pFBcu7GtaFrb3Dx//lNXjB3luwDk8TMOPs2rO3dteSFx45EPwUas+p4X6pYzIDbi27mzCV1++B1aVJHTGc395PyCMk2KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=nVRBG4E/; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="nVRBG4E/"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788551398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03++u1hMJUN4CZOnETD7tedBCxAbjIXy0LEGbGeWhRE=;
	b=nVRBG4E/PeFU3TVNNZq9jmhM9oC8orfOE0SM/nLoLI9Jb25QDoa6i/Z385rmKqw9oAn04E
	ZQb/PGvX0RxghI3/613mbbsW1lLzjYEZZUxzJaiQj7kBaR9CL8FM/DbiLcWh1/4PfRtRNs
	Abjw+at8jUcdu38LoKyZQkMtsosmC2o=
Date: Fri, 04 Sep 2026 21:49:38 +0200
Subject: [PATCH 5/6] dt-bindings: watchdog: apple,wdt: Add t8140 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-a18-pro-initial-devicetrees-v1-5-0c25401d165d@cyberchaos.dev>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
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

