Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133947F2EE;
	Wed, 14 Oct 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960992; cv=none; b=Q9ZG/0Vx2ugQo0gkQL7J0ZFoBV1mJDEyJkxuQQzaF+7EWRzEns0aUs8nRDj7fH5dRJviw2y0F038MIaqvkPkfEGGkBaZZe2EAr4KCt3SkBxbWNrDM83Cbc2yOCrMsYRhKpnYtgKaCE2wuZzGcKayOjgnsDcvuxY22mqya1ImgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960992; c=relaxed/simple;
	bh=n1vgz2umyB5wfeYXOcMEsHkBjIr52m8VhNJ+zvlco4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCyv0o5uY4jMADNMOBoF1zqPzWGxADeuJ07tmUjbeJMdi2mGv+r0kdomEeJeJT7FEGUSbRtwuHH/shQk4vZ3mjPi2ilcsL/zMKOZbGH70RYfP3NyD5G6+tG50AAOsczf3Bxqvf2oj9/4+VoPfARTXYRRy2bE/Rc24yg0tJCw3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=0oKN9JcT; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="0oKN9JcT"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4D8/exwtCTqGMf/c8iqAaxyXZTI2Vr6tJjNc+wCHYY=;
	b=0oKN9JcTE7LhpCmgCZyPLuWsvS4Yu6/00qWNRd0PMNmV4kzOI9tRDOaMGBX2YRvVoQGDat
	o0uyaXIH+CpeEUvMCMio3PLh5cQYAmqUoECKf20miCe+LV9lTyUv4M9huE1cqZ9ornf+cQ
	Jc+6gy8HllBCF+o9unO6xnj+ZgC+E4I=
Date: Wed, 14 Oct 2026 08:56:16 +0200
Subject: [PATCH v2 09/10] dt-bindings: arm: apple: Add M4 Pro/Max based
 devices
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-9-961edd8d661b@cyberchaos.dev>
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
 Documentation/devicetree/bindings/arm/apple.yaml | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 7c3e7131a5e7..da6f043ad07a 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -144,6 +144,15 @@ description: |
   - MacBook Pro (16-inch, M3 Max, 2023)
   - Mac Studio (M3 Ultra, 2025)
 
+  Devices based on the "M4 Pro" and "M4 Max" SoCs:
+
+  - MacBook Pro (14-inch, M4 Pro, 2024)
+  - MacBook Pro (14-inch, M4 Max, 2024)
+  - MacBook Pro (16-inch, M4 Pro, 2024)
+  - MacBook Pro (16-inch, M4 Max, 2024)
+  - Mac mini (M4 Pro, 2024)
+  - Mac Studio (M4 Max, 2025)
+
   The compatible property should follow this format:
 
   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
@@ -434,6 +443,24 @@ properties:
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

