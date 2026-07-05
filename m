Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BF1D8E01;
	Sun,  5 Jul 2026 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257456; cv=none; b=ZEn09DGJLddrAJaGWQhCX9e5Vc/+FI1XcIUkFdgFAq2fbzyCoJv6LyhTUMwLNVtRG2RiiMOAK/fTzGi5BzT9v5rCmu58MGcq9hom9+ZJJ44SXr527fDklsp9rZlFLYOMSZ2c89fC5DFjJuBUXDjcjQlgHHzLik3BMMmj9bqt3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257456; c=relaxed/simple;
	bh=nSK3N/G0bxRvNqH0cYcNGuHteNnxTOiGSm28kXboR50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Te6dMq7kU2jbEJ7Clz+pebn4NwIW6RUrp6eAdWnjIof4lFWCQPDD8uCcFWqLcFqItUY442L8W0R+HgSBzP5R+4JqmUeztYJKeAg46SKuqiw6hm/Tl8KcTA8HS2TrzBdiCQtMkRhWc4nWcmmUDkpWpQAHSCh2sBwvKwO8/g0AKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=JXQUsNs5; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="JXQUsNs5"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHjOpT5Sz8Fqti5EphV5AXXojABtqU8l4gQ5wNNx1aI=;
	b=JXQUsNs5zooXVwz5RS1NIAs6mZ70skswCNItikLSqrj1tVbJWy1ymEUlJjH5RVcBG5M1Rc
	+dF37GRiDptV7sLOL0NfZqqYpFgPuhUx73sKtyeKzc8JtsyGyVeC6V61HNkTmLcTVi7DA1
	+9Sc1/bi2RV0wbZpiu7ru9B3PKtn5Ww=
Date: Sun, 05 Jul 2026 15:17:23 +0200
Subject: [PATCH 04/10] dt-bindings: arm: apple: apple,pmgr: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-4-e5655ee56523@cyberchaos.dev>
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

The PMGR blocks on Apple silicon M4 SoCs (t8132) are compatible with the
M1/M2/M3 predecessors. Add "apple,t8132-pmgr" as M4 specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index c67b67ba065a..61cc4e063d65 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -39,6 +39,7 @@ properties:
           - enum:
               - apple,t6020-pmgr
               - apple,t8122-pmgr
+              - apple,t8132-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.54.0

