Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088219;
	b=wS4IpN+trTs/WuEB2NcAwMEkCWWV4tVCZLeH55/F6XVBPgSyD0d0jc1EQ7+4TrzUZmdQ
	 6knkkvSUWmyT8Uv3IJKQYoAxFtRsy8wAzJyqsxOV/EeHLr1QNFklqbIEeoEMZ6eyg8EGi
	 EucPoH2X0LRQeBYbfNh/bCjoQ0QMyGbWl5Q1CZxgFZj7gJkeL9/B0t4WHHkQQIwepEhYa
	 MngcBOyhorJqPf46pNiyBl+/1clbP/ntOHHEvYbw2rPoR7NO90ey9X4W7D7XmjINN+36t
	 EcMbhHGLpNFvmaPfVjarE/c5cNtc8murcW2peEgcxWtU0lEA5UDsQMu7d6e0MWz8pig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088219;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=Xd6NZ4k5ZIVUi71tjBF1YXBwfdFJEiHzXxxQAyEHsDQ=;
	b=LaoogXKxLYkZm5TEqnFcC6qs4tSaLr7lcZ8ExEIyVWq7Em515t6mDnFkJZlsKoNmGt63
	 CBDfciO+wwt8OdxjYmOOQ20R1x9LMKlDVdXUoEbO2H66Nm059CKSLDVmaky005S9qMiwN
	 LDC2GCJy74n4I9BB2sg5aiS+5tQfrBc+AMaKvtBkMRBXqQELuO5q4CFKRV5Ub4zottpMI
	 h2v3otL+CTiB8Qbir+YP7fIv7+nEJXt1hdJAZkk95cwI0OAE6AB3I73VeguJ7zPSZM3ne
	 hY9KBAWjXW275p/iokVZqnqU6NxuyNVwnhqS332QLOEv8mjkw4XvoocWuzKOBb1jfBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=V4ZneEwX;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822F606A332;
	Tue, 27 Oct 2026 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3822F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=V4ZneEwX
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd6NZ4k5ZIVUi71tjBF1YXBwfdFJEiHzXxxQAyEHsDQ=;
	b=V4ZneEwXI+ZU7aWPf3J3ahFZYELK6rDrQZWBrIOeEgSF2byh+G7ULtAfdkWS1BvpVHbSR0
	sM+ekVDFHsmAfk9Crhh6VbH5v6u/CIV5IAtX9DDKtOb+tiT2m2oh033eEGE8tQlr6DTtX7
	p6lv5gPCu6OOefLamgjDcqVfDT299iw=
Date: Tue, 27 Oct 2026 09:03:23 +0100
Subject: [PATCH 03/10] dt-bindings: arm: cpus: Add Apple M5 CPU core
 compatibles
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
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-3-1356181bc50d@cyberchaos.dev>
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

Add "apple,hidra-e" and "apple,hidra-p" compatibles for the M5
efficiency and performance CPU cores respectively.
The compatible strings are chosen based on SoC codename ("Hidra") plus
core type (E-Core / P-Core).

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index aff78fc331c1..beac0ac196a2 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -92,6 +92,8 @@ properties:
           - apple,donan-p
           - apple,everest
           - apple,firestorm
+          - apple,hidra-e
+          - apple,hidra-p
           - apple,hurricane-zephyr
           - apple,icestorm
           - apple,mistral

-- 
2.56.0

