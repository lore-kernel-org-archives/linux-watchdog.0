Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499847DD4B;
	Wed, 14 Oct 2026 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960989; cv=none; b=SlJGJ0bY2fFOy+2W95zJPk7LBE8/ewXmpLy4Y0Y0fx1+pT9ROzhZZYCan0Xls9zZ/7k98kX3SxD3Zro2ZXBJAdNs3T8lyvJ5YclCt29KYYXhK9NUq2l0eVaKjqzzebRRPad68ebr4DPJjepMM8UwAKavRlb615leYJkOI/EZ0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960989; c=relaxed/simple;
	bh=rGGjCImcpu0fLNMmhFVoH3zsFBDMb3V5AldSEYoGU58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZyK40CtsPViGo1bo+Iw3iZ59pkyXBDEJd3E95WdoWZVWAgYhQvta620VvkgajEktypgL3l71lEnWeX9w04kl+ujYi7ZClzhQgxLO4yjoezQQMnLw2aPnKCe6SiTNPy8xGGSIstlNwKJHjScxWc9uSNEkYgydlj19YF/nGUZpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=QwGHkUka; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="QwGHkUka"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ36krX5y+Fc5kdNcZUV9Kc1tIxfS8RooxDxXqucNPI=;
	b=QwGHkUkatA+uka/LbtYDhfzPKo2SGFmO/MhS6DbU8fWd667Tm8Q7+d0yfHSOgVDQIW0MUD
	TRXN9p5EoYEcMsJyR3r8yfRylydz8SOAJoEzJUdBz1rlDQ9Iv4TiWID92Z8fkaGDh/oIIo
	+MFp7IbX3e1q04CJ5EDyWCumHK5uP14=
Date: Wed, 14 Oct 2026 08:56:13 +0200
Subject: [PATCH v2 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6041
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-6-961edd8d661b@cyberchaos.dev>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
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

The PWM controller on Apple Silicon M4 Pro/Max SoCs is compatible with
the t8103 (M1) one. Add "apple,t6041-fpwm"as per-SoC compatibles for M4
Pro/Max.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index ae8baa5f7bcd..48cafd391ca2 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -24,6 +24,7 @@ properties:
           - apple,t6020-fpwm
           - apple,t6030-fpwm
           - apple,t6031-fpwm
+          - apple,t6041-fpwm
       - const: apple,s5l-fpwm
 
   reg:

-- 
2.55.0

