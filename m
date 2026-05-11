Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207674CA26D
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525475; cv=none; b=CfyDVdlr19ZSBog4AYPo9LAtsVY8etsMCj5xxp9bFnS+UiizppO0ci7I6Dt+AyXUU0+YVqkt3NivVvkvpku8BVf9J3VQJvSpkcm+Po8LCZURsh2L1Q04d91ZAh8wAADysuj8rDOuLehjfxtZ8r/H3b4ORdvwuFFElGddwtwEUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525475; c=relaxed/simple;
	bh=k8kaxHUvKwTsMdx8UNQ7UhsM5OScIVoboylW0fjl5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twdq5/mfInv5Sf026KEgWlWedXD5nqmcT5H9KNSOIPui1q03cltts1ZzNreHsJSexX3g16hvHuMqsSSKFP8x8KIzBmWKlN3x+RAq4JtJ8W6106XwUWp/uOj6++iQZ2DhdHzkrr7umnbQTQz0H7PgsOnXmcibgi2mic9gH7U/bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G19zvLuX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G19zvLuX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so50353955e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525471; x=1779130271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8OLKKnzsGmMg4+rk5zd/9M+W/bTVxBRnL5q1Cuq08k=;
        b=G19zvLuXrWPNpqxMHJOJUjVQycduhM3WUxAWGE6VTax0UMA5fy6fSkTk2RbDUPFj7Y
         KiTW2bdMqpizMSVH/G9ta6BFgBJLK4j3AYFWe0+ZzG3E+r3tcpqsXMvuF/B4UkWzYeQC
         dYT/vmPLNkJMb/SplU0XL0DInKoPduXoJy5R3iX5OdScqJvuHl3LhRrYtUYcADSlr5so
         9o0n6OZLaoDMZqc+lq6pz+46Gwn12na57xVMSwGg9Y0erT+w14lPgV5BijCchVGus1fA
         UAVkzF2jB4IEyWDkb4E6EtCl8ngOIXkTUnsGS1RBlLs9eqj6B6YdgLvw561XrW/LmoaB
         iqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525471; x=1779130271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8OLKKnzsGmMg4+rk5zd/9M+W/bTVxBRnL5q1Cuq08k=;
        b=hY5YJknB1AuHPCLzj26QUpLVYccaGcbbJLHH7aeCbPBAt0iaTCCIdRKYYJeMn/Tv5e
         9dBLyUb8mpcgPbNKWbw+4N2fL6c4Ry4tpeqEcT1mGtuTWfA4gOu2AGF/NraBN28K7/Fh
         rlogTO+APRgnfmCZUqKRn1e/YLoZdoccJJubyKAs4bvADubevaSSmYXhGN8UB5dfeYVR
         9WRMp2pTwQSmyrgXXIpm/1VRryjSMxcpyEFsbBavIloiS35jqH66XKrs2/66JmkhRIwx
         AMjCyvUNGs0lBrZjGDYMfugojooRClowFUuUUcNyRHragRZfQ8uCO3xGhQjv925Dy9tX
         syVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ueZ2q4Hf1rjX9dvGyuHcd4vtqs2x6/ul07RDd8xfqAyMqImgxCCOMGjJEcDHXRCzaTHjkZCSq25cPP/1h4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+DCI4GL1t0/z3wH1siQVyWkngfkFlP1zDMqKGUorEcHovhP1
	poduWx8t9k6Q04C6Tr97QUEKJ2gn7Z/YMnmjso0sZT3zGs0p1GPLq7x5
X-Gm-Gg: Acq92OEEUJyPMrE72bgyghm5viig4azmyoU8l+YYrr1P4eH7l5TEFc8/l9TgMbYmYO1
	Be8R/Sc8s+HhgYCZzeA9V/GGZigaR8tAWQUNkwz0DUM1/RS0wkBbs8J0T+9XqqojEdAXS4Jwk+w
	9SRDkXQQXq4n7ceNY9Y8J20eNcUHidr3adnivfsuV1XnGZOCBusiu0iGKyEFZggFJVP4iSfnrvu
	hNxA6A5dDPUO4MkmuaHS2i77vy/+kF7P5Ljet9kFRqwG2wSoA50aINr4JG7lXyEFeLgd1lMPhlK
	UgwBYELWYcPL9saoCl4tT25rHa+lgTEkVCuz1qFNH923agp/+xezq59Z4855kZYJDyIeIQuWMPL
	m1yBCWBYjtjTijqEAHwc3wxIfdK4HyZd7eFi8qz6iUe7EBtZ8+r8nZO7XedMdfDibveX1L6Q0CR
	W3V/IaS9b+HuxjeaN9zRaooLooleRhGwFKx3xsFlKO5CLjcIK6mvhMxByV+wq0pv6L1EUYUNghE
	jo2++GdPXhBECIb8+2K5Nla6OMqsTWFYJPEKw==
