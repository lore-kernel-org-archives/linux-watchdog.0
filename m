Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088219;
	b=wW6YjG1ezq2Fz0mx5BYIx3lA78hLIT0YLqr7SHGCIjh5PXCzfK+YOynT03nfnYE22fLm
	 ceP1oT96M8/DQ3K2JI+u9KlmmeO7oxIBr/Orwq1QEdalzKvRUQgS6BGonNi2giwlt1Aqi
	 TCgjqPAoqHnrYI4SzxgtppkRU3X9vLOIRSZuJ/UU3eVqmpOaw2LIoxmQ2+2OvA+GAAzBd
	 Y2A0C89pUnaU3wl1Tcvz8N3XbN3Uig0wZJP9wuCK+E+IXkfmuq6a4qSfFSzBlW/4YCXls
	 5v72pVZA30+IsxNSs1QZLwHZA5fSQTBxa+2Ea2X9ToH/KkYl9feXqKI37ylxkmeZ2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088219;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=M+T0hC9qrCnKMLXzTWrirmR4GKkGAo6lPil072JQfaQ=;
	b=Yw/CFrLE8XcEhlQu9LAVK4f7cVGgcV4gaWXidnwm4RFQF9829p17VKYsoRdX7cwCCtZE
	 c/l5BD2fuIwAdYXD9aSn34g/oGpIvtfOZVKCQCVllhfSL9qx/UvGkpWVH9ppAW9Xd6QOy
	 7HNHcMuL7LwSzy3qg24QicSKE6sOFU0jQ6WlrGbEqUMluTCq4WQc1XQ57cijZVLmkQ0Yz
	 YEl7gg08uhs49QOH0TOd8a+ZN83wluCs+QEldy9co3PeF4s7y3SB3DIlKwA+MwFPSBgv8
	 pqoGefnwd9iyiMPDJRZjMi/qSt1LIDABajjWOc1f4ET6JWP3fZvXH5atGEDx4hkqiag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=hUihcgUI;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820E606A331;
	Tue, 27 Oct 2026 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3820E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=hUihcgUI
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+T0hC9qrCnKMLXzTWrirmR4GKkGAo6lPil072JQfaQ=;
	b=hUihcgUIKp90fzJfjXVAvgy/V68YRR/SF+h2npLlz0wwWPEhxScAYNZHaNmCEQ3flbPrfl
	4GZGUZc3Fq//7lD/9M/p+C7/7y/vbHbEK4UGg43aqXpbEQt+sFaolNakwX8VlvnfnndNno
	zf0pY+cd+sQd74ExgFg+kmYKH6c5Qvk=
Date: Tue, 27 Oct 2026 09:03:22 +0100
Subject: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2: Add
 t8142 compatible
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-2-1356181bc50d@cyberchaos.dev>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
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

The Apple t8142 (M5) SoC uses an AIC3 as interrupt controller, same as
the M3-M4 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index 3c2b24be530e..b6ad9d9192a2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -49,6 +49,7 @@ properties:
               - apple,t6041-aic3
               - apple,t8132-aic3
               - apple,t8140-aic3
+              - apple,t8142-aic3
           - const: apple,t8122-aic3
       - const: apple,t8122-aic3
 

-- 
2.56.0

