Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563383BB669;
	Sat, 10 Oct 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651592; cv=none; b=hdCuhUyShTrhGSrucg+MYDvUNza9NLGcK6TndhAzFSBf484IX4G7RUp4Ibrr5dujjX0a9EKi4XfCSuM/u5yskl2JvjAVEETTHGaYIm7iuyrklG3NKl5K8HuboC6FAUEPBjMOpdlAraGCli1UVOSFTjCtnFcqEeCnor3hq2//Z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651592; c=relaxed/simple;
	bh=po4Yi31WAQ8LurV1z49aTAr1KjjCglgBSe4DKupTPpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtXN1VnpCrxGo1id21pr0GhytXcNBEctZlRNemlUhbczyL0yY6/1ITzAL0CXKVC/aGKBm/4nH2qW1sxPpBSjEjgyJMmSXOGCyklt9Sh+OoCQnFoDXBqcQaY2cEvDt9ahxd45NMKAvirsF3OTuA1irVCuLYVF9IH/GBlXZiGL7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=NIH0gOEK; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="NIH0gOEK"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIaLHqLfczp2WSTHVC4Rvnq/860RhjCcxMIPJTtCu64=;
	b=NIH0gOEKawcZEoKToZJit8hHZ8QV1A86PclbH2LjiXQV6CETqwp96dIKA6rHXqVzoFv00Q
	H3df6orfiLIWzuhIeNooVOxn80HJzIS1V3z3XIXMcHSijMScE2L0JegtSIEKsCLvgN9+1A
	ZMoKXLbobIvYNiyP31UZX6ZoxP15PfA=
Date: Sat, 10 Oct 2026 18:59:23 +0200
Subject: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2: Add
 t6041 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-2-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
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

The Apple t604x (M4 Pro/Max) SoCs use an AIC3 as interrupt controller,
same as the previous M3-M4 SoCs.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index e3cadc5ad39d..fa9d89cb40b1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -37,6 +37,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              # Do not add additional SoC to this list.
               - apple,t6000-aic
               - apple,t6020-aic
               - apple,t8112-aic
@@ -45,6 +46,7 @@ properties:
           - enum:
               - apple,t6030-aic3
               - apple,t6031-aic3
+              - apple,t6041-aic3
               - apple,t8132-aic3
               - apple,t8140-aic3
           - const: apple,t8122-aic3
@@ -134,6 +136,7 @@ allOf:
               - apple,t6000-aic
               - apple,t6020-aic
               - apple,t6031-aic3
+              - apple,t6050-aic3
     then:
       properties:
         '#interrupt-cells':

-- 
2.55.0

