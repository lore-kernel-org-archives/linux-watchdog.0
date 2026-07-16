Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84441E6D2
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205288; cv=none; b=Phc+Anzd4quAezcU4/FG17qw9twC0wJPd9T9s2NklTVshIDgovwu97OxKLwk83hQhpKhN2i4HCz7ZQcv4Ye5UapXg0Hh6RGB/IrG2Kgzi8XcEJZ8eCxbZu2bbv07TLjHTxf6EOKMezk96IRAd8tlbSz8YgpiKCZpqB3JRpDRpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205288; c=relaxed/simple;
	bh=5GqL08NioYD4pYncUaWYi9N7jP1/SIEbb2JryINUXOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0fPZO9m49olNLKS2nbu2mMPxQw/X1m1Qd4y7TmxVOF/7bUvt0CrK9OO4VKAvEnngBwhrV7DraVAps0XG/e95JTGshWj3f8uqSBIFziWXgZUfTMJKqoArY2KUi50j3vOgCWD8SXb5mZSnUmZS6udcSTaalCbVCTTihNfTDrmAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5j7MA/+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5j7MA/+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c7902f47so51756335e9.1
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784205284; x=1784810084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTWYiE2qXhAdr9bSb9+CL6D9cLgLiLZpKtad+kdGCD4=;
        b=Y5j7MA/+VJyz7GT+prid02jo0q64t7rtk6L2GRW8Bqu7BD/C7dE8OXpfnk8NOBQv6a
         0A1V+QDkuubeZBDjQZBGK2fWwoP8TgqlU3WMV5h85au+32LvInJ2VJb/8au6Jzrd8m82
         d8hZtNTWbw7BUQJDP3EOatQ5kpMXnCK+yBzmHZ91Ao6gdC68sAv5WBoR8fvregsxps3A
         4simVDcG6aa5g8yE9sv8Ll9VY9qBLAnunFLvQynBRLPjTvvHZo/hk35+Q//gguTzNQS/
         4tESPZbN2+wY92nPEUuin+RwlLnsMVF0npFIgoHIwkMEfeAaCKgxL8yfmx6yKtkjVZzy
         MO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205284; x=1784810084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTWYiE2qXhAdr9bSb9+CL6D9cLgLiLZpKtad+kdGCD4=;
        b=PAayfy+OJ3Ubgv7Xsqo39Q8pw+8mSyQw5hGyFf/pFPe3CGovQQ2Fe6n52Nv3N+ynd5
         6OC6pfkWJC6iGuNyJZ5KJhrQhihe6bPONIiriN1jwoqcwuKDDmDMqQiqV1gANlLbb6UF
         PXPB07mF0M4nribtnEB3ShwiqYWCocEIE3Jj2JpANfQh57nEaBGSy1kpoiNosMdKIGdh
         ByHpo6XpvII9Rit/Y9Ecw60RDaIsmz6oypsGPdFVu1TKl+yObgIyTR6E56979E7Hihfi
         +2uwlTqdEDAkB5OvEvhs/2Bq0fghNzo5avLPxDNl1SOEUL8B+yUVoRxBe9LCIBow2JMR
         l5Kw==
X-Forwarded-Encrypted: i=1; AHgh+RqQfQQPizrfn6x67OvG9Kg2W2WnNl7W6JA73GixcHSGRjieOq+pv3+r7FKaMyUR8baNhhXfHxWnZp/bx+tzKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCOnO7UBUxZ5jFr8QPd1OBDKHxc/Rk9xbZ2uwpjvq7JdGfI+k
	cdn28QTkjtZhVUwaTBQ7qf8IqjmfjEaPON098a9U9J3JMEHUKWyXcTmh
