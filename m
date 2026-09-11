Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9B4A49B7;
	Fri, 11 Sep 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145957; cv=none; b=H8FYUoC94/S/5XzIKGlRG93wao9y7FuIalINBUOX9TzAuBA8pjTWVvA5wjMP66Kq4Va3cGGkt9z1kw8p6aYPfa1pOcrDuUFdgMo2MxW2s7g//mdxXR+vV1sSVfeB8ibbsccpyd1y/oRSJCjbsuVq0BvQHdy8QzhOWhXp8efvqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145957; c=relaxed/simple;
	bh=HEOk+is60Uy9u6TV1NWAbR58EenA9GLzvkQ1i3IYToA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qY7yD0d/sUWBnAAhw364mR1FdAmW3xER63nC4/0stktZvERngHncQTPpKhoO2/Id0WTddK8bLY/FaIpqNe7qd35WFRsVt74LommVla+sTrHRijbYJbRLaaLVp2u6rO12jf9B0EjlMBUQb1rTnAjXBw2eo8SBmjO4ZtVsmLG7SeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=k0OyU8Rl; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="k0OyU8Rl"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh/XeWBXrRsKcF+6gWaZNgHDZVV2xBCMBMTiM1LQKWs=;
	b=k0OyU8RlMuHRcmpShIIr49ExlBTqbu5LV4imCzl4WC0MPt67zYrEhtA7QRfyWYwQZ3VGEm
	9+CHlbeYF6EmfdDzqh6hsd5cw6pKxEhMKNaBRAlzxF/AUfQ4QhEzZiknxxcA5NiBJ1hccZ
	J4UR4fzGPuThrtu1WD+/t1SB+CubDYY=
Date: Fri, 11 Sep 2026 18:58:39 +0200
Subject: [PATCH v2 2/7] dt-bindings: arm: apple: apple,pmgr: Add t8140
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-2-08d06cf011d4@cyberchaos.dev>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The PMGR blocks on the Apple silicon A18 Pro SoC (t8140) is compatible
with the M1-M4 SoCs. Add "apple,t8140-pmgr" as A18 Pro specific
compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index da660fa13f77..bf21a5b3a4ac 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -42,6 +42,7 @@ properties:
               - apple,t6031-pmgr
               - apple,t8122-pmgr
               - apple,t8132-pmgr
+              - apple,t8140-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.55.0

