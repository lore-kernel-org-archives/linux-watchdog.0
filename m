Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187F4AA3E6;
	Sat, 10 Oct 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651597; cv=none; b=BCLZn07z/ZR74p+kSMRHkodOu1nYtXLB/FiZzlm4J7ztsjFKVS2y0MFgEc/hOvKfgIqSQgnqtMuZn5oR93bWyLlnp9UkxuCJRmrTpdlGTS5jFJHqJ23wi2v+sOwsUDqNuFXZg27l4FW9jBbowg2rkuzNo3Y67ULqcAUH9teFVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651597; c=relaxed/simple;
	bh=V2cHx6CIHnBDUHHPtnho8ZS4M09bBo82z9QgAArFhRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7YvUigPOv/Q8UMKsIc34ljwXw4JCAtx/OwpOe81KkeHplghf/vQkCEuDG97d8gJ9hRrF5ShFfhSXGDIYZE0Yhf45hOV8DYgumuS0MIyZRqz86sy2lqaxzVMguwgiCeXoI+Q29OtXj85fBoIY6sdYFZCGi5AP6ucvROyqerbyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=WcrRAnrU; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="WcrRAnrU"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKwJEYJc55avDF5EDYBghFpthMasg3S3FXg070PLg9E=;
	b=WcrRAnrU6cTo/SYlMUU2Xi+DFivWUv/UJfPSdoyNoFtoKr1sSzIJQyAGaZ+hMt7J7IyNH3
	iKGut4gGIpqrK0GKL34+6VJM7D3dBKv/G+mwcFjb85pzas0CyCb9pXNKWpc7HmnitovYHk
	7yUjCRDG2JR+BrVd4tzFTmYkzRS8b50=
Date: Sat, 10 Oct 2026 18:59:30 +0200
Subject: [PATCH 09/10] dt-bindings: arm: apple: Add M4 Pro/Max based
 devices
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-9-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
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

These devices were offered with M4 Pro/Max SoCs.
Add the corresponding compatibles:

- MacBook Pro (14-inch, M4 Pro, 2024)
- MacBook Pro (14-inch, M4 Max, 2024)
- MacBook Pro (16-inch, M4 Pro, 2024)
- MacBook Pro (16-inch, M4 Max, 2024)
- Mac mini (M4 Pro, 2024)
- Mac Studio (M4 Max, 2025)

No iMac with M4 Pro/Max SoC was released, and the Mac Pro was not
updated in this generation.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 7c3e7131a5e7..8e55510e44e1 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -144,6 +144,14 @@ description: |
   - MacBook Pro (16-inch, M3 Max, 2023)
   - Mac Studio (M3 Ultra, 2025)
 
+  Devices based on the "M4 Pro" and "M4 Max" SoCs:
+  - MacBook Pro (14-inch, M4 Pro, 2024)
+  - MacBook Pro (14-inch, M4 Max, 2024)
+  - MacBook Pro (16-inch, M4 Pro, 2024)
+  - MacBook Pro (16-inch, M4 Max, 2024)
+  - Mac mini (M4 Pro, 2024)
+  - Mac Studio (M4 Max, 2025)
+
   The compatible property should follow this format:
 
   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
@@ -434,6 +442,24 @@ properties:
           - const: apple,t6032
           - const: apple,arm-platform
 
+      - description: Apple M4 Pro SoC based platforms
+        items:
+          - enum:
+              - apple,j614s # MacBook Pro (14-inch, M4 Pro, 2024)
+              - apple,j616s # MacBook Pro (16-inch, M4 Pro, 2024)
+              - apple,j773s # Mac mini (M4 Pro, 2024)
+          - const: apple,t6040
+          - const: apple,arm-platform
+
+      - description: Apple M4 Max SoC based platforms
+        items:
+          - enum:
+              - apple,j614c # MacBook Pro (14-inch, M4 Max, 2024)
+              - apple,j616c # MacBook Pro (16-inch, M4 Max, 2024)
+              - apple,j575c # Mac Studio (M4 Max, 2025)
+          - const: apple,t6041
+          - const: apple,arm-platform
+
 additionalProperties: true
 
 ...

-- 
2.55.0

