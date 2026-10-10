Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7968495059;
	Sat, 10 Oct 2026 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651594; cv=none; b=QMPw4e5tFwmYbmnPofLiiPQl1ZRjJ6phvsJmFPAWsXA5fjboad+4l+/me0ZLoBttBV6i8qyiH1H1vflp4PDz22uyOkc4MKkyjk2nd/NNGTc1YG05Uk7a4BYQ78kjr2unxFKQCPD902/acRS2U+wtzkr8gNzNWjAyb+Ts6v0IYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651594; c=relaxed/simple;
	bh=NPk3Mpzi5X/Gx1lYXRa7EO4Jcn91R5DEsy/XDCA08u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzVnr0Pcmbj6sckBVbHETXn2el1Jz2W0l0469GmaIP0RZtYYiUwRil1USrKhURWP8UgRjCP4gkMOkhND4lwmDukzxFNsVdaZp7fCRU8k3Yar+m583fJ9vQSqF8rFvUW3EoT/8S21mo8bAqWmXRX+7xFhTe6dkWUHbkgEBvQ0TO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=kSzB8RPh; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="kSzB8RPh"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS4CNPU3vl3W6seO4KsepsAZ2+gyTA5uwKGG2SD19s8=;
	b=kSzB8RPhQo0hFr/MyIB7r46nfiVU0YBOwaALyZRUWlBecZ0T2IfvB4Wjw4Vhfj6yjWS3sA
	H5KpBv+e07eDS2LGmgCFUCUOwet6iBtGGEA45um6cCRaTWskK931XsvDjttreLAJWBuLRv
	s5GC7vWkqo7P0tkdhrgf42gMhCTn1+U=
Date: Sat, 10 Oct 2026 18:59:25 +0200
Subject: [PATCH 04/10] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t6041 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-4-781fb3f2d9f6@cyberchaos.dev>
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

The device power state management of the PMGR blocks on the Apple
silicon M4 Pro/Max SoCs (t604x) is compatible with the M1-M4 SoCs.
Add "apple,t6041-pmgr-pwrstate" as M4 Pro/Max specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index dcffdd12c8c7..a37a837a4eac 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -47,6 +47,7 @@ properties:
               - apple,t6020-pmgr-pwrstate
               - apple,t6030-pmgr-pwrstate
               - apple,t6031-pmgr-pwrstate
+              - apple,t6041-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
               - apple,t8132-pmgr-pwrstate
               - apple,t8140-pmgr-pwrstate

-- 
2.55.0

