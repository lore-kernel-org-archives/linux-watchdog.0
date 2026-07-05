Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507337755C;
	Sun,  5 Jul 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257456; cv=none; b=RPkQv2+81nBXigOsSXhkz9l2mpIY3X1T6BQKXJwSSpyuBZfXRz8brbkcn24S28K4si3fHbPBaBL0IRGGYXYFyRW6Mdlz95ewdtTUxXq5MxMgiA9NEZgIIeu6ZkQo1dzewcIDDqGKO0Qc1Vp8rA93/gUayScwCDiKKNhl/0JB2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257456; c=relaxed/simple;
	bh=dTuZ5x0/Gb1RE4kn8xDOk1RkVmP8ydl4y35ZQee+zaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iv5k+qsQGMuZw5sj77ANlCI5pQozpiopp+3OSDJxrPHE057qazTCwXIfAjaR1NIoIMngb7ewlB8z8SiPzFlW/sv4o6BlQLbp0EXRlu2IDRQ8K1GkqHbBokGGOzE1xAnKg6MMlic/XEnvjZtOao4V0pbJHiX1cVqgRnrhknIX/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=GC4ATiQR; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="GC4ATiQR"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljbLLNXdPRMRrFNl8paEjzbRJ44yAbxs18opzD0RacA=;
	b=GC4ATiQR/ykmmCKqubMjENw/3Xr6Ci0ZJQmyTzl15/JXn3E6/pfeQcovEEOuDBcKtE3gfu
	DjB3MY6wtvGouS8itJVrGfsoLVvmmHq0yuz2TFZ0ME7c5gP2zy5j0SnWc51bwMJk7fgihV
	we9t/adlMPacke8u70uo7RdEBAmx8FE=
Date: Sun, 05 Jul 2026 15:17:22 +0200
Subject: [PATCH 03/10] dt-bindings: watchdog: apple,wdt: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-3-e5655ee56523@cyberchaos.dev>
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

The watchdog on the Apple silicon t8132 (M4) SoC is compatible with the
existing driver. Add "apple,t8132-wdt" as SoC specific compatible under
"apple,t8103-wdt" used by the driver.

The M4 wdt block additionally has a secondary watchdog, which is
disabled by m1n1 and can safely be ignored by Linux.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 845b5e8b5abc..b99e7913e398 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - apple,t6020-wdt
               - apple,t8122-wdt
+              - apple,t8132-wdt
           - const: apple,t8103-wdt
       - items:
           - enum:

-- 
2.54.0

