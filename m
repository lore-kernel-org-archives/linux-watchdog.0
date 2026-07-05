Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C6381AE5;
	Sun,  5 Jul 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257458; cv=none; b=inkllHbkeUSVPTnyuc7uR1j0soAAvyZ4WAGT12B9uTem0KzJIYIDQJythwH/1haKZqFKfhY/BBLoKpt1pY7Zobpj7zCQwmIcqlW7m1Q9yoqtZyyj7Uon5fIUKrH7Oht5DCTMm0gukfysdEM4zhBeCqbcOp74M/WyY6pHwn+kYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257458; c=relaxed/simple;
	bh=nRltM+kQ0AP5bRHWSztu6yWaNdWNWPkrB/MwEHV6gv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7fdD5Wl8rHPTLF0eOi0F4KcC/YWh79BbvpssZ5TjCX1lpKafLau1lsDJoTVa4vSruSMthkmjhINGc48ptr98YE5KXbaRNphDtPmjUZBhtv36S5Li0OccRaspgM+62EFCHCir0R2mL41y9aaExZ31Ub597hFwa95szpWOVUUs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=MRDD5Mzt; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="MRDD5Mzt"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te1fc0SXrTO+Omv+e/7lxkRVbY+DmRBOKQ1xmXJhXlI=;
	b=MRDD5MztMMwUczgcl8VLddlHE4sKu2gJmS0n8W7NOEOnIAWCaVBEtGSoDo/QUHH85wi0K7
	r6BtlKF1EfMXy6w/m+F4QQPEa22QSKMjfCsTCZGbmPELRBAGeXJG8s87yvwjvGXAPY0e2o
	JUrK220rjNLBTgo6jh9y5gy0saOvb3Q=
Date: Sun, 05 Jul 2026 15:17:24 +0200
Subject: [PATCH 05/10] dt-bindings: power: apple,pmgr-pwrstate: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-5-e5655ee56523@cyberchaos.dev>
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

The device power state management of the PMGR blocks on Apple's t8132
SoC (M4) is compatible with the existing driver.
Add "apple,t8132-pmgr-pwrstate" as SoC specific compatible under the
existing "apple,t8103-pmgr-pwrstate" used by the driver.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index c9be097cfba0..92e4d37bb32c 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -46,6 +46,7 @@ properties:
           - enum:
               - apple,t6020-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
+              - apple,t8132-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.54.0

