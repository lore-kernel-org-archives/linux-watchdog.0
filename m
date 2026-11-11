Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395244;
	b=C0/AH2XC6l90Ss3o3mEQp7bz42VapSZ9GTvjNrT46OARRhRG+y80oimcliyArurnaubk
	 KJE3i5SJKStX4VMsNtKH+cTlSTJQ8CR1lfYrue8nVzET5B1/MAxSLYlCIi3JSWMOI0WDg
	 cnGIElBzv96resNlSNV47EyV2JYhBSQJWeoHgw/B3vNI8t0xKX5X9LDMalC4HXxP42OTw
	 8oOyc+st9FHnrr/Y44h59R22H19Ph+84PEZYeznmsDyVlbOlRrpwvVGjZEZnwVF8P94Pu
	 0cOFbi5TmC+D4RQkiHvCb2fsoNDv1XcvU/6xjornJligglYT2tGN4IFM2/Hmafd8THg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0G2v/eEbgk+3iTnp8ZvOYsDQu49c2J5IO9S93LGndYE=;
	b=3g1/m0eVlQwELEX4cw6A6ni+s0dmDbTvljR9/+vX3MTN6mXemRYETb0+U/XfAqh+zWCo
	 mud/6egqbRls71H6Smtro4sU9Uhl4TnGZRlBq6ccKL/aqMK2k7FmrQio2Tj1Q0XW0uyeW
	 pmeaa/Si17+onmrn1McCPjOXz57Q6/pcMXgAIVaglZGYCEC79phW7lmPoi5RA8FQyt8Yl
	 TFtW3ajF3mAiFnsWjAN+FgfTylq5WCLqbUiPjkvO2HAPFb48CZRnIJHAyPGozjPfXG6Jj
	 h48TwHxGPbdQ2h0E/tVFrWmthetquAhotAkQ0r7Elow6G+Tz+EavK3jz2FUNXWckNTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pm8Hy4f0;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C1606A33C
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 11:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450C1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pm8Hy4f0
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so23769355e9.3
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395243; x=1795000043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0G2v/eEbgk+3iTnp8ZvOYsDQu49c2J5IO9S93LGndYE=;
        b=pm8Hy4f0jSS3E6MB3iGev0env48KECBGEevdmcbYfffKzZ8Jor8mkpdAiFiTO94sY/
         +3/lcKGwD13yZi60c1yIjHCHf+AbDsK0ojUXnoHEaMM9exl/6LCilCyr06lM5qXuwSPt
         Aoh2k5Q/zXzsrcJpALFGAjNhFrgQhC0IfoQ1S2o2XBAMdrHD95qiXaFK6v6gE+sEahJ6
         YtaMQjaB90RbPp1fAI1t8A/uZDGKzuwHJ9U2/ch2PuA8c6oHV72dV6D6SzCsRaCXRBOR
         cdZ7RMBmXuiFW2sUAk+pQC0k/D4mD/NmzWPgqf6fAVQ62JAv752KJ3nXsdrD8sCnnOz0
         glKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395243; x=1795000043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0G2v/eEbgk+3iTnp8ZvOYsDQu49c2J5IO9S93LGndYE=;
        b=2aKYhngpfOM/Sksc5xy/MxXxn+VxlHPNKyLCF20DGzmhXoBS1jL24X8711nU+zHVNI
         9kjYGFgGG0DKBbrz9dgQUO5BhMcC+keobrR2KWSDnsuks40qGEiXBc9esIhVLKldhgTZ
         0XO1HbaW6QU9bYzn29pyEcJ1wQyFFkWzjBM6Q2x6RSSghHWW9Oma+J4V6kGwGMY7Q6UF
         yoVckbU6NBSQxax6IsxZZ+EsF/ZKlvCMy7RXeH2y1bBbUKCpOeRG7FhurpkgwdNBF9BM
         ZqJWMVnziI9JWZ/Lcet3Vyn0JBAK6H6kzllpNY1nHuCT05zEAfA3+r89KU3vi5x9BmXF
         n6OA==
