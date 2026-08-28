Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8A226D18;
	Fri, 28 Aug 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933652; cv=none; b=dyHTEyjIKKwrFk9/RIvFjEKB5Q2qmuo9en6jHmPTXBCQzsbYYcU6wnEBhnWgRBcKMgP3j+R9hHHHimMG+eAeQTwDv4nUwtgsjlAtxnzo9RgS4r19Gr7rySoOK+rnn1FkNIXc13iCa4oKY/QpvNdr+8yrf0YYcmQj47bM0dx9tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933652; c=relaxed/simple;
	bh=GvI9aClyaWPCW4DyL3u15cesj03hvc2tbpILcGQoK+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r92zy3TGtPoX5u9bCPv0QFsHeE0wuJEsvDQvklARK1oSQ1dVm9WVeePjT69GBnFmYU4/59OKGwlfH0sLwxNfCz9pEV9D8G3ub0pnPLaBxIM1camBGsRmciUHYtZmpokm1Vb+JpwW6T6US3zwogbmy0tP+0sNQUg4yJEl0sCLIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDMnf9Bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDMnf9Bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFE21F000E9;
	Fri, 28 Aug 2026 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933650;
	bh=2kNYHCYTLJtdZIB7MaD/zUwd8rkpEDZp2kmjhvGkm+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDMnf9BtE9Mo0rWUwJQT8wS57QwnVhLK/sGOS1lTX4a4knPg3Ocrhv36bkOtzaVV8
	 UvTM7ua0Xpahcoixe0bDcSNULeYr6sWVRhbuTTt6C8Nfs9y6pk+nRll3GTRa5MYSqE
	 avuTXk9PMotdVRfHdcEPscLu1mR07rnDC/LRFg+0yVXLkwIv4MVnsdEnmCtrZ7x/a8
	 7caiW4KmbgspOlq8/jNCt8FTXeI8W9tf//i+4Y2COnlWbVJblF9ZP+0MsLdt8lCGLw
	 GSMciGV3fL8IKsE7o5aUXDiyQMYx9PLF4+1iewR1Xe7bLWs5Eh3cA7XUItrJGIsyPm
	 Gh0OXTvKIzuSw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 4/9] watchdog: msc313e: Enable clock before accessing hardware registers
Date: Sat, 29 Aug 2026 00:13:43 +0800
Message-ID: <20260828161348.13212-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828161348.13212-1-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
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
v2:
- Fix a clock leak issue in the error handling path (Sashiko reported).

v1: https://lore.kernel.org/all/20260827044700.554333-3-tzungbi@kernel.org
---
 drivers/watchdog/msc313e_wdt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 8ce24df8e338..7c4593566781 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -108,6 +108,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct msc313e_wdt_priv *priv;
 	unsigned long rate;
+	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -133,9 +134,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	priv->wdev.max_timeout = U32_MAX / rate;
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
@@ -144,7 +157,13 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(&priv->wdev);
 	watchdog_stop_on_unregister(&priv->wdev);
 
-	return devm_watchdog_register_device(dev, &priv->wdev);
+	ret = devm_watchdog_register_device(dev, &priv->wdev);
+
+	/* If the WDT is running and anything goes wrong, disable the clock. */
+	if (ret && test_bit(WDOG_HW_RUNNING, &priv->wdev.status))
+		clk_disable_unprepare(priv->clk);
+
+	return ret;
 }
 
 static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
-- 
2.53.0