X-Received: by 2002:a05:600c:a110:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-48e51f2e8a3mr368333065e9.14.1778525471474;
        Mon, 11 May 2026 11:51:11 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 7/9] watchdog: rzv2h: Add syscon support for RZ/T2H and RZ/N2H WDT control register
Date: Mon, 11 May 2026 19:50:56 +0100
Message-ID: <20260511185058.1926869-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/T2H and RZ/N2H SoCs the WDTDCR register resides in the second
region of the System Controller (SYS) block at 0x81290000, which is
shared with other peripherals. A dedicated SYS driver now manages this
region and exposes it via a syscon regmap interface, making direct
mapping of the WDTDCR register by the WDT driver no longer viable.

Update the WDT driver to support both access methods to maintain
backward compatibility with old device trees that use direct mapping:

  New binding (syscon):
    reg = <0 0x80082800 0 0x400>;
    renesas,sys = <&sys1 2>;

  Old binding (direct mapping):
    reg = <0 0x80082800 0 0x400>,
          <0 0x81295108 0 0x04>;

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/Kconfig     |  1 +
 drivers/watchdog/rzv2h_wdt.c | 96 +++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6a9695a16d5e..37b71e2cd1af 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1007,6 +1007,7 @@ config RENESAS_RZV2HWDT
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
+	select MFD_SYSCON
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas RZ/{G3E,V2H(P)} SoCs. These watchdogs can be used to reset a
diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index e9545b8f5fd0..e14ff853a4e9 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -8,10 +8,12 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
@@ -45,6 +47,10 @@
 
 #define WDT_DEFAULT_TIMEOUT	60U
 
+#define RZT2H_WDT_MAX_INSTANCES	6
+
+#define RZT2H_WDTDCR_OFFSET(n)	(0x5100 + (n) * 4)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -65,6 +71,11 @@ struct rzv2h_of_data {
 	bool wdtdcr;
 };
 
+struct rzv2h_sys_wdtdcr {
+	struct regmap *regmap;
+	unsigned int offset;
+};
+
 struct rzv2h_wdt_priv {
 	void __iomem *base;
 	void __iomem *wdtdcr;
@@ -73,6 +84,7 @@ struct rzv2h_wdt_priv {
 	struct reset_control *rstc;
 	struct watchdog_device wdev;
 	const struct rzv2h_of_data *of_data;
+	struct rzv2h_sys_wdtdcr sysc;
 };
 
 static int rzv2h_wdt_ping(struct watchdog_device *wdev)
@@ -89,9 +101,18 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
+static int rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
+	struct rzv2h_sys_wdtdcr *sysc = &priv->sysc;
+	u32 reg;
+
+	if (sysc->regmap) {
+		return regmap_update_bits(sysc->regmap, sysc->offset,
+					  WDTDCR_WDTSTOPCTRL,
+					  start ? 0 : WDTDCR_WDTSTOPCTRL);
+	}
+
+	reg = readl(priv->wdtdcr + WDTDCR);
 
 	if (start)
 		reg &= ~WDTDCR_WDTSTOPCTRL;
@@ -99,16 +120,18 @@ static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
 		reg |= WDTDCR_WDTSTOPCTRL;
 
 	writel(reg, priv->wdtdcr + WDTDCR);
+
+	return 0;
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
@@ -158,8 +181,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
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
@@ -179,8 +208,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
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
 
@@ -196,9 +230,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
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
@@ -242,8 +277,17 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
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
 
@@ -264,21 +308,37 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->wdtdcr))
-		return PTR_ERR(priv->wdtdcr);
+	if (of_property_present(np, "renesas,sys")) {
+		struct rzv2h_sys_wdtdcr *sysc = &priv->sysc;
+		unsigned int wdt_index;
+
+		sysc->regmap = syscon_regmap_lookup_by_phandle_args(np, "renesas,sys",
+								    1, &wdt_index);
+		if (IS_ERR(sysc->regmap))
+			return PTR_ERR(sysc->regmap);
+
+		if (wdt_index >= RZT2H_WDT_MAX_INSTANCES)
+			return -EINVAL;
+
+		sysc->offset = RZT2H_WDTDCR_OFFSET(wdt_index);
+	} else {
+		priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(priv->wdtdcr))
+			return PTR_ERR(priv->wdtdcr);
+	}
 
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