X-Forwarded-Encrypted: i=1; AL+hErHX7ccQC5uyC5OIQPhR9Qu7yoL0v0mX+fbg9/tvDfaF+jNhcUiNg2Eo1scYd0xRem1lTIUq9fLBZggTXBtq3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9233IaHYFn9vh72gJOhhi3VJGkiOqS6x9okIw2Ajltk1rDb2Zs
	SC88MktyL0NqwjfVs5FetppPt9Io6kJ84N13iwnTZCiVXoKxMMQHSIpn
X-Gm-Gg: AYBFou3kcFqWbotbeyxKxveWDgeEznCeJoE2Dv+L74OiyXaQgBlddm9hWK+BU6eHyrQ
	xMvztL3YyYrsn/G879+JVr1Ufrz/blG0U348ItTNN3lD57Ap6bFJlCeZPHvWA4hddVPO4rcEZ+L
	1EWV3K2/MkzQ+ERM8BfFA1l+LmaO0LWc0qyxFHh87fmrZaHxxSHXG8E4ZmoXvqoTDT0r+UnYbtS
	mqc5IYP5c/vajnvCqHQK4lam9+zebctlpxJRQpN9M7qxa0fKRNQPnlugQRUdtvDhsBzHrafLbjJ
	TVSjK5Uin82+nTwsK8J4t/uVJ0kijsPqwBhiJJVl7dETba6BGEdEsXbFv6y+nrEiYRPZhQgwGKw
	egP9G22d4i2KsaxgR8wlDsl0BIuMUJp0AFug/est1BjSN7GyqOrOD8usvQiuLEKoDTkVmnDL+pL
	EQUaxgRRJqqftKrkLlc7oksbG8VFzPGVbHYnXMz5BEuwzj8v/B8imL7Ibc7nBTvv8bW1weWANnH
	0qIGA2YCq6ITx2pZgEmK/EOrHuhZWtVGXPP1eFRZ1o5/+hkLZanCF2MEnFPmWK2uKLRKrBTfZKg
	DLizn4Y5WkLQcVHWSUp5vDQk0G8Zj7b16fg6N4YvZdQViL7nXSmshBVUAmemJV8tDF5vBL4uObo
	PWtW4NKiFVehIR4EfgCAqFLuLEVnsRuNd/G9ZYwzNTLybinZDcXNg8N+MT2GOhFQuHuUgY4P77v
	XqkUCv+SqI
X-Received: by 2002:a05:600c:3486:b0:4ba:6d8:dfaa with SMTP id 5b1f17b1804b1-4ba0936e95bmr39114245e9.12.1794395242201;
        Wed, 11 Nov 2026 03:07:22 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm146727295e9.5.2026.11.11.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:07:21 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 1/4] clk: renesas: r9a09g077: Add helper to start WDTDCR counter
Date: Wed, 11 Nov 2026 11:06:57 +0000
Message-ID: <20261111110700.3331225-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111110700.3331225-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111110700.3331225-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCRm registers are not suitable for access through the SYSC regmap
from atomic or panic context, as regmap locking can deadlock when another
CPU holding the lock has already stopped.

Add a lockless helper to clear WDTDCRm.WDTSTOPCTRL and start the watchdog
counter using the existing SYSC register accessors.

Export the helper in the RZT2H_CPG namespace for use by the watchdog
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v8->v9:
- Rebased on -next due to devm_kzalloc_obj change

v7->v8:
- No change

v6->v7:
- New patch
---
 drivers/clk/renesas/r9a09g077-cpg.c | 35 ++++++++++++++++++++++++-----
 include/linux/clk/renesas.h         |  6 +++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 7dd1f44b26e3..6ecf863b743e 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -12,6 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -103,10 +104,17 @@ MODULE_IMPORT_NS("RZV2H_CPG");
 #define RZT2H_SYSC_BLOCK(x)		FIELD_GET(RZT2H_SYSC_BLOCK_MASK, x)
 #define RZT2H_SYSC_REG_OFFSET(x)	FIELD_GET(RZT2H_SYSC_OFFSET_MASK, x)
 
