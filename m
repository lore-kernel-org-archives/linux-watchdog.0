Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACA3093C6
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584148; cv=none; b=UndQPGixFzFDaHiC37XNRiaJzpeCLa0ussP+NFldIjoXoZIX1ZVXCzOn0vR2Yc6C6zXAKryzVxRduraJ551bjb8VAByaSOH95yp3X2Z3SHI5sr87ucAnJ9AWuSaAmhZTamemaCpJ6rgK66fRWuxax6TYjHULzBaW2IpTZkxTjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584148; c=relaxed/simple;
	bh=UTfLkeAA46tv4le1miv+rpaJgQ+pM6hNKOv+iYmAXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy4qaqeOJLWkWEA5NPBVc47g7+UYfR/u4tXe20zxCERqMAw+MkNgSgaxlD5jYidRrB2sDC+ian7TP38B1KKAzlhdOWt/VxrPvK8RZjMszlZ8hdYA9yNEwEsnHKnM7uOTARLSc4NUMiu7vIPVA8uuYQmg91+z31MuxitGP7xbjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=D6qNztU5; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="D6qNztU5"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id A176077E05E;
	Tue, 12 May 2026 13:08:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778584138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xH/ZfxwgUPcUEmqllxyRKRqtCwZJZV5bY37xpotz3WI=;
	b=D6qNztU5syz5z3nyD/QBI4Nnk7TSfD6dp8PzlWHvKuQyyCR2sBJlauBbsR2+rR5w8aX3Kt
	pyKy40IwGTH9O9V9jpi0fUnGlbG/+0QtJnSTXGm9GXHXXz7nOKtVfF/1rcrkYkfRgqyxAC
	j2ZgQ586231uy4cbMZp2qO1zhBuNvjIBsdCUT48Zrpq52rgybX3hME63P+8tBXO0Zk6+5/
	vx0okaml8U4w+7lDTLlr0kcaXABXGV0I89bnvAjfs27osrQFzQ1EtRbZNruYK8+ZwU3utO
	nk0nQR2yfi83rO/TeuRMSsJW5+d6fYEGtrdKV/4fngkzzNCeUF2d2k3CnaleiA==
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
Subject: [PATCH 2/2] watchdog: realtek-otto: add fallback compatible
Date: Tue, 12 May 2026 13:08:48 +0200
Message-ID: <20260512110848.106620-3-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512110848.106620-1-sander@svanheule.net>
References: <20260512110848.106620-1-sander@svanheule.net>
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

