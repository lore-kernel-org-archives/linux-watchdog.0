Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07323955F9;
	Thu, 24 Sep 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259443; cv=none; b=mfZUxf+hlF5GRBsecRb/wlj5pT8bcfQw9bAUgKCuLDfYoJtEARxJ4Ho7g7cepZqURFn2LgL5On2Psiu6U24aSs3JJTPW6qG1efBkaw+DuKSPuKJ3dVEWTXWhif3obvvjncMoLgQvxg1JL4oIEwkdMH+DXDGWnUvzM+49mn4rC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259443; c=relaxed/simple;
	bh=EN42ADlzAnxR2iZ8PZSyc0krxLlAUY+AF84DX1vxH2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9LKgLoGF52AIxuMYcnp8iktUNRXFpQrQZHjhndXCycfD8GLYFiq12G+T6Dtl3r8Tps/XSW9yHP2kP28SMZgADFcY0gdwO839O+7v0lo12hxalhwTi6cSTP1hDIWNzx8z8jocR4ghmzUHaJptIvCZdLRDs0xM6GN0WV4y3G+UA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=dwZFwXSj; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="dwZFwXSj"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1790259440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gCuftN+XWPYlU01ueRBmJ4HFQ5xYw0hLT+h7rJW6g0=;
	b=dwZFwXSjfIkVxGdVDYvk+gVRYIOfMfKmMi+CXgq8uSh7y5XeowksoK9z1EOLwMTrYFI560
	qRtaRpx8yDM6IVJnrIQOR53RMeuF8UmII65/wWFOC3w68v/uLAh/GA8HeI4IpE0COpOtQj
	iFSzAC9gBdXhSdHbkMyM8LqRwBVZpY8=
Date: Thu, 24 Sep 2026 16:17:09 +0200
Subject: [PATCH v3 5/7] dt-bindings: watchdog: apple,wdt: Add t8140
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-apple-a18-pro-initial-devicetrees-v3-5-94f7ea52cc64@cyberchaos.dev>
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

The watchdog on the Apple t8140 (A18 Pro) SoC is compatible with the
M1-M4 SoCs. Add "apple,t8140-wdt" as SoC specific compatible.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

