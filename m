Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABD39A7F4;
	Thu, 24 Sep 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259445; cv=none; b=KEzw+so6gYLehjYNq7mWbdKx7eaeOGm1myaX8Kzwrmz181jN5INVJSBEtiFoIUUiXyDI/a2IpsIaPcPMlfIksqoW3YIt/EHXRveCXiFbv62OjwTPzDcKTf/8Uv26rwxfr0VT5u6MsQ/6soDQK+shTjzqWwEG4J3FMaoGkrKffyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259445; c=relaxed/simple;
	bh=H/POx7Wr/7K5KCoCcuDRbIScU2n4j22o9W8L9XzXnZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRaLa3wf+nnuGjMW8Yc0RwT3rkQJr5sp1UaC5vi+MY2JyRkq9Szo28RRzYdiAqMiX+Nuu7qULpHLjlv/ZxEP+cJ1E7euevuKvrghlJUYJzfEr6Mb/L9ot+kwjAUDboa4q5E7x8IDy9rJu4yFveCAdFVCgb+U/xQe3UlAeRVvRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=EDwEaAJh; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="EDwEaAJh"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1790259441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeqnfkBwbS9FJAo4v2yybtoxBaLCPa8f5A+nUsmDogk=;
	b=EDwEaAJhLONtR9yBUMnZ304yVtgfHiqtcAXyZQ86vzWCaBALdrkjXBfXSBVL3bb9UJ+m1/
	KfmiMRShNbuLypH+Yrbx0R1M2Squ2UDN/HFAUlZOCZswladN/nN6BzOZtiXsXKrk9Fd+ya
	OKUaiY9TowAy3/pjw+WHkcq/Zgt4V5w=
Date: Thu, 24 Sep 2026 16:17:10 +0200
Subject: [PATCH v3 6/7] dt-bindings: arm: apple: Add A18 Pro based devices
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-apple-a18-pro-initial-devicetrees-v3-6-94f7ea52cc64@cyberchaos.dev>
References: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
In-Reply-To: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
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

The MacBook Neo is the first MacBook to use an A-Series Apple Silicon
SoC. The MacBook Neo is overall similar to the M4 series devices.

The iPhone 16 Pro is based on the same SoC, but Apple does not allow
users running a custom OS on this device.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 5d87a4fef193..7c3e7131a5e7 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -82,6 +82,10 @@ description: |
   - iPhone 8 Plus
   - iPhone X
 
+  Devices based on the "A18 Pro" SoC:
+
+  - MacBook Neo (A18 Pro, 2026)
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -300,6 +304,13 @@ properties:
           - const: apple,t8015
           - const: apple,arm-platform
 
+      - description: Apple A18 Pro SoC based platforms
+        items:
+          - enum:
+              - apple,j700  # MacBook Neo (A18 Pro, 2026)
+          - const: apple,t8140
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:

-- 
2.55.0