X-Gm-Gg: AfdE7ckqhjLNWWY4M4weMQJTWlQiHGZZh1h2/flmrlmsJ6xAgB9g9wDCHCysAk+alTt
	FPTexmmhTF7iGixZp2c+vkwqHEVR1jO/guRU9vwZ83VyQj2uDxPssnKghJmAMp4kxu2rYMvGUun
	/gaILPDel63UCFkRJ7xwCWlgHM4yt1tep47U6dGiqN+CDjXE09lJn1NGRU7MvdcK604Y2v4qg1u
	dCplMXWjIy9PIUalw+e1KfldeMfUIF62zgHm8gqBS5097OhoZtqoQc4oCKk/79bBUHMcLJfwy9A
	+ab0Oy0775kp3aCTQIEB0oO2UYJp8zZULUlm4GsNWBMrdvjFqdPQiJEYrHyNrrqG5wJMS8MwYVu
	cDKLJMFe8YiJFheJ3aoXORUXNxIDL+XGaNxIPg3N4628tmeuUCcPZwv7ZCPx2LBE7sj5y1qJZx6
	fsk3q8+5ZaOh0OCmlyVjRkCSQ3a+28oxcfn/ISV/MPfVulfTJH3pf+nmwBVK20k484vTwwxRtQI
	MtkZbFa6Z8C7R5hJC/h+0/DlKI=
X-Received: by 2002:a05:600c:a4a:b0:495:3e81:770f with SMTP id 5b1f17b1804b1-4953e817874mr65600735e9.15.1784205283686;
        Thu, 16 Jul 2026 05:34:43 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4150:a2d7:2b6b:840e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm48582645e9.6.2026.07.16.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:34:43 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/8] clk: renesas: r9a09g077: Register SYSC regmap
Date: Thu, 16 Jul 2026 13:34:28 +0100
Message-ID: <20260716123434.2576253-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Register a syscon regmap for the System Controller (SYSC) integrated into
the RZ/T2H and RZ/N2H CPG block.

Unlike traditional Renesas CPG/MSSR implementations, the RZ/T2H and RZ/N2H
CPG block also integrates the SYSC, which provides low-power management,
clock monitoring, write protection and peripheral configuration registers
shared by multiple drivers.

Implement the RZ/T2H-specific .post_init() callback to create and register
a syscon regmap covering the SYSC register space using the CPG device node.
For backward compatibility, return without registering the regmap when the
mapped resources correspond to older Device Trees that expose only the
legacy 64 KiB CPG register window.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Dropped dangerous registers from writeable_readable list.
- Renamed sysc_init to post_init and updated signature to take
  cpg_mssr_pub struct.
- Created a single regmap covering both SYSC register regions
  instead of two separate regmaps.
- Updated commit message

v1->v2:
- Made use of for_each_child_of_node_scoped
- Moved sysc_init() to the end of the probe function
---
 drivers/clk/renesas/Kconfig            |   2 +
 drivers/clk/renesas/r9a09g077-cpg.c    | 130 +++++++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c |  18 +++-
 drivers/clk/renesas/renesas-cpg-mssr.h |   5 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 5c0238e878b7..d648ddc02fca 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -219,11 +219,13 @@ config CLK_R9A09G077
 	bool "RZ/T2H clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSSR
 	select CLK_RZV2H_CPG_LIB
+	select MFD_SYSCON
 
 config CLK_R9A09G087
 	bool "RZ/N2H clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSSR
 	select CLK_RZV2H_CPG_LIB
+	select MFD_SYSCON
 
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 5640c2035e5a..d58bfa46cad3 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/device.h>
@@ -15,7 +16,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -87,6 +90,19 @@ MODULE_IMPORT_NS("RZV2H_CPG");
 #define CPG_PLL_MON(x)		((x) - 0x10)
 #define CPG_PLL_MON_LOCK	BIT(0)
 
