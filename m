Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554D47DD50;
	Wed, 14 Oct 2026 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960989; cv=none; b=uADXt4Kato3THFTs0Pv1eczl+dneZ7BE7aLSblOsgnR5xFRytK+OdCda5EeEunBsARLUfRKwxCmbRW5kOOUQvQzoRJDc2r7Xr81KzmdejhzjPOeY0X19F+AISg9xGq/dKbBxjFWPfFnsPEOiMZuHwWZqbD86O1oqmm1SggrsFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960989; c=relaxed/simple;
	bh=MfKRfq7pRw0Njey0As0pYsmKgxNnpcBoPY6DR5Vw6CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX3N7yfO2S9A2Ax4BrM+WdGKL6GfLh9+0dqTh5U7XhaP1UAkqQPPrKupvhLPU0qrdsu+xfXBytwZEIIEeH+tL097upK7HktzilZW3OdXlwS5gLPIS8npL2Va1G+0u2+u+RDC5OkgMIS/2tOfKEB0qojQThvIQWdVGv50Cysi0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=GPVFk91A; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="GPVFk91A"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLkg6Pwn3WhT/dWoAcJ1zOs2xTxIH9f9ALSgQPh+B8E=;
	b=GPVFk91Ajqjpm67mr68js/zma6QkNi8hwLB4gWROKJ2HEZO4+uQ3kA+sOWFWxlvoaQ+NOM
	O8Utkt6rhTDiv7eBKyu72TbS63GkvZz1PnEpcnUFfmHh67rLS8h5AHmfzIZuPNf5waJ1eJ
	c2Gv/Nf97Nu16CmgZ/5nBBxYlKkEUxY=
Date: Wed, 14 Oct 2026 08:56:12 +0200
Subject: [PATCH v2 05/10] dt-bindings: arm: apple: apple,pmgr: Add t6041
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-5-961edd8d661b@cyberchaos.dev>
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

