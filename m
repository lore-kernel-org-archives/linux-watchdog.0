Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088220;
	b=NA7INKZ9t/P7/uqHhK6bV729tinOq1o+w59+PdERExZ7XsNu7UXGCpcEfkz02/ZXx3UR
	 cSXc6lOKCFiTlXLMlghtjhlG+Ezai5vMCdp7CNH5VCjhFe2u94+K5HscA8l45xxBYwpU6
	 5AhQkT1Gknz8hK8cY0zDU0w91ePVamsSiZsPxq7ZySXJueMyprXOs+5y+Jjj1afgC/zrv
	 vUzuXar8aWlx+jBl3ifal5LSalFRRJKDOkuXDsJzHHhxUDo1uMC5ZTxCpAa8leW5AlYmi
	 I5rkwD2INCu/08wi0x+RsjRvZJ6sftDpDRracz6jGe3ux64eGMtZJ0TDsXjmqpH3DBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088220;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=c7x3BJ6jlesjIm6zIfL80Mk7VDOu/GvYzZE/1SSRn+g=;
	b=eSsdBSOoFTVfYBhBWUPfQP59wtaVCt+D1x8gjMS6NJ2iou4XTaBtdiIstiJKqI7nyNMb
	 N7aqTnU4lcrVWogp3S9QltXI5jBWyGI/5j5HJ0VVHpmm+nfoXz9htl4yT8ydB/nkKDhyr
	 Yr9kiG1k3/lj6og4zhIy2BuNZD/vTfyyqIFaPbWuh/rrMy7gBadl1UqZoKLDKexW4+GDz
	 uUNMutpl/19P+kKWJHm2fn84hRhB6Tv9HcLHFZNxXJvlgJxr87nEEdqTmad7Mn77r+D98
	 h/eNffhc+m2hM3ve6hiPnPRV2ojY4tH9KiYEAqLlvqOdgSXlCP3SqQsTppg1s0YkiDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=upMebKaJ;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127060A260A;
	Tue, 27 Oct 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5127060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=upMebKaJ
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793088214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7x3BJ6jlesjIm6zIfL80Mk7VDOu/GvYzZE/1SSRn+g=;
	b=upMebKaJKW+tF/NpJ6u3Ifuw3BYG8mi9BNULoWUytrDcSHUQ2+FzroDxY/NbGWw5uQEv0p
	Of56kx3Q75KsEQwn41qnH/70HBZaUzEflsQ8bL2aHoWxp7QtOEkWTQJ84xPMx/ip8W3ztv
	4f9MHnXBHDvCulJuN0s8Yhs4HgDFIXg=
Date: Tue, 27 Oct 2026 09:03:27 +0100
Subject: [PATCH 07/10] dt-bindings: pinctrl: apple,pinctrl: Add t8142
 compatible
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
Message-Id: <20261027-apple-m5-initial-devicetrees-v1-7-1356181bc50d@cyberchaos.dev>
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

The pin controller on the Apple Silicon T8142 (M5) SoCs is compatible
with t8140. Add "apple,t8142-pinctrl" as SoC specific compatible under
"apple,t8140-pinctrl".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 0984e4e58af3..a4a15b117035 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -17,6 +17,9 @@ description: |
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: apple,t8142-pinctrl
+          - const: apple,t8140-pinctrl
       - const: apple,t8140-pinctrl
       - items:
           - enum:

-- 
2.56.0

