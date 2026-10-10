Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB44AA3F3;
	Sat, 10 Oct 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651595; cv=none; b=WqCTSAEjA7AxKMgOPi2iEgeQXqTdq9Z271Mk1lYi8WbqWFEVMkqYzW/fLSjE9iUcOvmalvt7iVvKLhRm5WzuFRhQN516KXoa+fdPwYJfvTnPB9LPuYHS8ffVYDBOBuFMho7Ke4AfGpSRMk7coX7G7PUOwd/iSvwTHPu8HuAZTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651595; c=relaxed/simple;
	bh=MfKRfq7pRw0Njey0As0pYsmKgxNnpcBoPY6DR5Vw6CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INt+KT/43cBpt/XgcxfSOrFcdrzYCtWozPcVjqJdqxdOMoIfYEp4ufkY6t3S72Qbk7Lq5Tqj43cFX+REHMuEGDywkeaL2Sz7pGZmxo4j3ykfDHUvfxAKXz4hEelJkIFIO0/9UKDd+Z6zy30h+M/nkQyz2ECLZs0xQdreLC7f4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=cYyQpSAv; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="cYyQpSAv"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLkg6Pwn3WhT/dWoAcJ1zOs2xTxIH9f9ALSgQPh+B8E=;
	b=cYyQpSAvtWzQfJ4LG6wY/QRFMP7u3Q1uQWyN5jtvzaKZmmcuZh4uDgFbR1rtx9/uos27E0
	jtg9eALXc8Ksbq2K3DgMGDpvKfb6YfDvTGMS/iIJG8CQ5CG1lzNH92Y78LDRjn3f7I7Un0
	/a5yr2nAB+5unV1/27PnrAJ7iKyr+cQ=
Date: Sat, 10 Oct 2026 18:59:26 +0200
Subject: [PATCH 05/10] dt-bindings: arm: apple: apple,pmgr: Add t6041
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-5-781fb3f2d9f6@cyberchaos.dev>
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

The PMGR blocks on the Apple Silicon M4 Pro/Max SoCs (t604x) are
compatible with the previous M1-M4 SoCs. Add "apple,t6041-pmgr" as M4
Pro/Max specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index bf21a5b3a4ac..3967fcfc1663 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -40,6 +40,7 @@ properties:
               - apple,t6020-pmgr
               - apple,t6030-pmgr
               - apple,t6031-pmgr
+              - apple,t6041-pmgr
               - apple,t8122-pmgr
               - apple,t8132-pmgr
               - apple,t8140-pmgr

-- 
2.55.0

