Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF438423F;
	Sun,  5 Jul 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257460; cv=none; b=Hn+rTfFjZnVquqjkvikvoFRRnKKDTfM22mbllpD527wKw0JPUQg8869x9uQcJNWi3Ow6jdYNZT39KCHsdKML0B/i4isSVOZjSQ2EsI/XUi4GDBmRn38Tb6yT27o8sEH3hw6Th90DtYuoQotqp4YiUM2w8YvJPVB6XrJ8Akk9CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257460; c=relaxed/simple;
	bh=GW6W8CNus6CxiuLnANyQuRsFAHcpYVYE0SsvaqtSrAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1fRvvgR6/M8eQ8zJHVS35LKb233QH2QeFlCw1paY7klCXO9S1U+vzL6AuRy6ARX73hheOXOZu1tcYfbmbiTIPfrZkUxpoI+LRUrF/3ioSs8d5oCwSUS9EYzC24BU8jaIhvQta4lGhlar2Xulw1jEXDoaC+Izt+2+9aHY8hSGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=cvUbClnT; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="cvUbClnT"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvQUAUCwAfcZDX8PHBveczrclI+JvLBIutD5E9eHeUc=;
	b=cvUbClnTIcZskgU4JHtxxFc3LPdzucm49wvEX6rJARN+1wo0Xtd14UVkou93tVsslD4P/N
	UKbATiSe/guNgSOgKSrkI6sLbGW3IoeUVNj5l+sq0rqun2BprR2Mfooq26ZjkZqEYy6/Oc
	7vwOkQedMzOvA4+wG3FbWa1guQjCBV0=
Date: Sun, 05 Jul 2026 15:17:28 +0200
Subject: [PATCH 09/10] dt-bindings: arm: apple: Add M4 based devices
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-9-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>

The Apple devices with the t8132 SoC (M4) are very similar to their M3
predecessors.

In addition to the MacBook Pro and the various MacBook Air and iMac
variants, a Mac mini is offered again with the M4.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index e49403c73f9d..3262292252d2 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -315,6 +315,18 @@ properties:
           - const: apple,t8122
           - const: apple,arm-platform
 
+      - description: Apple M4 SoC based platforms
+        items:
+          - enum:
+              - apple,j604  # MacBook Pro (14-inch, M4, 2024)
+              - apple,j623  # iMac (24-inch, 2x USB-C, M4, 2024)
+              - apple,j624  # iMac (24-inch, 4x USB-C, M4, 2024)
+              - apple,j713  # MacBook Air (13-inch, M3, 2025)
+              - apple,j715  # MacBook Air (15-inch, M3, 2025)
+              - apple,j773g # Mac mini (M4, 2024)
+          - const: apple,t8132
+          - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:

-- 
2.54.0

