Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF123B27DC;
	Fri,  4 Sep 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551403; cv=none; b=nEvCYqk5oa4xxXbKnt/HVFftYvL6/TRsxtrIGcHcWK5zAkxOO4Shy0fLX74OoAOpit9DW56inpJGGsl8e48xjwCfiCf+lBUScIkXI0FQBml4664D62KPQ5Oui/SNVmZQolAibNB+XIKRQuS4nUjP8MxQh/KDUUq+SqPDjj7N3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551403; c=relaxed/simple;
	bh=tEPA6uRdYuQ6PY6zBqXkquvyO5/4DfLy75Cass7/Zyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZWcKltT3wjkyl3XLreZxrA7zYUVnFknHh/LTsyWjmAM9MRR1HsRtiSeUITXmJBDVbwhRmPZsAHfHMo6ZwFhj6tD20d5IuNGDczLNP6Bx7dobNybX1ChFcDa0d1OJlnj+FYNAgQY9wLX8eJsoxlshPJ220YktZYgutD/gyjJWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=FHQrs/iB; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="FHQrs/iB"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788551395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnQifhsyepgUfl4SRUFqkKt3aBBkCt2ItCLaLcqAOuc=;
	b=FHQrs/iBkK93NwDUDAltwIWR4AePBtQMwY68TLgCqyxrEm2asYvfonuUbA4Fn7ehDML64z
	oKLCU98/XLEWnRXh5cYdAYuzOwUjuOGUoaSWpBv5DtoTiI83cy/nxydANNAqzTMwGfBqYc
	UkBPfsuseMWiYkFsc6weo5xfJgVfzmA=
Date: Fri, 04 Sep 2026 21:49:36 +0200
Subject: [PATCH 3/6] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t8140 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-a18-pro-initial-devicetrees-v1-3-0c25401d165d@cyberchaos.dev>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
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

The device power state management of the PMGR blocks on the Apple
silicon A18 Pro SoC (t8140) is compatible with the M1-M4 SoCs.
Add "apple,t8140-pmgr-pwrstate" as A18 Pro specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index b24ea8e54e11..dcffdd12c8c7 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -49,6 +49,7 @@ properties:
               - apple,t6031-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
               - apple,t8132-pmgr-pwrstate
+              - apple,t8140-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.55.0

