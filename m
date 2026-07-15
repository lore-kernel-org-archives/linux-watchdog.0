Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462D2BEFEF
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122774; cv=none; b=HJNgbgvNDKJgd1FPuCN8SBaqqWP3C58i07tKTyCz3WDNbyE0tfnIC04N0YCodaRVYGip3j+0F3WFdmid6nGNpctXFNXmL/lIflDMSI6AZohiuf2vucwknR/uJzNrGNsuDPtPDYSakUL4cygQ40sTzhGa7t8xZOMB44svN3DVgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122774; c=relaxed/simple;
	bh=TSvS7EL83U6fUPpdcDhZLbM32LWV7Gyose2u94kX+Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soRLTPCFPF756wBz8vYj+jJ7PLv4EQQFDKYUXOjk1f3feKLPSPwOFf4Vqm9g784oFT2slyZUCZRXH4HZNkO/zAeZN35rA+aT1mG7JsOQt8tQutdnP/kHewYaPTWE3wrTV3LRi96xe4hTqmK5WBmBUXsBjcEf+hoPM17yLpInswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXK93eA8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXK93eA8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so45842405e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122770; x=1784727570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/dUSvzqHEiz8Aelxf0zuChla9ASyClT+Ccuyvz+t3c=;
        b=nXK93eA87mgeZyzMKcOxdjjKRUk2TyFvARMIevGb+nT6OKzM9EEsBNxtethnx4fShV
         QhV81z/hbmpvkuxjYOTf/bcvYOrnzbnrrvt1bBdSan5oaunAOBxXzZKCZA1HBiZ4TUyI
         kLijHcbx3j3G0yMAk/gPJpTiWEj032k/7l9/9Nu/l+Qe5QTvRMWwHj386hluEjFZgnTj
         LhozoJGelwYCwmsekq6MqXujAkplDpUbyRkXt0KTlNgsTwNk0sceMShdX7dcpIilJFLG
         eI3TqrDJLdSnN3EIZ+mp0VOtDcxSjvjjVzkriaJCLGIRA88f8YwxQQN05HJ6J6aToPvi
         aVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122770; x=1784727570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/dUSvzqHEiz8Aelxf0zuChla9ASyClT+Ccuyvz+t3c=;
        b=UCmBlDGxV+19foFON1E7FmLrUkWk51lurdJoKQgQkJnEXzKH349Pll1As7WNSzXvPY
         jr/uZib1KXh9D2QxAGqF20KkRm0dOLl+Lhx5ZqEtE8WMxZtPNqB/kH1HrWyJBS2lFw73
         bc3KIxW1BzQroHaOkXdeowJfS9SNhZhf+TNl5ym2pHueyfZYHgRNDlZ0d2W+qYsMhr9R
         yK6AaDCKNaY61J/qORp+YAiMVaTZVkwvS11J4g5mZndLMgX43WYjoW5xYKbmmAQ3BD0S
         Yv85Ik9NBi9/OALRCtWqXR2t7SI0Lh8zQwO+9kMhxvyflsSXfyiSkJcpXpWj0Xl8NS2j
         NHnA==
X-Gm-Message-State: AOJu0YwDqWMjPA0/Qf3NTQa23QCjV+qIEyJkhmAK1jICBmg5O1ZBUHXD
	DeB0scj9dYAQUwjtSTqYHny0VKcbCygh/zAwup5lraKgbUD+fYtSK992
X-Gm-Gg: AfdE7clWNId3RBMsXAEDlOh1yG86Zgir6axPl/X46v1KtmCCposrJgF7k9/4obMvtfS
	/Wx1RPdH259aHzH4kr19P73z5UTHRena8bj8vINHI1mQ+fszc42++IFdak4l8RoIqvKIfgwAGg8
	KChPQhdxMyC6s1WKVfaFfksg4XAtr2GzRsW4R+tA0VBmULrCYHp2OLb/LY0yDyC3qyOuMX75ihD
	jquh+lPvdYRMzQyoQbJe8D9ZAZRN0YeuDV4FUHBUMJzx1cTkXSLDZx/6fIYYHu8pgI8r/4UEOR2
	2PpIuBsLAdTh02ongifU/ayFxL/vUSy07A1MfiO6DyAmx8wuENRsTHduyPQngPZ1RbJYDstA/rC
	0nZqN97uk2EQ/932IcEFWa0DaVD/qAV5m/k2M++2bPbNAyyQYzyFVOQPo509WkAK7wc/dShYphu
	ZNh61UBzR+vxcBN1mrs4EDdtEpVP56EPaaJyX+brQcJUMvJeATZw3OMGuQIW1DkhQsUAfBFC8RC
	8wte0IkBcrsfSd5FWrvoeJ0VvBCLYW8j9SzAA==
X-Received: by 2002:a05:600c:a21a:b0:492:4911:8a with SMTP id 5b1f17b1804b1-495389958c4mr53088515e9.12.1784122770170;
        Wed, 15 Jul 2026 06:39:30 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b35105esm79420195e9.9.2026.07.15.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:39:28 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Wed, 15 Jul 2026 14:39:21 +0100
Message-ID: <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- Switched to use regmap_set/clear_bits()
---
 drivers/watchdog/rzv2h_wdt.c | 75 ++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..0f951219caf8 100644
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
@@ -89,18 +90,14 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
-
-	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
-
-	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -150,8 +147,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
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
@@ -171,8 +174,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
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
 
@@ -188,9 +196,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
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
@@ -234,8 +243,17 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
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
 
@@ -253,24 +271,39 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
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

