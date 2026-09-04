Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8A388E43;
	Fri,  4 Sep 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551402; cv=none; b=P9UqmX8vn/+4vPGvvy5bDbW7ov0wdew/crhC1Rfl5nEDZJfspooa87IGJ4/cbUYslADJFo76+b+uoro0qkPKuKslBZ/2C+5KjoiYixlp3sf58/DIeo6NyH9IjQNtYeXRSBu7ATWLTjCrnX3osYWid5FBrKwUZLHS1AE2pYhJK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551402; c=relaxed/simple;
	bh=rI32QZw98we+ntHwY9st1ekgx9DWK4kBa8XWenvbwZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYvWkOYjQrumHalGe/ayRK7LnQO7astxSzGr4gLi/XMMvbQDpUQtGN+5Ck2XNsp8ZXNEz0ABHftcG7WqNSQENiOilIwoHXCM+GBSPX1TYyLRUq2hwQv/87hsM2TOd+QTZL6GHnml3O60TxsbCgtMF411Yh74akguc/lazlonDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=tVWtVHW0; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="tVWtVHW0"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788551392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9kPiXnFYja0TaA3Fv1fam8HrPrCv5WaiJ5ki+auGng=;
	b=tVWtVHW0ZeXN31E9KQgHkWz7KBNDJKy3pQ3XooH4GfStsHTHFsi8g0AR8q4zRzn3whVAoH
	EVG+zXPWYhyRU7Yktd+LEC/4FG6CzJcOCQXO6zXTYcAdhZxxZwjZxaEovzcbkyU/L8q3X/
	fx3kHwcNZIKTXc9SuVHqtOO0TeVnh7g=
Date: Fri, 04 Sep 2026 21:49:34 +0200
Subject: [PATCH 1/6] dt-bindings: arm: cpus: Add Apple A18 Pro CPU core
 compatibles
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-a18-pro-initial-devicetrees-v1-1-0c25401d165d@cyberchaos.dev>
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

Add "apple,tahiti-e" and "apple,tahiti-p" compatibles for the A18 Pro
efficiency and performance CPU cores respectively. As with the M4 cores,
there is no longer a generational codename, so we assign the core
compatible based on SoC codename ("Tahiti") plus core type (E-Core /
P-Core).

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index c3facc98bf83..9c02cc7e4b37 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -95,6 +95,8 @@ properties:
           - apple,mistral
           - apple,monsoon
           - apple,sawtooth
+          - apple,tahiti-e
+          - apple,tahiti-p
           - apple,twister
           - apple,typhoon
           - arm,arm710t

-- 
2.55.0

