Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7680381AE7;
	Sun,  5 Jul 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257458; cv=none; b=i0HMwX1jYBMmPVUXmY56Na4zRW+LQHiBIneSeDPPgO/VFdlRNb/UUFzPA3SVYcXyCnc/MA46MPoRQ1JUnDgawnDOcLqGVeL52uZxfcMbB9bCzTQWim5sMVKXG8F/vI8VdwNbWyuEGs0Aqir1m/AtAwHwLRt5dOB405jKKgSJf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257458; c=relaxed/simple;
	bh=D7Uyn7qmz7QETRTMV2mSIs6n9h1PEV3+JIsiEdj7+fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXICN5hBlo+VZM5IEBYcIJDocVmFIoWFq4gWvnfiaDiLo/gwv9eYfw/d2+s9LJ7OJt5SYoHYm1VoYwImZYOmHouIK5y7Nd76WxP5IaiMqsIMnu45R9yEBpDk4m2JQegBOgPqvB5eNojfFgwyyc45Acl4JRpQRpsSNFdcufMhLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=slVSOrn4; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="slVSOrn4"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gduy/AtSH7oZHtZSjmD3JijsgUcwsJ67NBS9jh3fBIY=;
	b=slVSOrn4DLi5tGv93JAAA1cXdJ0gDgl6DiztkQRtY9Cyu4bh33fVT4ZO0t4e+b+HC2ROeL
	MChlrJXHgVgvtGqZiTPsMsCG+ib5bv6uX4kRuJPa1w7/WyNKDoevGNrttq+DsMY53p8cE5
	pk50zCDwM3K7bzmZTLVzoqpW/7LlAyM=
Date: Sun, 05 Jul 2026 15:17:25 +0200
Subject: [PATCH 06/10] dt-bindings: pinctrl: apple,pinctrl: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-6-e5655ee56523@cyberchaos.dev>
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

The pin controller on the Apple silicon t8132 (M4) SoC is compatible
with the existing driver. Add "apple,t8132-pinctrl" as SoC specific
compatible under "apple,t8103-pinctrl" used by the driver.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 41073176bc69..ef106f9326f3 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - apple,t6020-pinctrl
               - apple,t8122-pinctrl
+              - apple,t8132-pinctrl
           - const: apple,t8103-pinctrl
       - items:
           # Do not add additional SoC to this list.

-- 
2.54.0

