Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BD317146
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008316; cv=none; b=dkM5zj4AcnFC0pRZNWIaQ+T4TJ8YMCBvED917VEtiokWViSW7sjHcgQ2ARtPKkjnpuKHC2Xy5a4MteIrDJuQK96mPGrFfnWLlxkLr5ncHyPv6t4MaT0hWY+lNlu2ZLQ+asiAY7Qb83atbECQTCjwWX50F1ZN0PyWU36eas8md6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008316; c=relaxed/simple;
	bh=/IWRaKV1LWwunYKFTJI9StxWbO25JpfZbLwnkSLvroI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4Tr9e5JoAPrUF5vISC5B1oyVlYPpWv6WLcDj70/XlY/A8wa/89mEI6okShV08s24lKbrz0A0CIXx52CGIub6G48YOtH4Xg+jc1N4oZdu26/HmlVuvMEexvbENIri/6B3DqUZ3R4drbqRAtY3eEXQwT4M+lAsCn8NgaAmfpUCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJZnkkf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJZnkkf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c733f15aso5799355e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783008312; x=1783613112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3gjQTfykGe/vqL7IlmklDV2MhVTgM9WfeaG6s9BQqQ=;
        b=DZJZnkkfXoO5QgrG5lt9aR/kiwhKFW0YV8+00RS0mZ8i7LEdFxrZu8wsbIVfVpBy4O
         WpMB3lXiWGQHv/8RA9X8/C09VqOJwzZ+6KtHmE4RqWcJEGtFNKEImO5bZXnU+JceZSz0
         CzEVZ8VOfZrezjB5eHtVwsA1oouir9fYsDM7Y51bAsggklb2SPM0ThVz7HJvJTiLx74G
         sPZ0XvIFfCbwhII+AqWBLcQ6HQN4PlFM8jqbm3c959NHAzMW6C5lTeZ07ElBrkk1Lie0
         S06Cseo5HoJettmUBSVSz8pAUVvF+QNdP7VkUGs2oYd/ZTVWI3kfFIMq7DJ0s5jilvkP
         GtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783008312; x=1783613112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3gjQTfykGe/vqL7IlmklDV2MhVTgM9WfeaG6s9BQqQ=;
        b=ifTcwYC443Y5hfyen9mwMZnEcN9T8kdFQmaLYqpGrisDNITLjJmWm0+KVyHs6UrhkP
         t2sVlQiNdMUloicFAS39bgYFM46R24MXo9bLjtQP2H+f06Q2dW7teBOaDVYx7kO9Q15p
         B14Z6bYy9EoIAzaHiwkaT0hg3nRI2QPAooOJmfetdFC9MzrfZTUECsgUBg5oC2maV5CX
         ksWaiID6lnyngdc+EmszG0llz8s7DEXl1bilT4ZrFcROtNxcDGj0Pa0kz8PoWXHTqx8q
         eDvaEuaXXbP/9PyM2M/aPqtnPP3XZKTueCtP2a0iYrJdLYg7OcO/Kyz4TWzbgjr/YSsw
         vzug==
X-Gm-Message-State: AOJu0YyGN5p6eKOuC0Va68WilhVFuDFkc81r07h/x5qgd2mSy43QT6Pr
	lQPIvmXATK8PCO9qQV9HK8Xy4aMYRognYlg3SmR2OrTv3xjYZAwz9X5y
X-Gm-Gg: AfdE7ck6cWwpUKO32dCUKpDQ2BhSSKW54lZ9tz5ItSoL05/acmmIWaSg0Didoeif48y
	I0cSuS4Qy4r5UnrfTvCijlV13dnDcUB0+wkV/ruySAjpG6vYXbGKdjJu5Gs6qRJeOm4GlKbVcq9
	R0nrMSmTkNR5Wzzwuy+jdjJQJyOuWDQFPDTWi29MxnpMS/ORf7Va6rGka2EYmClXHq+bcY+smWT
	EVPx5emPDs6P9P20G2Qr6eCssYIY34Y8jGBHosT0toxyzLhIlKBKcaV/OKuSuma3ter32lY7QPX
	boZvcK62UcN69CtypxKXWJPd7Pc00SQ4uutYLAdUO/j5u4wzeKX9gfQImbA3aTmaq0Iqu0KOvuX
	zXxIHEtt+fxUd9rI7WwSAdH0impe0yQJ8Ut9JftH1LMRz2P6eqNnV+4CyNUFKhd2Vy7C4NbVKco
	laQfy1CQmRNAnjtsmomsiw1nDbTv6gSva+83Vk8ZqJy+8R+3i86utfF4mbMCLBAlkZr2bCeANQI
	HtlA+wGo2Y0S3z7jj9g3E55ISE=