+#define RZT2H_SYSC_SIZE			0x20000
+#define RZT2H_SYSC_OFFSET		0x10000
+#define RZT2H_SYSC_BLOCK_MASK		BIT(16)
+#define RZT2H_SYSC_OFFSET_MASK		GENMASK(15, 0)
+#define RZT2H_SYSC_BLOCK(x)		FIELD_GET(RZT2H_SYSC_BLOCK_MASK, x)
+#define RZT2H_SYSC_REG_OFFSET(x)	FIELD_GET(RZT2H_SYSC_OFFSET_MASK, x)
+#define RZT2H_SYSC_BASE(b0, b1, x)	(RZT2H_SYSC_BLOCK(x) ? (b1) : (b0))
+
+struct r9a09g077_sysc_reg {
+	void __iomem *base0;
+	void __iomem *base1;
+};
+
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV = CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
@@ -875,6 +891,118 @@ r9a09g077_cpg_clk_register(struct device *dev, const struct cpg_core_clk *core,
 	}
 }
 
+static int r9a09g077_regmap_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct r9a09g077_sysc_reg *sysc = context;
+	void __iomem *base = RZT2H_SYSC_BASE(sysc->base0, sysc->base1, reg);
+
+	*val = readl(base + RZT2H_SYSC_REG_OFFSET(reg));
+
+	return 0;
+}
+
+static int r9a09g077_regmap_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct r9a09g077_sysc_reg *sysc = context;
+	void __iomem *base = RZT2H_SYSC_BASE(sysc->base0, sysc->base1, reg);
+
+	writel(val, base + RZT2H_SYSC_REG_OFFSET(reg));
+
+	return 0;
+}
+
+static const struct regmap_bus r9a09g077_sys_regmap_bus = {
+	.reg_write = r9a09g077_regmap_write,
+	.reg_read = r9a09g077_regmap_read,
+};
+
+static bool r9a09g077_writeable_readable_sysc0(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	/* ELOPA/B and GTIOCSEL */
+	case 0x0000 ... 0x0008:
+	/* Encoder config */
+	case 0x1000 ... 0x1164:
+	/* PCIe config */
+	case 0x2000 ... 0x2024:
+	case 0x2030 ... 0x2054:
+	case 0x2060:
+	/* xSPI config */
+	case 0x3000 ... 0x300C:
+	case 0x3100 ... 0x310C:
+	/* MD_MON */
+	case 0x4100:
+	/* PRCRN */
+	case 0x4200:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool r9a09g077_writeable_readable_sysc1(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	/* WDTDCRm */
+	case 0x5100 ... 0x5114:
+	/* PRCRS */
+	case 0x6000:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+static bool r9a09g077_writeable_readable_sysc(struct device *dev, unsigned int reg)
+{
+	if (RZT2H_SYSC_BLOCK(reg))
+		return r9a09g077_writeable_readable_sysc1(dev, RZT2H_SYSC_REG_OFFSET(reg));
+
+	return r9a09g077_writeable_readable_sysc0(dev, RZT2H_SYSC_REG_OFFSET(reg));
+}
+
+static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub *pub)
+{
+	struct regmap_config *regmap_cfg __free(kfree) = kzalloc_obj(*regmap_cfg);
+	struct r9a09g077_sysc_reg *sysc_reg;
+	struct regmap *regmap;
+
+	/*
+	 * Return early if the SYSC sizes are not as expected for backwards
+	 * compatibility with older device trees.
+	 */
+	if (pub->size0 != RZT2H_SYSC_SIZE || pub->size1 != RZT2H_SYSC_SIZE)
+		return 0;
+
+	if (!regmap_cfg)
+		return -ENOMEM;
+
+	sysc_reg = devm_kzalloc(dev, sizeof(*sysc_reg), GFP_KERNEL);
+	if (!sysc_reg)
+		return -ENOMEM;
+
+	/* Only allow access in the SYSC regions */
+	sysc_reg->base0 = pub->base0 + RZT2H_SYSC_OFFSET;
+	sysc_reg->base1 = pub->base1 + RZT2H_SYSC_OFFSET;
+
+	regmap_cfg->name = "rzt2h_sysc";
+	regmap_cfg->reg_bits = 32;
+	regmap_cfg->reg_stride = 4;
+	regmap_cfg->val_bits = 32;
+	regmap_cfg->fast_io = true;
+	regmap_cfg->max_register = RZT2H_SYSC_SIZE - 1;
+	regmap_cfg->readable_reg = r9a09g077_writeable_readable_sysc;
+	regmap_cfg->writeable_reg = r9a09g077_writeable_readable_sysc;
+
+	regmap = devm_regmap_init(dev, &r9a09g077_sys_regmap_bus, sysc_reg, regmap_cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return of_syscon_register_regmap(dev->of_node, regmap);
+}
+
 const struct cpg_mssr_info r9a09g077_cpg_mssr_info = {
 	/* Core Clocks */
 	.core_clks = r9a09g077_core_clks,
@@ -889,4 +1017,6 @@ const struct cpg_mssr_info r9a09g077_cpg_mssr_info = {
 
 	.reg_layout = CLK_REG_LAYOUT_RZ_T2H,
 	.cpg_clk_register = r9a09g077_cpg_clk_register,
+
+	.post_init = r9a09g077_post_init,
 };
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 80f4403ea2ba..2987c34f2ba2 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1267,6 +1267,7 @@ static int __init cpg_mssr_common_init(struct device *dev,
 {
 	struct cpg_mssr_priv *priv;
 	unsigned int nclks, i;
+	struct resource res;
 	int error;
 
 	if (info->init) {
@@ -1285,13 +1286,23 @@ static int __init cpg_mssr_common_init(struct device *dev,
 	priv->dev = dev;
 	spin_lock_init(&priv->pub.rmw_lock);
 
-	priv->pub.base0 = of_iomap(np, 0);
+	error = of_address_to_resource(np, 0, &res);
+	if (error)
+		return error;
+
+	priv->pub.size0 = resource_size(&res);
+	priv->pub.base0 = ioremap(res.start, priv->pub.size0);
 	if (!priv->pub.base0) {
 		error = -ENOMEM;
 		goto out_err;
 	}
 	if (info->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
-		priv->pub.base1 = of_iomap(np, 1);
+		error = of_address_to_resource(np, 1, &res);
+		if (error)
+			goto out_err;
+
+		priv->pub.size1 = resource_size(&res);
+		priv->pub.base1 = ioremap(res.start, priv->pub.size1);
 		if (!priv->pub.base1) {
 			error = -ENOMEM;
 			goto out_err;
@@ -1414,6 +1425,9 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 
 	error = cpg_mssr_reset_controller_register(priv);
 
+	if (!error && info->post_init)
+		error = info->post_init(priv->dev, &priv->pub);
+
 reserve_exit:
 	cpg_mssr_reserved_exit(priv);
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index ad11ab5f0069..5c160c1c37ec 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -43,14 +43,18 @@ struct cpg_core_clk {
  * struct cpg_mssr_pub - data shared with device-specific clk registration code
  *
  * @base0: CPG/MSSR register block base0 address
+ * @size0: CPG/MSSR register block base0 size
  * @base1: CPG/MSSR register block base1 address
+ * @size1: CPG/MSSR register block base1 size
  * @notifiers: Notifier chain to save/restore clock state for system resume
  * @rmw_lock: protects RMW register accesses
  * @clks: pointer to clocks
  */
 struct cpg_mssr_pub {
 	void __iomem *base0;
+	resource_size_t size0;
 	void __iomem *base1;
+	resource_size_t size1;
 	struct raw_notifier_head notifiers;
 	spinlock_t rmw_lock;
 	struct clk **clks;
@@ -178,6 +182,7 @@ struct cpg_mssr_info {
 
 	/* Callbacks */
 	int (*init)(struct device *dev);
+	int (*post_init)(struct device *dev, struct cpg_mssr_pub *pub);
 	struct clk *(*cpg_clk_register)(struct device *dev,
 					const struct cpg_core_clk *core,
 					const struct cpg_mssr_info *info,
-- 
2.54.0

