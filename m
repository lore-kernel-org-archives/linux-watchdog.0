Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446D3A5435;
	Wed, 14 Oct 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960987; cv=none; b=uDMRtaFIghgw5sXvUaEx4J/11RAgleqL+T1aYy8sWq0MpwVpBz9OqFCvs/WSzh2YgnGtkDEGIfgQkCSBdvSvXDQHCbHZ5sdOXAo/TnrcVa1HDsMY8tge3VLUCzWemz1r2M0kJWZVzROzdQJ9RQ2sO9f9NZEvtKZkmxS/AbyzZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960987; c=relaxed/simple;
	bh=FGc31eK0mHMnb8JW5pxuHtnsV7iAOXssJ3DqsyXLDm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkKvkmbcHbuLQVZ+lyY2BsO6+yR/DklKbwd011vCBIBxQEXBZqHksiwjYF+T8eWGdix03kA/bKVYG1Kqn397VMj7t3V/bMmJEseFpomUQTJKKPhuNDuXprg/hzl/nX35piD9GcG2Jr9vroCDp8CHu+MRL61ZrY8yodgfGAz/Mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=U3c3Z0O8; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="U3c3Z0O8"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791960977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ubX5HTXXwERfq8GEYIv/uI1vIKizAEZ4GSFbKVY9fs=;
	b=U3c3Z0O8dtLi9b3Gv3jAIZOHlMFHSw8JhKQR6lp7iYOQOZfaBReV9PVuM91j68Nj5xXj17
	cU7t7SkH3lxAK8P2+luy2OmDTFfovJ+YHvHRVEL8NkVpsmpF7ttct8D+p/Q0olTVOnFRme
	QMQYh32Vefts6KSIScAeT7Z3TOt7z0k=
Date: Wed, 14 Oct 2026 08:56:09 +0200
Subject: [PATCH v2 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Add t6041 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-apple-m4-pro-max-initial-devicetrees-v2-2-961edd8d661b@cyberchaos.dev>
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

The Apple t604x (M4 Pro/Max) SoCs use an AIC3 as interrupt controller,
same as the previous M3-M4 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index e3cadc5ad39d..3c2b24be530e 100644
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

-- 
2.55.0

