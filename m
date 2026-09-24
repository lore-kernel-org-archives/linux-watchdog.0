Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0D3890FB;
	Thu, 24 Sep 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259440; cv=none; b=Wl1lwItJujuEEoj5mCU6T4XIu5Rh53sv74oj5N/UdO2DXdWOdh8MfwZOMLueLLdIpkSWImFHngv86TBo78UzeOnWlog3JkUYcjvWIx16LViyzuNs/RbWs9GDIE1rS+Z1Db1bJHuigI3Fa5UmWfuOO/yWuvB/8T+yI3JrnxcZufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259440; c=relaxed/simple;
	bh=wjBH+AH/mni+lelLioavbWYQx7KLKMYD9qTbt1OA4UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9bqMPo9lYXkhBBrTqJhQ8K2DT6Ek3ng8h+Y/+4Kl76sspJeAmk54pPPhl96VdsuaN03DM1VTZv2JAsNMn7igzeAcYazzXqFk/cNdRZWwYpJ4G373k0W5XerABPQuo6ny8POOCjwakJ6nswpquB9cACFV1anZRMYsDrjXzyS2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=do0zKt7B; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="do0zKt7B"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1790259436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG1UBaGa+qsk9ngBIUiT7RRImk47b7p+y6j0ZwKUTs8=;
	b=do0zKt7BbBzMSFriVf/eFVRLZi2OY5xX8/rPl0CJ3nJ2VmLTzy/P4/2nSsswyX2m0cXDl0
	w2ZRDiFwTfeUFsiRsgIdPKIp3OQVZi5Wxwu5nKHu+wQCOG7X4pqyc3tPJBNljOziVJLvBx
	htpO7btdx0nNTCbIucz9UUmBbl3ymaw=
Date: Thu, 24 Sep 2026 16:17:06 +0200
Subject: [PATCH v3 2/7] dt-bindings: arm: apple: apple,pmgr: Add t8140
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-apple-a18-pro-initial-devicetrees-v3-2-94f7ea52cc64@cyberchaos.dev>
References: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
In-Reply-To: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

