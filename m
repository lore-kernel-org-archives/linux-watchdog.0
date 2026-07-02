Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87D47D93C
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995502; cv=none; b=Q+U+gO15zIVyDj/4wX5mIihG/Kvmxrgfqlfe9wgyP+qIn0WAoUFRn8M9p4vlZW/crUkGWcikU5Eerp6MIFbsQ1IpP8AZ8E2Zh3GHAG2FcUCgO6vhc0fgKh5sTcQqXafocYayhnc/8eT/lHM4Zxy1IXjc6UsoQBY/MSKxiCsu6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995502; c=relaxed/simple;
	bh=LLBGYETo7UHzw7JEEb38VkUBZTw9MmReiAAkH02D5Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOLPIRVSmsn8E9LnBm6fWrRrSxjfwGGUV4bc6RDHtNl8Sr0uhas/jf7Nnor9r8LW4QGzUB/rlcPr0043g8uY6oD/BVWA/RWTbBw+GEGGF0ywM4U/AE1vT5QXW3kgMyjtBDxTkjGg4bYAs7omxR/FCRI5wQsKJXZvgZ/N6xGNRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCxdiOQN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCxdiOQN"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47640541585so1088168f8f.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995491; x=1783600291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBG6RmxV0wZ1TxKhcgYIrEKKrZLQUV/g3tbFJ1MS3eY=;
        b=cCxdiOQNZF6pdZJUiVh8W16Wm9wHd8SF6ICU4QhNy4nuF6lMFPoNUe2WPM4hQUnhDD
         LT9hMOSWctl1eLGUkwu9rFKqi+MmsdwuFtDHGn+kyIHoQaZKmmsUO7V10SS5WjlJ8wOh
         sblKIxeOCilY6vzllFbhoV56yuwQvdhyyPGi/ZmOAp630IPMfCHpSg9Mbwdi56Xf6oMt
         MyUVJtjKFSDcYor4jCFLw2x4aaP640aaM4PLxmt6GAgmrxYD7+GV+bGkPbIYLt0yOME7
         7SfA8e7lIR4bJ98pm7KqrgtFM/Nd5iDpagcoyr2HHX4QNW9PbGlhEqRfYI2ruaVue4xo
         Xdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995491; x=1783600291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBG6RmxV0wZ1TxKhcgYIrEKKrZLQUV/g3tbFJ1MS3eY=;
        b=JWQx3U+MncUeRHthsQ/T+5tloAYaPAmadnbEMpz0ZKGfg8Xp0OdORgFiwCWMctJyvJ
         fApww77GEFVABwkdUPzHGHzEL79ifi15tLPOifqDQCpHikRwmu6G+WR1bd29Hj/RO22m
         /1ajzPjbd9kS1sgck+RoYxjPfmIRYY2KZzWjT3zCpJjTYcs7T7I1/FiVboSWTXrZTLkP
         dO2eoAL9g3B9OAVK8Hl1hz7YqwZtW2GixZBfE/CSP7+ClhoQQVvjnpzeumkz/VopzMrO
         XSswhpYr5mqXRBQEsJS8zCATRHozLXPa5y541tuQOyLvq+mQmkeTSCzktK7KabWk5hlM
         2jCg==
X-Forwarded-Encrypted: i=1; AHgh+RocDfobQV8oe9NOd4aaNh7sos3yOAxf9xIwIrnm2i355XeG8OVvxOOgUY2l/AFTnp5BDBdzZe8zGKyv4JtP1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/EF3+/Hj957JFvvtG3JzlMKMv2mdTcqF3HgLtbJ+Gh0C35jV
	grwWYraDvsjVIst7x/3pjbBaltiH4MRFRIz1VX4o2ZAZYvoN4yzBFNPu
X-Gm-Gg: AfdE7clEMvSMLBFu9Puc9C/73GOkmPf2Xl4eTEbhCYNM1B0PlUWbWkKij6HlppriAWo
	V3MEwbwr6/zejwLmTEdl6hk/lcAibB/wp3QOoeu69pX+ajBiaXD8l76Z/2o0USHl7sM1n2Ip3bY
	Ccy/3g2/G01xTUKwgUZyINPDZLygUXprE6Re1WJyH8TsAwGIQ8FvMNnngrBx4vh1vucw6vHAcUo
	eZsEQ1bzL9zuikNmc17xg8Dl+Ite4INrtQMhuSRlWY2V2jzVMWeIQes0QHF+qN1VlCeaBrGx4rK
	C9ytdiBF04IQJiqDOPZrBcPeChOEnRNsYMxALv1oOcKNSpwWukrNHc51I3GKLp5D9pd/RL/gQEU
	QUZSWP5zx3KKlp90Yt8iExgu6NChOSbECIsK1M9rKXU/S65nexAwjLSDI3fyq3hkAjrYrbUCVUG
	wzsO+jvUxNjB1kJ6nyfdtbyxrcbblWYKvIpsvlJH6iAbtB5dys748Qqs5AxVZqwFn8rMacgGNly
	VSz7E52xARbufTQuZrVQD0+OWo=
X-Received: by 2002:a5d:6f1b:0:b0:472:67de:27c2 with SMTP id ffacd0b85a97d-47759568433mr8144074f8f.40.1782995490822;
        Thu, 02 Jul 2026 05:31:30 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:30 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC v2 7/9] watchdog: rzv2h: Add syscon support for RZ/T2H and RZ/N2H WDT control register
Date: Thu,  2 Jul 2026 13:31:10 +0100
Message-ID: <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- No change.
---
 drivers/watchdog/Kconfig     |  1 +
 drivers/watchdog/rzv2h_wdt.c | 96 +++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..c48293f93ff5 100644
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

