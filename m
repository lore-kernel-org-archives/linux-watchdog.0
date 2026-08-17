Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC043C7DF
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994790; cv=none; b=iz8OWo20lHFENJhmA3EZmaqFgJKyQz1eAIw3/U0HznPM6okZrDfCXSMXapS7Eu2y7IqnVTSvXj/hl//gbnY6gD9hI1+TwR2IiVP2zHNUdo1g1o2RNkqefXiB2YYKc8Pofi7/oF7WjBWt9QFk+OjFXYThndJ3ztZgwCukVhNFTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994790; c=relaxed/simple;
	bh=5Sea9MSDaveuQGC5x66kS1vUpcBCUa4zSrlhRTuadrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARgI/WV7mvONAkb4cLZ+MX7af1vlo+qTje780jqFyJCIwuMjjUmY6X6MNLcZjzCPDEU0qtnrgl30v0KGSnEqBBCo0dZesNzYyuKw1AmczNn8cfxodwsqfZCCwjdMggLDjqNlut+isHKWrNFksDTOyMMAnPq/8RByomCQPIqY3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmcDscJD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmcDscJD"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf27856f9cso35201915ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994788; x=1787599588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1c+ZIyIJcvcVaUrDb5n7yyU/XX4DNS072WISoEr2to=;
        b=pmcDscJDxLD2MhSOt3Su5/TRgyasd19vcf/Mp63Yf3ZcGYNEIzku9ayZvonWBB8RWO
         kygfAMCjLM8/ayG6xq0h3vqmlD7kbr2NQvV/VMX+dWepRTWY7625osbQuxLZrQBBJVhB
         vHR2CVm6bkIy1hi7khxNy6vA8ZOeYA61GKD19HN7Ghlr0sUuuxlKsyK5PTQ0+PgJv+CC
         ufowpPbb4zy4+JE0Ojlri+cnJ7VFYDnW8yISZkTyE3yFaAqVXPCQkqHTxsFDiO5bZfYj
         vsmFLAT5wYhgzFLaqT6l2zP3OB0YR71kH+DsNDIGnXy7QLu3IFD3TSw/QNNVr8QIYQSl
         e0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994788; x=1787599588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e1c+ZIyIJcvcVaUrDb5n7yyU/XX4DNS072WISoEr2to=;
        b=nPfO/oz6h91sS1XNuJ4X1tHldVmqUMvt6Fi1IQoULuIL43RgAIv62BTFUTkHyEPZe3
         UYuMCJ2JR97Lu+Bix8hEl7inAozcdtgdWAqx1Qd4+xsT2+5AEk57M0FN9OIc6zTfOyZ2
         Enlsrh1/kvtqAy2jNmMjVvLFMs+XCMV7PGexcQ315NlV/k7rgyVWpbfFz8ObQHm2GWoL
         jtL+ZaPaUehm3xgbkSzzVhssjSmJ3k27N+OtrS22r8zoXrUA0Jj8NuGqH2Vw7Hmg/NDT
         Dj4VrR+U9MOpv7PuYy90kKb4OhqhgVcLTpOErj1Xn2Oj1kGKN92NYHGit73hETxX23Nd
         CvJQ==
X-Gm-Message-State: AOJu0Yw405Xo1wqFk3hWULj7hGlENrEaJjm5Vy/ICgcjZ7VS6LxbOqp5
	ADxLyV6KYpZmUbwTxLhsvzcVHmBVVmFsLgYZ9ufiLp4dFtKxw0oJjwfq
X-Gm-Gg: AR+sD1016qArOro/9ZQh612yMQEC3+hNocPGjiKM1VvPUgLZgvsccg317NcX73cGY+L
	cErz2uJXC5Uy9GLBdYs/RubWrjirnJy6i5tHBuZEzy3+SZ0Nr09e4zQeDBu/X1NTDCTmWW40FgZ
	ox78of74y1+BqP/Y5TZpd8TTGvPfNgu0YJdl7IvNeGgSE9Z66BCjG0pFXztoHkRYMi61gC8KKNq
	0coCUaeuvik+DpSbOhjSWDWP28RrOCHeOGMQr4oW278wuA6FpWMuZ7OqiNOZPgiaBVrHGFQ6mBA
	RjwgL1Axf5yuKT8CImW+hy8xQ79XGrivxSipwVmwNIjO3BUDgdT0bjEUe6VCIM1ihkHRMmqTYc5
	ayjAOlY5Zes4mGgZAMfsFS9MXgD/mf/Bc+WBSMsaPvFwBKFgtlarQA+yDsruKfqqrl5xm2GRRHM
	18hLqbtJuAEp+DzqJqjU30K6hJvPSOqPUsWsgwIWmdx6Ww4QL3cPwtm7mytU+uu2LyAFfO6CeNj
	MgZyAFryGv4Bv65HKF5mAFxZoljYw9FmGdG0dmOsLMaAgQagGEYy4iC1g/IGFyYIM8m0LOdN8Ej
	nDV/8tmZiw==
