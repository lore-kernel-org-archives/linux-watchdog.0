Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D94248CF
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994761; cv=none; b=bfzKjtzkzQQ5XbRiRJ+Ju7670IuQkd9qneEl0jTr3URWTaL4Tq/8lFTJ4KTlmDy+KP245/+86LuqEkD84fBDhCk3qgCODpdHlIkVzvod2wkhc/bKrhS1DbrJMj9h4J56DHFKoL6V7IZG3++lod/IvuLu0yina1ffsSL/1pOB+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994761; c=relaxed/simple;
	bh=JMlnOwy00wDEbAfza6sr9cE+BuAcXlyzfpQbLz5OvTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTpWtAEqZ32NMysqiUi6d9x+tAVh9X3xeZXh8EeL7MrVzO+dKnIz9MS0L1aF95a6URs9aBi+zYhgLQcF9wPOFZe/jKtQxa2if7CNdnu9COeCy2Hqpdo9a0JpaGNZPZ1uASXbkjs9z7IY3N1DTLZRh3NxzyfEbxgaSBxfoo2gsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9Si5qkG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9Si5qkG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so2522095ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994759; x=1787599559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5fBKIKgzNd7gWhqnVVDaPgInr0GNymDhy+5aCajQgo=;
        b=S9Si5qkGVvfWRNrlO8rBZdERQMtxX9b7FXvEE8xseHm3YDVlfoC3JyGo79m2AQTMVo
         VHQomorMQPEagNmyAWgsdSd3ZTyyOc70ASUXyTqe1Nw+G/s66iwQU+qOT7jyzvezp83C
         U3YwjgbsRH7umpWvvi2QoZtsSjN5CLfWqdg2lnyssK/Bmo6iK8aHujEoqOCVeme6dpcD
         Brz5duvaQ+kwqD/DwFvgEp/o9OtLWIRfbhQBlmDBu2IL5eX4yQ5xUGhq/7ntESQVdjiS
         xPrsaZNxM6Bz9YSjVbSq6hIt/VbHymsyDIQu0m7mnKrBqqJeWbMUSeXv3ryAOyUK6ntX
         kL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994759; x=1787599559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5fBKIKgzNd7gWhqnVVDaPgInr0GNymDhy+5aCajQgo=;
        b=nQ+oekNalpSes59dWjU6oixwfXRgQ/ZzlREV+SxngmZ5VhE90iKJD8p510Ze5ZNOuY
         WunUSag7k24hJDk1smp1Ewvqnm8zmNiC0Q6MJDVHhYr5DMbj5/B/bg4x6SHDtWEaWnoz
         H+WkUKUJIoEN2juhrJtp47YMJZxTVbG5p/1ilB4JWdH9p371xDc43CJm5F/3ar6vdsQB
         gFFnfExoGNv3PW5EKUprk5lf3Ief0tvZ213/GNxV78UGb51X5ZvdnngCDyH93zAkNf4Z
         kvmtiLwY47RXxdV+3s+oiCAOkHayNJXdwGYLQ8hEzypLgNhHnQk8UvCA8kE0raDVGgTW
         wPOA==
X-Gm-Message-State: AOJu0Yx6H0jzR+7uvPtylvPIK2LxrD3pdTCJzJ/74efLQ4PLTwtBw5yw
	LavgTsBsuIShpdYs4O7TrBkKWgLSokRVMnnD87vZifuZwk+K1fzFn3Jf
X-Gm-Gg: AR+sD11qc44Q+eOxH9nRcMuzUoU/Fjo7mmlyodfUvyziIsJp4BGpEIeUJzwbnupBrXE
	GmyN7KhBNlXdz0SXH89xqvHAvGUqo1eNjehXl0c5uU79jILhz2kCWJercjThYuueloD8hZSpoyY
	TgG3HoEpcHnfO4nJ2Z9ufzajXnrDSG+QFOwTq+tAt5SgHvedx1SOaqrAZ1QWvbT2iUMbhZa1pBm
	71FkQWypQEn6Mdmay0lvi8CdItXrlNZWZX8dbUuTuwUIj68jv2Ifu+Nin13HjuJUO/rkXUpdwHK
	hxKYyrdszwu5ae69jvrcmQTYqKD2rK+WbiwaFP1abg+5hRcvAGI+hHSe23+gzY8L8jWZFaOSgcg
	oogzpaVAfxRYIUf+mBo3LcQb5o/1D2mIJBPX5Z90UZ30yRsc0deERaD8pSQSf6HsiiJhkXGs641
	/chKPFZpk8/XJz76O4c12ShStFmvi7VOkpG2xlBao8EE5Wa3bFAU8uhoYUWXfuO0qPGatD1n/+e
	fPwaT+YCWVAhRZHtQDm2FF7eVFKMdPSs0V+9rEuxKCrnPJFw8mnkebqYtNzbiOxw/eFoNHmlvGX
	i9D9ouH50w==
X-Received: by 2002:a17:903:1983:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2d5cac52c6amr10888055ad.6.1786994759276;
        Mon, 17 Aug 2026 12:25:59 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:25:58 -0700 (PDT)
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
Subject: [PATCH v4 1/7] clk: renesas: r9a09g077: Register SYSC regmap
Date: Mon, 17 Aug 2026 20:25:34 +0100
Message-ID: <20260817192540.423994-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v3->v4:
- Dropped RZT2H_SYSC_BASE macro
- Added array of base pointers to the r9a09g077_sysc_reg struct to
  support multiple SYSC regions
- Merged r9a09g077_writeable_readable_sysc0 and
  r9a09g077_writeable_readable_sysc1 into a single function
  that checks the SYSC block and offset to determine if the register is
  readable/writable.
