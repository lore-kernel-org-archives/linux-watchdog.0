Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F53C345A
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618946; cv=none; b=eLcvHW/XA23Tem5ZjGr9Q20NYWTFvDmZ45O1EVHaA3z/pcvxmDkfh3F6XAvQx4M2giK8ZPTKPiEAA2/8yyLX1VX0xEP0IpEswS/ZT9ChjNUoJ8Z2mQzOuRlnSa2bmlJuzz5T7/YCn1zBR9TWF/okJ+snt7/oesK1tk6NCVKmsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618946; c=relaxed/simple;
	bh=UTfLkeAA46tv4le1miv+rpaJgQ+pM6hNKOv+iYmAXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfiJwc1d4retI0TMkgfr/RQGWl7tVqn3j7OaLfvCLmQSkLcRLM/cYj03upVYUp/FyjFoGiGMflSyD0V+Xpdu2DNL1V2F9zy1RNe+Q4Gem/Oylw3IqkFYDNuFoGuEgdShYiXwGsd/PyTlG3kbK4Jncurq3otHYvzqnA8Zuh34ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=GA3QC4KQ; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="GA3QC4KQ"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id D9D3477E465;
	Tue, 12 May 2026 22:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778618943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xH/ZfxwgUPcUEmqllxyRKRqtCwZJZV5bY37xpotz3WI=;
	b=GA3QC4KQa8X6UvWWdeaYn4N3JIqttjVvKbnpDZW+IUsWaEcvqt7inPXom6kPjzQ8h+cMUm
	gSj9/VNKAYpO9hfGsiN11nDwkjImMy5e5gXmpFHIv4+yejzTg7OV7vYLLg7P4jUEy76zHO
	BVm+d7igWh7fS7oq/aGLE30HzGwFykO6O7fUwyUpIYHUc91CTdUOjLfHxvqqPi6UpfufeJ
	zjPH1I04BfJWh2FSyUXVYLY+7E6Ne1+P+d4aRcietHod+srBhNIK3bXT6x9kOM5p2KIQqW
	2aH6HbztdT3n9agzbtGonWRTZ0StD/Wj7T7GUO98JD2S+VxUJkrSitxtnJ5pfg==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 2/2] watchdog: realtek-otto: add fallback compatible
Date: Tue, 12 May 2026 22:48:54 +0200
Message-ID: <20260512204854.8931-3-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512204854.8931-1-sander@svanheule.net>
References: <20260512204854.8931-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the binding now supports a fallback compatible for (new) devicetrees,
let's add it to the list of supported compatibles. If new compatibles
are added to the binding, driver updates may no longer be required.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/watchdog/realtek_otto_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 2c30ddd574c5..b4eb2f87f991 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -350,6 +350,8 @@ static int otto_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id otto_wdt_ids[] = {
+	{ .compatible = "realtek,otto-wdt" },
+	/* Legacy bindings without fallback compatible */
 	{ .compatible = "realtek,rtl8380-wdt" },
 	{ .compatible = "realtek,rtl8390-wdt" },
 	{ .compatible = "realtek,rtl9300-wdt" },
-- 
2.54.0

