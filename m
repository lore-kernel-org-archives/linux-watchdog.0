Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7344A5C28;
	Fri, 11 Sep 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145957; cv=none; b=Ko8HX+DE0s+9adlN/XL/aixNQtlU7Bw2PnjDa2+0jV4siDTAEKiXm0FQXjxrYg7MlWvqMiHaHaNp88R9WrnQDSYuGVB9+W5tBlr2qJQLss1DoCWjqlQzeqUylhAcrCLURpYR+K/+GiiMkOaAr2+jDoPawAJoINgZYypmexPv/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145957; c=relaxed/simple;
	bh=IdOJLA73Cf6tiU+JKWKZdEv0XqkU6UkmQAdXKUD5Q38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhRuNG9Pp3XCr8BDAMDtXiOVOSyb/bd0DrTgLZxu/FaHpc6lS9oyllf9oKsDXvE+N//2GTz3mYySz6B4CTQTmSSz9dyxDb3LXOKZf1pXYTwcWGQ0y2AvKldaMdQsKXHTr8iY2qEPULfU4oe602o9h3/SV6BRkh6Lrda5FN79qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=QO96gQgv; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="QO96gQgv"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRh1SLhMiStwGt9nJg+3zWmBJZsQViVNXNAHf567sjs=;
	b=QO96gQgvJK3AcAfDBNzqVilkvuyE1sq07mFRJ3aH+WgzpTZfcHKsfHY918Li9ziYcjjS2F
	hjHve62MjiDeNkL/S7BoRIDT9o4BK/jGLTPFoTyITakpZQ5/rqB9WO+vZQb3Tzu/YKspJo
	V1DIQ9dVy6yYgg39kg8bvbVoipzTfbo=
Date: Fri, 11 Sep 2026 18:58:38 +0200
Subject: [PATCH v2 1/7] dt-bindings: arm: cpus: Add Apple A18 Pro CPU core
 compatibles
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-1-08d06cf011d4@cyberchaos.dev>
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
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Add "apple,tahiti-e" and "apple,tahiti-p" compatibles for the A18 Pro
efficiency and performance CPU cores respectively. As with the M4 cores,
there is no longer a generational codename, so we assign the core
compatible based on SoC codename ("Tahiti") plus core type (E-Core /
P-Core).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index c328e9fb9843..5d79da63301b 100644
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