X-Received: by 2002:a17:902:f64c:b0:2ce:b7b7:30e3 with SMTP id d9443c01a7336-2d5c53bf80amr23810365ad.17.1786994788023;
        Mon, 17 Aug 2026 12:26:28 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:26:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 5/7] watchdog: rzv2h: Add syscon support for WDTDCR
Date: Mon, 17 Aug 2026 20:25:38 +0100
Message-ID: <20260817192540.423994-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/T2H and RZ/N2H SoCs, the WDTDCR (WDT Debug Control Register) resides
in the second register region of the CPG/MSSR block. Since this
multi-function block is shared with other peripherals, it is exposed via a
syscon regmap interface.

Look up the SYSC regmap using the optional "renesas,sysc" property and
derive the WDTDCR offset from the watchdog instance index.

Retain the existing MMIO-based access method when the "renesas,sysc"
property is absent to preserve compatibility with existing DT's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- Made use of the new "renesas,sysc" phandle-array property to access the
  WDTDCR register via the CPG/MSSR syscon node.
- Updated commit message

v1->v2:
- No change.
---
 drivers/watchdog/Kconfig     |  1 +
 drivers/watchdog/rzv2h_wdt.c | 56 +++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..3c4fc9916d8c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1046,6 +1046,7 @@ config RENESAS_RZV2HWDT
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
+	select MFD_SYSCON
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas RZ/{G3E,V2H(P)} SoCs. These watchdogs can be used to reset a
diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 8af2f33b5680..04ea962da837 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -44,6 +45,11 @@
 
 #define WDT_DEFAULT_TIMEOUT	60U
 
+#define RZT2H_WDT_MAX_INSTANCES	6
+
+#define RZT2H_SYS_BLOCK1(n)	(BIT(16) | (0x5100 + (n) * 4))
+#define RZT2H_WDTDCR_OFFSET(n)	RZT2H_SYS_BLOCK1(n)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -64,14 +70,19 @@ struct rzv2h_of_data {
 	bool wdtdcr;
 };
 
+struct rzv2h_sysc_wdtdcr {
+	struct regmap *regmap;
+	unsigned int offset;
+};
+
 struct rzv2h_wdt_priv {
 	void __iomem *base;
-	struct regmap *wdtdcr_regmap;
 	struct clk *pclk;
 	struct clk *oscclk;
 	struct reset_control *rstc;
 	struct watchdog_device wdev;
 	const struct rzv2h_of_data *of_data;
+	struct rzv2h_sysc_wdtdcr sysc;
 };
 
 static int rzv2h_wdt_ping(struct watchdog_device *wdev)
@@ -90,12 +101,16 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 
 static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+
+	return regmap_set_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL);
 }
 
 static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
-	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+
+	return regmap_clear_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -284,17 +299,36 @@ static const struct regmap_config rzv2h_wdtdcr_regmap_config = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	void __iomem *wdtdcr;
+	struct device_node *np = pdev->dev.of_node;
+	bool syscon_present = of_property_present(np, "renesas,sysc");
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
 	int ret;
 
-	wdtdcr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(wdtdcr))
-		return PTR_ERR(wdtdcr);
+	if (syscon_present) {
+		unsigned int wdt_index;
 
-	priv->wdtdcr_regmap = devm_regmap_init_mmio(&pdev->dev, wdtdcr,
-						    &rzv2h_wdtdcr_regmap_config);
-	if (IS_ERR(priv->wdtdcr_regmap))
-		return PTR_ERR(priv->wdtdcr_regmap);
+		sysc->regmap = syscon_regmap_lookup_by_phandle_args(np, "renesas,sysc",
+								    1, &wdt_index);
+		if (IS_ERR(sysc->regmap))
+			return PTR_ERR(sysc->regmap);
+
+		if (wdt_index >= RZT2H_WDT_MAX_INSTANCES)
+			return -EINVAL;
+
+		sysc->offset = RZT2H_WDTDCR_OFFSET(wdt_index);
+	} else {
+		void __iomem *wdtdcr;
+
+		wdtdcr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(wdtdcr))
+			return PTR_ERR(wdtdcr);
+
+		sysc->regmap = devm_regmap_init_mmio(&pdev->dev, wdtdcr,
+						     &rzv2h_wdtdcr_regmap_config);
+		if (IS_ERR(sysc->regmap))
+			return PTR_ERR(sysc->regmap);
+		sysc->offset = WDTDCR;
+	}
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
-- 
2.43.0

