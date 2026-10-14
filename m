Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCC470440;
	Wed, 14 Oct 2026 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960988; cv=none; b=YaS9ar9XpZx0oYPuiVvqhdw/gh0WlKx/wTeKdB9FRPDRJ92RAjfUR22A1ELAxHr9zNLBx0m6Ha46Iwwnf9Q2mELYnT8tE7HU0F5Zo5nAIcSk6g9NQRQYK1UNJGM0zWv2OHO+YZ4/dC+iVo/YEAX1Bm9EhvvUA0u0ASiCabhoGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960988; c=relaxed/simple;
	bh=NPk3Mpzi5X/Gx1lYXRa7EO4Jcn91R5DEsy/XDCA08u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqWVN6Eqw7UjBWC/ae6BTPR6OjchGa5hENIlNHOz4ZcHOxphbpTDFB/3dV50piy3oBdfGYXB1RKDI6eEboJjz9hG706lgeITzWfkvVEKWv8t/WE4yce59BT39vVjn8U9qXUAQIwqu85lQezhV5RQ+d+0SC/lyjJtShQYk8HzogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=q6ptbUZi; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="q6ptbUZi"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS4CNPU3vl3W6seO4KsepsAZ2+gyTA5uwKGG2SD19s8=;
	b=q6ptbUZiHYtDsi4KzXlk86GC/NIyKA5VucbdPjGgLucT6bIL3m9V7e250/EbPfvM+u12ov
	FCgOcgSYSHkJvxeU7r7T8omLSxaNJrUn1DXcEznd0cbKcA0pUzIVVOSIwF9U082lJyl3nC
	oRKgV3NiJhXhirmVdyajtZ20heBt52Y=
Date: Wed, 14 Oct 2026 08:56:11 +0200
Subject: [PATCH v2 04/10] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t6041 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-4-961edd8d661b@cyberchaos.dev>
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