+/* WDT Debug Control Registers (WDTDCRm), in the block 1 SYSC region */
+#define RZT2H_WDTDCR(n)			(RZT2H_SYSC_BLOCK_MASK | (0x5100 + (n) * 4))
+#define RZT2H_WDTDCR_WDTSTOPCTRL	BIT(0)
+#define RZT2H_WDT_MAX_INSTANCES		6
+
 struct r9a09g077_sysc_reg {
 	void __iomem *base[2];
 };
 
+static struct r9a09g077_sysc_reg *r9a09g077_sysc_regs;
+
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV = CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
@@ -963,10 +971,25 @@ static bool r9a09g077_writeable_readable_sysc(struct device *dev, unsigned int r
 	}
 }
 
+void rzt2h_cpg_wdtdcr_count_start(unsigned int wdt_index)
+{
+	struct r9a09g077_sysc_reg *sysc = r9a09g077_sysc_regs;
+	unsigned int reg, val;
+
+	/* Sanity check: ensure sysc is initialized and wdt_index is valid */
+	if (!sysc || wdt_index >= RZT2H_WDT_MAX_INSTANCES)
+		return;
+
+	reg = RZT2H_WDTDCR(wdt_index);
+	r9a09g077_regmap_read(sysc, reg, &val);
+	val &= ~RZT2H_WDTDCR_WDTSTOPCTRL;
+	r9a09g077_regmap_write(sysc, reg, val);
+}
+EXPORT_SYMBOL_NS_GPL(rzt2h_cpg_wdtdcr_count_start, "RZT2H_CPG");
+
 static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub *pub)
 {
 	struct regmap_config *regmap_cfg __free(kfree) = kzalloc_obj(*regmap_cfg);
-	struct r9a09g077_sysc_reg *sysc_reg;
 	struct regmap *regmap;
 	struct resource res;
 	int ret;
@@ -991,13 +1014,13 @@ static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub *pub)
 	if (!regmap_cfg)
 		return -ENOMEM;
 
-	sysc_reg = devm_kzalloc_obj(dev, *sysc_reg);
-	if (!sysc_reg)
+	r9a09g077_sysc_regs = devm_kzalloc_obj(dev, *r9a09g077_sysc_regs);
+	if (!r9a09g077_sysc_regs)
 		return -ENOMEM;
 
 	/* Only allow access in the SYSC regions */
-	sysc_reg->base[0] = pub->base0 + RZT2H_SYSC_OFFSET;
-	sysc_reg->base[1] = pub->base1 + RZT2H_SYSC_OFFSET;
+	r9a09g077_sysc_regs->base[0] = pub->base0 + RZT2H_SYSC_OFFSET;
+	r9a09g077_sysc_regs->base[1] = pub->base1 + RZT2H_SYSC_OFFSET;
 
 	regmap_cfg->name = "rzt2h_sysc";
 	regmap_cfg->reg_bits = 32;
@@ -1008,7 +1031,7 @@ static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub *pub)
 	regmap_cfg->readable_reg = r9a09g077_writeable_readable_sysc;
 	regmap_cfg->writeable_reg = r9a09g077_writeable_readable_sysc;
 
-	regmap = devm_regmap_init(dev, &r9a09g077_sys_regmap_bus, sysc_reg, regmap_cfg);
+	regmap = devm_regmap_init(dev, &r9a09g077_sys_regmap_bus, r9a09g077_sysc_regs, regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index c9495558cd5c..1e171db25eb7 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -216,4 +216,10 @@ static inline bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *li
 #define rzv2h_get_pll_pars	rzv2h_cpg_get_pll_pars
 #define rzv2h_get_pll_divs_pars	rzv2h_cpg_get_pll_divs_pars
 
+#if defined(CONFIG_CLK_R9A09G077) || defined(CONFIG_CLK_R9A09G087)
+void rzt2h_cpg_wdtdcr_count_start(unsigned int wdt_index);
+#else
+static inline void rzt2h_cpg_wdtdcr_count_start(unsigned int wdt_index) { }
+#endif
+
 #endif
-- 
2.56.1