- Added RZT2H_CPG_REG_SIZE macro
- Updated r9a09g077_post_init() to call of_address_to_resource() to check
  the size of the mapped CPG register regions
- Dropped changes from cpg_mssr_common_init

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
 drivers/clk/renesas/r9a09g077-cpg.c    | 140 +++++++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c |   3 +
 drivers/clk/renesas/renesas-cpg-mssr.h |   1 +
 4 files changed, 146 insertions(+)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 17b95a2e96fb..46b929e9872b 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -223,11 +223,13 @@ config CLK_R9A09G077
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
index 5640c2035e5a..0495e3206973 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/device.h>
@@ -15,7 +16,10 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -87,6 +91,20 @@ MODULE_IMPORT_NS("RZV2H_CPG");
 #define CPG_PLL_MON(x)		((x) - 0x10)
 #define CPG_PLL_MON_LOCK	BIT(0)
 
+/* Size of each mapped CPG/MSSR register region (base0, base1) */
+#define RZT2H_CPG_REG_SIZE		0x20000
+/* This is the size of two SYSC regions combined */
+#define RZT2H_SYSC_SIZE			0x20000
+#define RZT2H_SYSC_OFFSET		0x10000
+#define RZT2H_SYSC_BLOCK_MASK		BIT(16)
+#define RZT2H_SYSC_OFFSET_MASK		GENMASK(15, 0)
+#define RZT2H_SYSC_BLOCK(x)		FIELD_GET(RZT2H_SYSC_BLOCK_MASK, x)
+#define RZT2H_SYSC_REG_OFFSET(x)	FIELD_GET(RZT2H_SYSC_OFFSET_MASK, x)
+
+struct r9a09g077_sysc_reg {
+	void __iomem *base[2];
+};
+
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV = CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
@@ -875,6 +893,126 @@ r9a09g077_cpg_clk_register(struct device *dev, const struct cpg_core_clk *core,
 	}
 }
 
+static int r9a09g077_regmap_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct r9a09g077_sysc_reg *sysc = context;
+	void __iomem *base = sysc->base[RZT2H_SYSC_BLOCK(reg)];
+
+	*val = readl(base + RZT2H_SYSC_REG_OFFSET(reg));
+
+	return 0;
+}
+
+static int r9a09g077_regmap_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct r9a09g077_sysc_reg *sysc = context;
+	void __iomem *base = sysc->base[RZT2H_SYSC_BLOCK(reg)];
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
+static bool r9a09g077_writeable_readable_sysc(struct device *dev, unsigned int reg)
+{
+	unsigned int offset = RZT2H_SYSC_REG_OFFSET(reg);
+
+	switch (RZT2H_SYSC_BLOCK(reg)) {
+	case 0:
+		switch (offset) {
+		/* ELOPA/B and GTIOCSEL */
+		case 0x0000 ... 0x0008:
+		/* Encoder config */
+		case 0x1000 ... 0x1164:
+		/* PCIe config */
+		case 0x2000 ... 0x2024:
+		case 0x2030 ... 0x2054:
+		case 0x2060:
+		/* xSPI config */
+		case 0x3000 ... 0x300C:
+		case 0x3100 ... 0x310C:
+		/* MD_MON */
+		case 0x4100:
+		/* PRCRN */
+		case 0x4200:
+			return true;
+
+		default:
+			return false;
+		}
+	case 1:
+		switch (offset) {
+		/* WDTDCRm */
+		case 0x5100 ... 0x5114:
+		/* PRCRS */
+		case 0x6000:
+			return true;
+
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+
+static int r9a09g077_post_init(struct device *dev, struct cpg_mssr_pub *pub)
+{
+	struct regmap_config *regmap_cfg __free(kfree) = kzalloc_obj(*regmap_cfg);
+	struct r9a09g077_sysc_reg *sysc_reg;
+	struct regmap *regmap;
+	struct resource res;
+	int ret;
+
+	/*
+	 * Return early if the SYSC sizes are not as expected, for backwards
+	 * compatibility with older device trees that only expose the 64 KiB
+	 * CPG register window.
+	 */
+	ret = of_address_to_resource(dev->of_node, 0, &res);
+	if (ret)
+		return ret;
+	if (resource_size(&res) != RZT2H_CPG_REG_SIZE)
+		return 0;
+
+	ret = of_address_to_resource(dev->of_node, 1, &res);
+	if (ret)
+		return ret;
+	if (resource_size(&res) != RZT2H_CPG_REG_SIZE)
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
+	sysc_reg->base[0] = pub->base0 + RZT2H_SYSC_OFFSET;
+	sysc_reg->base[1] = pub->base1 + RZT2H_SYSC_OFFSET;
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
@@ -889,4 +1027,6 @@ const struct cpg_mssr_info r9a09g077_cpg_mssr_info = {
 
 	.reg_layout = CLK_REG_LAYOUT_RZ_T2H,
 	.cpg_clk_register = r9a09g077_cpg_clk_register,
+
+	.post_init = r9a09g077_post_init,
 };
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 80f4403ea2ba..f2feac1cc74f 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1414,6 +1414,9 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 
 	error = cpg_mssr_reset_controller_register(priv);
 
+	if (!error && info->post_init)
+		error = info->post_init(priv->dev, &priv->pub);
+
 reserve_exit:
 	cpg_mssr_reserved_exit(priv);
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index ad11ab5f0069..5bef6f34dcb2 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -178,6 +178,7 @@ struct cpg_mssr_info {
 
 	/* Callbacks */
 	int (*init)(struct device *dev);
+	int (*post_init)(struct device *dev, struct cpg_mssr_pub *pub);
 	struct clk *(*cpg_clk_register)(struct device *dev,
 					const struct cpg_core_clk *core,
 					const struct cpg_mssr_info *info,
-- 
2.43.0

