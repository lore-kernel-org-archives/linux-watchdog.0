Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968E51B19C
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679052; cv=none; b=Id9a+SnoU1H0JTvwTqf+Z647OcRO+2vduKQxVGNNauMkDuIaR+NkxjE6lD8oVArFX9+5g+LNo2NVumNXvuZyALUP27ggC63Y9RBq1LpgjQBxCBR8meXicNeNMOvho3PrToQfF/nNwaIxK/6uwNsiRrYZCuDt4wHbS7cjsND/6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679052; c=relaxed/simple;
	bh=WFXtyizqLGIjeqJuBx4E9hrha6JrwqGU/OoHpHVWIBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Meg7l7pHSZN8OWqCvXCt6+Y2Rs3KlHyIA3mVnOHDQ/ygpVDxHS9D+/stvXiBSHk0zqxzQjsFjKxNp771YRSgGli48/wx7yIlMPEdZYMN56zcH8OlqAhf0a4YTsQ+jzDYSv4daEM7IV5JUsG8G3IhhH+8LWDdT8+srfzJmP7dJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnIcDz2M; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnIcDz2M"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so2387064f8f.3
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679037; x=1791283837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7SolB0St7GVMEYCNplMh8ZGWzJ6l4dcWp+uIpkdJQ8=;
        b=LnIcDz2MsNcTIn+E8xQAwO1P83V5JZMWjgK18sD8u8xS1kRHJWH19ucPOvisPSkTHd
         AZhOjaAZkBHqc4QME1yalwTEr925K09ITTWxIbZRzaVqFXZYwLH6sDeQixL0+L0PV3oI
         tvUcm98Ri4mLh6rZ8fErBUmURBNN9JkI+IFvas4Gco8KY8kynjdO/O7NHo1WeiOV55gT
         MgcbEgMb+aeJGnVTrkOko1zuhz6Ghbxg7nluuJhDAaITWcsNvMEOs2Tj59FgMvPgmmZO
         akdRqUdZESeybha8re8qhuWGNC2YvC7TjDII8Ls5uMTEe6bLe9qpm+Tct5kKY1fhdsGT
         /D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679037; x=1791283837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7SolB0St7GVMEYCNplMh8ZGWzJ6l4dcWp+uIpkdJQ8=;
        b=MznqksBzSdGaeIMEpqw151tXcGFgGeEy3+cFCeuKiM9JpTXJh3VlFeBONtoaWJh4oT
         d8IgSUm2t7+Sy880HcRU16qAe70w3zzwk3IG76+5uh7TBXykrA4Pb3y+HJ9M909y8/i2
         r6D8kA4tzrsZBlRGtmGtHbD/PMjl5NeX0lWGyPzZPcZzFSjnPO78INP19rVINMA6jiEm
         mcGTqH3Hhjenk/gjv/pztUVTe7+5YYeABHYaJlTV6TSOtZ9heRmkQomRZpNLKiIT0bU/
         PUVbuaUcqT9R++aiOtveNOT0CtW9mSYpk5IWtcmhx0jt5ry2SHt5StG1EhR7YZx9McRg
         5cxw==
X-Forwarded-Encrypted: i=1; AKwUvBx3DmcYGsPxhupAMUN4SYklbMufRaaZf+ivJG8yLX/FS+0baurx119aS4bT6nGk0eDGznHcHxsI/Vr5qY/8/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKALcxPmKWwDYh68ufen1PJ3EjOXenlarWl+C4jz5loIfFUMi+7
	s+zYFvgH+DD1BC6wrZzBoFD2lKRiP7r84a8gdSl7cry/46VZzTo2estc
X-Gm-Gg: AYBFou1+nZmccC8LFmmN/L5h9HFE6WOdruHZlIuF9u2QbQj1NCVtKRGFpHEF+JOlO8C
	8aeLnwX9tgMIRNmAJf0IVXVH4JgDKVYFAaByo3/52h0awIpGwz7G9zpKrzz6BNPyucAwiNLIKmv
	I8k77SB+3T/TQTpsPLdBEjz9Q0/0bZisoIKdGvaV0LMODV97YiU3yw1Bfrcs6dY957Hkb9bIe/U
	3YItCcNFFOwRvS0g6wtm7WQPe9walIROD/zgY4qkX7ICnN1ZFt0lQoFp6Tyccm2sz0XBpBNx/lb
	3yk97DlGEDo/zxT7+gyWNTzXnCSiiUZiPVHdNad5PBA5MhoGxroXBXUtHhmg/gkS/A6cbDjfzsV
	LqYGcci70k8rEC8+euvUVoOmUPrUGsQ1BvKiSqxeuR1nf1QZXSonEnydEzzPJCMyOSbnRo4EOYe
	fJdmA2NUPjw7TuZUB9qMbiuICOUiX/g8o7zY8OOt7Zt8PZKmksP18+vysWqvYzC1+0hR1pjhFnL
	c2hgY3kOZlkxNpULCeTwoZvdidcZXFhXGzipYPxaHeugx6a4SCgNX8MHMrUL5qLHgEVj/IgfH4g
	Fj7SGl+kUVQyEY+01Q==
X-Received: by 2002:a5d:64c7:0:b0:487:27f6:a4df with SMTP id ffacd0b85a97d-488716b8a05mr30515262f8f.47.1790679036596;
        Tue, 29 Sep 2026 03:50:36 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:36 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 1/8] clk: renesas: r9a09g077: Add helper to start WDTDCR counter
Date: Tue, 29 Sep 2026 11:50:14 +0100
Message-ID: <20260929105021.542730-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
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
v6->v7:
- New patch
---
 drivers/clk/renesas/r9a09g077-cpg.c | 35 ++++++++++++++++++++++++-----
 include/linux/clk/renesas.h         |  6 +++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 5a0e7df1eb06..90f0c373976f 100644
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
 
-	sysc_reg = devm_kzalloc(dev, sizeof(*sysc_reg), GFP_KERNEL);
-	if (!sysc_reg)
+	r9a09g077_sysc_regs = devm_kzalloc(dev, sizeof(*r9a09g077_sysc_regs), GFP_KERNEL);
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
2.55.0

