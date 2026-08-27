Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5938DC52;
	Thu, 27 Aug 2026 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806047; cv=none; b=ZiAcoX4xKRjsh4Zrjd4z/ZmqgbHER4sfNuUq6HWan/2pkGpEbfjLYrMaErLbxYJ81Ti3DrJZWueor7jmZYF64ptxa6gnfp/AlEohxUxM6r5NpvUOH+Ez4M8If4DpBmKjzKUPS7QAa8/NZqRGuNWf7PLG0CE8O7m1Nr4csjnaraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806047; c=relaxed/simple;
	bh=YIq0A3H1Rx+R07KjnIDHUsNAPYrxI4Sya970F6JTj/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ayk8r3jfZNWqcSv8o9k65bzycU1lwa4/tNIcoA/Gy2msHHwuFH/aUe8StYwo5zwy9OcPAwsbKFXugD+Bj4qVQn+3tnjlgSoayrexzpMAWre6r+aidrR6n89MI29cA5HMZ9Ae0C6iLssI6Y7RPvBKcJ01KAFxj+wIPG13QyLCXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCtM7uiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCtM7uiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803771F00A3D;
	Thu, 27 Aug 2026 04:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806045;
	bh=GF+KYMagwTkH8RT0L2sU4K1+JQZkbIqgAcf1GwXQKmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCtM7uiUPKBWxZ4V8gIzTe3rRHVrY2gdLO5x4BavxDM3zGdEnfEsyy2yrFf/Yp3Gy
	 GJjovMh2l83P4B72WXDjmjPT/RwdAimlpuoTKFRipQz5KWkwM5PKXuUObqY6XCkf0A
	 olEZAYAhp8Sh/YhXMRLldIojkyaPNp7jnP2MTp1n7jD2tXcFbDwC0N205VWx2RDmPq
	 UqREEv2MZ+Hh+uPhA7ZmrHx2lEfSDt1SRDvWuE36NkKN4HbQdY44zhPOmNNAG/62YI
	 ZMa+cK8Z3GY9geDNHX/ouSGAUVOE6ZC/Exfk4wG7s0N0n5eNvjLbQoWHHJYcLksKVm
	 s0/69ai0ZEiDQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 2/2] watchdog: msc313e: Enable clock before accessing hardware registers
Date: Thu, 27 Aug 2026 04:47:00 +0000
Message-ID: <20260827044700.554333-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827044700.554333-1-tzungbi@kernel.org>
References: <20260827044700.554333-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msc313e_wdt_probe() reads from hardware registers without ensuring the
required clock is enabled.  Furthermore, if the bootloader leaves the
watchdog running, msc313e_wdt_probe() sets WDOG_HW_RUNNING without
increasing the clock's reference count.

While the clock is currently supplied as a fixed clock by the device
tree (`xtal_div2` in arch/arm/boot/dts/sigmastar/mstar-v7.dtsi) which
masks the physical issue, this still violates the API usage.

Call clk_prepare_enable() before reading WDT registers.  If the WDT is
running, leave the clock enabled so the CCF reference counter is
balanced.

Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/msc313e_wdt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index f69d66971c41..b279ef645430 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -97,6 +97,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct msc313e_wdt_priv *priv;
+	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -119,9 +120,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
 	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
 	/* If the period is non-zero the WDT is running */
-	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
+	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16)) {
 		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
+		/*
+		 * Keep the clock enabled. The watchdog core will skip the next
+		 * start() and a future stop() will balance the CCF reference
+		 * count.
+		 */
+	} else {
+		clk_disable_unprepare(priv->clk);
+	}
 
 	watchdog_set_drvdata(&priv->wdev, priv);
 	platform_set_drvdata(pdev, priv);
-- 
2.55.0.887.g758fc8c411-goog

