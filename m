Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA43822B5;
	Sun,  5 Jul 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257459; cv=none; b=LxkUFqcA6kRggoOoJ99kXEOMWpTLWHGoHOsDpYSkVxhZKwVKWGsot6rstTl5vMwt8OXnD1zaLgGVH91pyVsTt5Em/XVMF76bivkd4T4/B+LdTm/uMO3jGDTLAK90xNba+x0+IjpgX1GQwOitigq/fMSCCeTWRfrC6HBazEdpq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257459; c=relaxed/simple;
	bh=5NqD8PAadPFVOVwmwilQ9wbqdH3b+LHheQ4/rFFXBpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sY2k6ZcvlrLEqS4TcmRKEYXx0gFZuoICqg7QfU36Zd8TNqKwvB8FH+VFJ7hnL9ezddGNTeweRvQLV56eS6XCn4+wnnlDo7eDYoHNHlAOGVg3fWUErFiiEZZDVpvlfmD5MYdiUTIoyBSubxVUhbIZqXW/1IGtMf38/nau6+0VwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=xzH47AYA; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="xzH47AYA"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idbUQuAKfpIE1TbIv8vahS9BMFuUzHFUu8j1Ytbw+d0=;
	b=xzH47AYAMfjruc5+0fSYddyGsE7LbsdpMkmeXqA7SMk0dBaup0b/RKSMRexsO5LR9uPuJk
	ZPC9jygbTWxnomS36PGBNS6Cw3cZizKOPRS/dthYjiyLxgnfHa+kzSKKwtBoQ5SptLg8hr
	4VZyTuUSnKKwk93yfAzX1qvOf41lqSc=
Date: Sun, 05 Jul 2026 15:17:26 +0200
Subject: [PATCH 07/10] dt-bindings: i2c: apple,i2c: Add t8132 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-7-e5655ee56523@cyberchaos.dev>
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

The i2c block on the Apple silicon t8132 (M4) SoC is compatible with the
existing driver. Add "apple,t8132-i2c" as SoC specific compatible under
"apple,t8103-i2c" used by the driver.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 9e59200ad37b..8ce77258e2e5 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - apple,t6020-i2c
               - apple,t8122-i2c
+              - apple,t8132-i2c
           - const: apple,t8103-i2c
       - items:
           - enum:

-- 
2.54.0

