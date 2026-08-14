Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B24A33F2
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734887; cv=none; b=lsX458pJhRCCdHvwW+DKXaUirSLdv6UtEFrqLeVaaq6vCv+iDNdtvns/zNNYGRFqA1ExX5ABcQ1WdpQO6MxPTChrn45kPHFdkak5CRge0nAzPEUEISeSQUq7qD5MOSyj4DFs1Xv747kETE3Oymv+XnGUxAjYGfBAIdTB23KMn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734887; c=relaxed/simple;
	bh=/09DTtTCMypMTcOM7Qu02qHInaA1waoebLUsozhfRFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGnzi/jVqeB1tNPI8ny/W9HQEjqN8LKvaSj0poUW7hrV4FuvPLLKGr28MqDDQ3Dvkv0xRPnqWOvKMjurSLGJEiPay5gbLjL7Gd8oWj/FSy5JqSuuTjaY8GjXB+hMzaHBpnmEpPeRYB/OHwrh1pr0b2JuvPDINv2PPK6mrta80Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU83H7u7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU83H7u7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1416150b3a.2
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734884; x=1787339684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99FrBqwTWX0f3PFQFTl56F/G9CXlcTrdnsEsEmu1Nq4=;
        b=HU83H7u7MuE3bbZSEDIsDWkckzguj6Z1PwuKV8xuCjeYeEFNPcUbBfvme9boC0WAbf
         J7vt4lrsBE0HbjP7Jaeb3G2HkxQV0sV/Xv8o8L1HWedARziW/dc5dAWSBcMBsSwwn1y6
         RUUnsrWkOTVR4J+FFjBJkW3dHf7S23Me7TMcHJwfrXSxck/ytoL1gY2+T9w/Qv8mroe9
         84IwU8mfDXOM/0QoZCk7D5FJDxKs9zHIYQFYl6f6nWP/1HaGUKLb1D042uv5H7fjtjE0
         268V1AzTQKD1W00cZM7K8b23mrFoyEW8KP7xAp19hRmWJzspotBWezsePNmRJCLQ3Vpy
         jZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734884; x=1787339684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=99FrBqwTWX0f3PFQFTl56F/G9CXlcTrdnsEsEmu1Nq4=;
        b=rOw30UpUdq4Lk0BOwclJcfE/r0h0nFYIIA50HyNSCAXCHs8rne739/vbboZPqR5B5R
         xz6Bfgfrkun6t1VsV4ZOhOhqLb6inQPrhe2g9MAQXfmPNDFAtbweQvAiaX09UeZzLTFj
         q1UgW6jykyvw+C2Ov2QVYGsbegfcXgjlLkx+JZ8HgIx+JEUkUFnehd7tfT8NtRXVkxSp
         nW8W7riwo/SByRJpyJUIgr0UnTzdUf0lEyi8UlQ9Aqm36hw7c6cIyyyTKGxq0Z1eF/xx
         1YOSzAOhDHrD3/D1BbQWOp1wBV/HJcq+/VcpvyswrMIO6COJ9p1mOrabQyninOYlX8L3
         SfxA==
X-Gm-Message-State: AOJu0YxlUgPOpYIl9kp8jfVsUIOMuqJJHEMP6WOWfXWpL2o/WYrMPnRC
	BzY7+ZZa8jOmt91sHSQTaZLFq4iv7bSbYhP3P6330+5pt70/93n0d38P
X-Gm-Gg: AR+sD12u1c3Svf72nCZqVIOqCapoSWRPTISNWklUcLRfBovJgABCR0X6TcA7rtkCDCs
	5z7eoL+druVuceJBuYEMIN11Gh1DUhEOS7cfUndc5JxW9sSB80e/8ghmIwB1emsjQpFQkdou6/l
	QV5Czo7MrT9dcJbCS3vsNxlIl5mVnMv1mit/G4lcY3vu1shMk2PeDRRp0y4SmvyEgNixu5HSdwd
	jm2Zx431trAcoaWqoFZK0d2YUf863Y+GNouaB80oB+0s/H2zFr4ne7RueoD9uwbjEyG85uxVbyo
	/zUdWepo10B/9/KZgkm5ylV5U0WX45+MVjp2/WlXTb4pWpf/uRQgRSeeV4EHCT/k0p3E6ReheW9
	ybnWdu1B8pIddS1xrclLBYsqHNimNAYn9ZE+7vrpLKW8WzzIa0ttCqZDxZe0loHp4yB6yXoZs7b
	GO6sXcc7qJWPO+YN09ZDtcCpLKSXQWbW/dFar4Qy408siyNoyyYbWvah0B4h+6FcKaMsoyD7Oyw
	3yWwVQSn1G5EK/K7vrMTvBgMShM+PfBe1fCacGIBr1ks9UrYHF5SABM6kz829Asa8nLXKamwWIX
	FH6vEqXtXp5KLK7KtLs=
X-Received: by 2002:a05:6300:4c:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3cc71ac4503mr10507025637.15.1786734883803;
        Fri, 14 Aug 2026 12:14:43 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:bd48:a716:c86d:67a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ead105a9sm6734865eec.31.2026.08.14.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:14:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
Date: Fri, 14 Aug 2026 20:14:13 +0100
Message-ID: <20260814191415.2110732-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- Dropped unwinding changes to patch#1.
- Set use_raw_spinlock to true in regmap config as certain watchdog operations
  runs in an atomic panic context.
---
 drivers/watchdog/rzv2h_wdt.c | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index b770226f785e..cf28caef31e8 100644
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
@@ -91,20 +92,12 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 
 static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
-
-	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
-
-	return 0;
+	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
 }
 
 static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
-
-	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
-
-	return 0;
+	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -280,14 +273,30 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 	.restart = rzv2h_wdt_restart,
 };
 
+static const struct regmap_config rzv2h_wdtdcr_regmap_config = {
+	.name = "wdtdcr",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = WDTDCR,
+	.fast_io = true,
+	.use_raw_spinlock = true,
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
-- 
2.43.0