X-Received: by 2002:a05:600c:350f:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-493c2b6e607mr102894035e9.19.1783008312187;
        Thu, 02 Jul 2026 09:05:12 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm85444715e9.7.2026.07.02.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:05:11 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Thu,  2 Jul 2026 17:04:56 +0100
Message-ID: <20260702160457.1884345-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Convert the WDTDCR register access from raw readl/writel variants over to
the regmap framework using devm_regmap_init_mmio().

This conversion serves as a preparatory refactoring step. It allows the
driver to subsequently support syscon-based system controllers natively
by passing along alternative regmap handles without forcing messy
architectural branching at runtime.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 83 +++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index e9545b8f5fd0..d0b38450cc32 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
@@ -67,7 +68,7 @@ struct rzv2h_of_data {
 
 struct rzv2h_wdt_priv {
 	void __iomem *base;
-	void __iomem *wdtdcr;
+	struct regmap *wdtdcr_regmap;
 	struct clk *pclk;
 	struct clk *oscclk;
 	struct reset_control *rstc;
@@ -89,26 +90,20 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
+static int rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
-
-	if (start)
-		reg &= ~WDTDCR_WDTSTOPCTRL;
-	else
-		reg |= WDTDCR_WDTSTOPCTRL;
-
-	writel(reg, priv->wdtdcr + WDTDCR);
+	return regmap_update_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL,
+				  start ? 0 : WDTDCR_WDTSTOPCTRL);
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
+	return rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
-	rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
+	return rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -158,8 +153,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
 	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
 			WDTCR_RPES_0 | of_data->tops);
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_start(priv);
+		if (ret) {
+			reset_control_assert(priv->rstc);
+			pm_runtime_put(wdev->parent);
+			return ret;
+		}
+	}
 
 	/*
 	 * Down counting starts after writing the sequence 00h -> FFh to the
@@ -179,8 +180,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_stop(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_stop(priv);
+		if (ret) {
+			reset_control_deassert(priv->rstc);
+			return ret;
+		}
+	}
 
 	pm_runtime_put(wdev->parent);
 
@@ -196,9 +202,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 			     unsigned long action, void *data)
 {
 	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	bool active = watchdog_active(wdev);
 	int ret;
 
-	if (!watchdog_active(wdev)) {
+	if (!active) {
 		ret = clk_enable(priv->pclk);
 		if (ret)
 			return ret;
@@ -242,8 +249,17 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
 			WDTCR_RPES_75 | WDTCR_TOPS_1024);
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_start(priv);
+		if (ret) {
+			if (!active) {
+				reset_control_assert(priv->rstc);
+				clk_disable(priv->oscclk);
+				clk_disable(priv->pclk);
+			}
+			return ret;
+		}
+	}
 
 	rzv2h_wdt_ping(wdev);
 
@@ -261,24 +277,39 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 	.restart = rzv2h_wdt_restart,
 };
 
+static const struct regmap_config rzv2h_wdtdcr_regmap_config = {
+	.name = "wdtdcr",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = WDTDCR,
+	.fast_io = true,
+};
+
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
+	void __iomem *wdtdcr;
 	int ret;
 
-	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->wdtdcr))
-		return PTR_ERR(priv->wdtdcr);
+	wdtdcr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(wdtdcr))
+		return PTR_ERR(wdtdcr);
+
+	priv->wdtdcr_regmap = devm_regmap_init_mmio(&pdev->dev, wdtdcr,
+						    &rzv2h_wdtdcr_regmap_config);
+	if (IS_ERR(priv->wdtdcr_regmap))
+		return PTR_ERR(priv->wdtdcr_regmap);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
 		return ret;
 
-	rzt2h_wdt_wdtdcr_count_stop(priv);
+	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
 
 	pm_runtime_put(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 static int rzv2h_wdt_probe(struct platform_device *pdev)
-- 
2.54.0

