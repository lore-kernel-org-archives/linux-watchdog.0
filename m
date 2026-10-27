Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088219;
	b=kK9atvXiMVQ2IMLMvxrom8QlIdjGZjphXKcPYSqatseJPtwXywZxLaApMjdXekI3ZOx8
	 2hzEpS0LTCLDNSfYgCL3Mj6e/f0HO60qz4kXbmIvxxoc7rZxwIAf7SGEOVU0Khi/U6MSw
	 gle7myAGtHpeEmYbLgI9xrCqjMdLqfr6wqT6cv9JFhCj2FLIyj/IuW+YrUZZ7mxOUTkvx
	 B8ilSnEa/IqhCy2dddk4uql+W8YoReF0u/rEu5uHDQfBleetCssCWMrAgMUfB5yJXQtuM
	 IdulXKBlnuItuqW/fmxorGS2mLS9LviKMH/YJFgI92U6nF3VRQgRSPCLheWobyV9s/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088219;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=OvRAW5jWXAqOgYFFCKh4yUQJFXVArQqv2tM8QSxA/7E=;
	b=0Tso0rLsrWKd35G7yL1pF1AEtraGMEeXb9aBlrW9gO5+Xns7YXCFWdVYgAbzECUpSTsY
	 d5ZN1LIuZa+XURm+ESY5wkRIh0kganY+fBHvKku81AHqGluoZM9+7X3soQd3o8rF6JYed
	 bozkTT4QbCcBuEB2fwo3JC1HFfsZy8aJW/+cpG4LQUOn8o/EQ24FH7sKCYEXoTEOvSJSk
	 Tf+gpH3nTMWIWXF1J0OGOB2YFmmqbaIaImKoeJoMSrP/mVJBE3sNrgFw+1BAgmijMyvvD
	 eU34t7azLS9TZNAFUV7p8wFCLaYLsrloKn658eNCRrClttS4gkQnh29BXH7Vhu7aikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=hU7Wm6go;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD1606A336;
	Tue, 27 Oct 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFD1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=hU7Wm6go
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvRAW5jWXAqOgYFFCKh4yUQJFXVArQqv2tM8QSxA/7E=;
	b=hU7Wm6goihcwaiFPvNDQmNagCPPBiB2424huaCjAhpUn75tb8dKyR9+vZYkVk2rzesedAN
	ljLKAqepiU3P19/MyzSF8sLlWCy6C+eVBZ34yw0UNlSoAMnHiDz0N0FDiJ92+zT6rTRhh9
	IN73x+o5FEmXrS6259UH/eTpqd22rNg=
Date: Tue, 27 Oct 2026 09:03:24 +0100
Subject: [PATCH 04/10] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
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
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-4-1356181bc50d@cyberchaos.dev>
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

The device power state management of the PMGR blocks on the Apple
silicon M5 SoC (t8142) is compatible with the M1-M4 SoCs.
Add "apple,t8142-pmgr-pwrstate" as M5 specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index a37a837a4eac..451f2a80f844 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -51,6 +51,7 @@ properties:
               - apple,t8122-pmgr-pwrstate
               - apple,t8132-pmgr-pwrstate
               - apple,t8140-pmgr-pwrstate
+              - apple,t8142-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.56.0

