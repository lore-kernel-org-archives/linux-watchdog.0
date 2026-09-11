Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2B4A68BB;
	Fri, 11 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145956; cv=none; b=g1oOHj4PhiKIFRWjAAoegVeosxLZ8v6bOT75N7TOgvErep14XKTrxK0tJjv+wrjEX8nkZqNns21rWovbTDtSYoUM2hCdYDSO9c3bkFjrdbqHkYvJtvBkHccyTSZ4dyXKrKwSM6l7FpDfYDBsvX94C3/PxDs3VFZaDRKfN5XEkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145956; c=relaxed/simple;
	bh=/OmSYrm0FCFYc9hbupI51jfnKBd1bG7XnXmGhQ5kzOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVsna6CEs73EIFSlgwqoHVxwsHdMh5SPzVdbz+hCtEJGuMNt/61bGsI0dc7beUgrUHXeRCUiD9Gj2e7X4M0C9HxaQuHKnJj+QTuUVcAbdaxLk53qxMFdhoeacZBvBlqgFkNlj0mmwW0jN6wg3O6Rlhi2uEeKeGu3iozuwmnsY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=wRXIqfgV; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="wRXIqfgV"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfhvNN0fjj6swoLbh/0FaAvtFZVMTHuJaXk4F3s84AQ=;
	b=wRXIqfgVb6Yz/3qh2s6mH3u2Iv7yH6hudX87vP7mOAVSY4N1RhJJwNJ2ljrFJqhnYl4mQe
	+h0jCZ4a324UVKw8/OsdqqcG+UYRc7BTU40dUtSM+G/X1ay7ZvEJ1ZM6YJUHMVBb3a332G
	bcfWEJQe45LuI9Iuocf4EmaL5sjleQA=
Date: Fri, 11 Sep 2026 18:58:41 +0200
Subject: [PATCH v2 4/7] dt-bindings: interrupt-controller: apple,aic2: Add
 t8140 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-4-08d06cf011d4@cyberchaos.dev>
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

The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, same as
the M1-M4 SoCs.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index 1cb886785173..e3cadc5ad39d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -46,6 +46,7 @@ properties:
               - apple,t6030-aic3
               - apple,t6031-aic3
               - apple,t8132-aic3
+              - apple,t8140-aic3
           - const: apple,t8122-aic3
       - const: apple,t8122-aic3
 

-- 
2.55.0

