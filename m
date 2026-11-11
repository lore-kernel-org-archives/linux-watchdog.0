Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395245;
	b=WW7vEpzpg1NY8buH9lEn7229YvEJ9FqVgCYjhw8+WaRhUtE385ZF+LZGWaBusOdSiGJ1
	 DsIjyYyTHKlp8dDBFBycJQSike6p5hvoW7DLAuAekdclkCJhuhQrHm/IHhZPjz45nUEg2
	 K+DSmWMvxLRi/1zDzB+jv/5Y5CrWslUeDp3XiE4i9zfjxHb11EwOc1FKC3p29KJCburPz
	 FSkj5RJKQYsBMXow+9Hr+/GIlPQS0uJyjvAKvRhsEx0ACjl7nMybG12lpZ8+pAtXqLNUY
	 5peKcileQlXN31Ks5JuYU55MgL5A+s1JF5tdy4WE0WGrazJNdGpr5cSpWgWOLorn/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gTI8WAy0q1+CVS+DRTUGOER6F234ClULXsTZlYUKv28=;
	b=CxQFWDqQHV6Ku8KOgjSp3h4kNVp7xDBd8Szjwa79ZYV8iy7MmHTi9csqlDVtf6jCHJ9E
	 Djja/EjhYRhYbQtCOrkULnAlvFTc7rHkVvU74k3hB46K7bHS9n/YcY/MrzOUzDI/tQib6
	 +XBp16JwzvsZQa+aErqI5fov4va34a+1dRBJ0Xlmt2+lnux+XEzVxppckZz9IwtJpZy4R
	 n00veDRxBf32cYxY445F11t093BdvLQb57S7FcK1q77xwlK3KjMdgC/MROmRuWwIuThLI
	 eO1dBPxbo+LEpTcGEHGTOPb0J3s+CqP5dF6jZpicQ44Vs68NJK+eXd83kRPLbP9hxAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD0rp0Pf;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0904606A33F
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 11:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0904606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD0rp0Pf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so32053775e9.2
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395243; x=1795000043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTI8WAy0q1+CVS+DRTUGOER6F234ClULXsTZlYUKv28=;
        b=QD0rp0PfNrWAJ4Wg8B16+VDRB2fdI5THXEwcW4deMvW+vuJYAoHf8OrUukQZRcBnUN
         QUwQeGrVjS/JRAVNZgU0ZDY4WrbVu0OZmxRV8Um8JA13++uCEzjF3N/gnCPOFnxOUlRr
         DKjF/NHSAwnWC9nfFkC7KpF0nzsExj9HNSqY7COPX7ZiLLYfQRHLXQER5Ykba2lk4DNc
         Ke5G1ZlozrLY6jtLZcxW9AhxnXEGNv889A5Xt+AWbx3ECbngniLd0UTUVXrJxF2UD3Ue
         RmchQS+3MoUZ26pDpePBgRffYwx4UHOS9Zcrxp5Pa1MSiwmvM4mkQrYHrHoOek26kU7d
         iEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395243; x=1795000043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gTI8WAy0q1+CVS+DRTUGOER6F234ClULXsTZlYUKv28=;
        b=MB50FWCtAwlDQejnulgUgp0DHdCnSVrV66KexW/NMHX6KRYiUdgX4eqsvr1zHNT7rT
         LD1d3MobdB0tFdV1zKmsnJ0A5hoskgKVAKejhifm1oAu1O1duqJzG6qzCgoYIEAouE0z
         AC9rIbX36NMVibmwEnYNl588fN2+Ma41fuWt9+B2vpjlUuv9oHkeBQ1Jyus+xI1iYQ1+
         I7VitquXq0fj8xxughMSDBV72q09DDKD4U7vyjNgb0XV0ptos7MGdnsK3y3taNOE7s9s
         4VK/QirU8u1UawHdJdFZOfbR40gn++T+xWGgz2Xiu54I1MZtRbhy41hrLmAdOX6zgRpZ
         EpDw==
X-Forwarded-Encrypted: i=1; AL+hErGY1HiYPne8Xvjv48AR69QH5VBoEatk9TGpqfk4CH75wnuj/zdJOuwEeXR8jPOXdIoV9iwvJ+8jrlt4OZ5aDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+oNBLWsLGEl2ly9PhjKB+EARXZA4nJDrVS1Jiby7CsAJ5qjJz3
	z0axuu4cd6KltSznfA2m20Px0eOQSaqtsyWh5jIQssYTUa5Vzow9YyXJ
X-Gm-Gg: AYBFou1A1kWtDTUdhjkUBCcFFfAJo9jcROFD8aWPbSebE+NJ591C7f3JgZKeYQNhbxW
	ipwnWRBqSCRjXj5WGhq+VIcOJn18tu5F65J/TxRZcztaNJFS+w/W6rzrYXkRTKOWznLSXnNFcXA
	IQhC8Lgq6G8fhn55tqe0H6GjV9fREYvHVtHC3U/2L+7xbQN4EVFiZJquaKrmGbz86nR3eWISQA7
	krrtLJM7UcIdvAmNXfw2M9MNKMg+IJ/3G9zgZrzHItmDecElhogiitYe5kxDs8dt+jMRm2lE19w
	2c1yCOZzXRAx1vPKJ9yYSZWEB/rkPqB6QInZlo5rLMHRAvF5IS6lDHcMwa3Gh5PmXBDm+GDoVWJ
	wIwkvyhRNuC1hEo90SyjPKZQG9Z8p/Atj3m80U9CvSHkpGoAG0RH40bORKfLqeKO/CBMT7iPtYO
	hF/uHZOjAwyX2CgKx6KgwC6V1zH3eW9cHaQy/q8UoKWSfR0UtBZUVKd2s6bfBlAogs5D8danxlj
	iKJxFD2Qs72zFR7HJqVWI8Kg5+28KnH1Ce+Um3Mp7zftkrMUfzOVq437nNZXZMfYX4WoGKz+5Yy
	wGJ1QjPDDmSFuiI9FL7nBNIgGwiYB91GTSFJYWI3AfVcSIHGS2zJicAlMBPvRPXCwgmK9HGT6p/
	xy5F6Z/jn+bTRN3lgpDkSg9vckvYtEOBjl4jXxQ9UE7h7h5Jd6yi6nIuunKdE3BBL6SGGujN9jK
	4JRiJX6Hhd
X-Received: by 2002:a05:600d:82e3:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ba093953c6mr39112455e9.25.1794395243078;
        Wed, 11 Nov 2026 03:07:23 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm146727295e9.5.2026.11.11.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:07:22 -0800 (PST)
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
Subject: [PATCH v9 2/4] watchdog: rzv2h_wdt: Add syscon based WDTDCR access
Date: Wed, 11 Nov 2026 11:06:58 +0000
Message-ID: <20261111110700.3331225-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On RZ/T2H and RZ/N2H, WDTDCR is located in the SYS block rather than the
WDT register space. Allow the WDT driver to access it through the syscon
regmap exposed by the CPG driver. Retain support for the existing second
WDT register region for compatibility with older device trees.

The syscon regmap uses locks and cannot be used from the watchdog restart
handler, which runs in atomic context. Use the CPG helper for this path so
WDTDCR can be accessed without taking a lock, while continuing to use the
syscon regmap for normal start and stop operations.

Keep the WDTDCR start and stop helpers as void and treat the regmap
operations as best effort. Propagating errors from these MMIO-backed
accesses would complicate the control flow and error handling, while
the restart path in particular should make a best effort to restart
the system.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v8->v9
- Added Reviewed-by tag from Guenter

v7->v8:
- No change

v6->v7:
- Made use of rzt2h_cpg_wdtdcr_count_start() in restart handler
- Added if regmap is available, use it for WDTDCR access
- Updated commit message

v5->v6:
- No change

v4->v5:
- Code changes due to regmap_lock introduction.

v3->v4:
- No change

v2->v3:
- Made use of the new "renesas,sysc" phandle-array property to access the
  WDTDCR register via the CPG/MSSR syscon node.
- Updated commit message

v1->v2:
- No change.
---
 drivers/watchdog/rzv2h_wdt.c | 77 +++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 67869468edd8..91bc54ccf4dd 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -5,18 +5,23 @@
  * Copyright (C) 2024 Renesas Electronics Corporation.
  */
 #include <linux/clk.h>
+#include <linux/clk/renesas.h>
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
 #include <linux/stringify.h>
 #include <linux/units.h>
 #include <linux/watchdog.h>
 
+MODULE_IMPORT_NS("RZT2H_CPG");
+
 #define WDTRR			0x00	/* WDT Refresh Register RW, 8  */
 #define WDTCR			0x02	/* WDT Control Register RW, 16 */
 #define WDTSR			0x04	/* WDT Status Register RW, 16 */
@@ -44,6 +49,11 @@
 
 #define WDT_DEFAULT_TIMEOUT	60U
 
+#define RZT2H_WDT_MAX_INSTANCES	6
+
+#define RZT2H_SYS_BLOCK1_BASE	(BIT(16) | 0x5100)
+#define RZT2H_WDTDCR_OFFSET(n)	(RZT2H_SYS_BLOCK1_BASE + (n) * 4)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -64,6 +74,12 @@ struct rzv2h_of_data {
 	bool wdtdcr;
 };
 
+struct rzv2h_sysc_wdtdcr {
+	struct regmap *regmap;
+	unsigned int offset;
+	unsigned int wdt_index;
+};
+
 struct rzv2h_wdt_priv {
 	void __iomem *base;
 	void __iomem *wdtdcr;
@@ -72,6 +88,7 @@ struct rzv2h_wdt_priv {
 	struct reset_control *rstc;
 	struct watchdog_device wdev;
 	const struct rzv2h_of_data *of_data;
+	struct rzv2h_sysc_wdtdcr sysc;
 };
 
 static int rzv2h_wdt_ping(struct watchdog_device *wdev)
@@ -90,18 +107,50 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 
 static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+	u32 reg;
+
+	if (sysc->regmap) {
+		/* Ignore the theoretical regmap error */
+		regmap_set_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL);
+		return;
+	}
 
+	reg = readl(priv->wdtdcr + WDTDCR);
 	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
 }
 
 static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+	u32 reg;
+
+	if (sysc->regmap) {
+		/* Ignore the theoretical regmap error */
+		regmap_clear_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL);
+		return;
+	}
 
+	reg = readl(priv->wdtdcr + WDTDCR);
 	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
 }
 
+/*
+ * Restart runs in atomic context, so the syscon regmap must not be used.
+ * Go through the CPG helper, which writes the register directly.
+ */
+static void rzt2h_wdt_wdtdcr_count_start_atomic(struct rzv2h_wdt_priv *priv)
+{
+	struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+
+	if (sysc->regmap) {
+		rzt2h_cpg_wdtdcr_count_start(sysc->wdt_index);
+		return;
+	}
+
+	rzt2h_wdt_wdtdcr_count_start(priv);
+}
+
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
 {
 	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
@@ -234,7 +283,7 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 			WDTCR_RPES_75 | WDTCR_TOPS_1024);
 
 	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+		rzt2h_wdt_wdtdcr_count_start_atomic(priv);
 
 	rzv2h_wdt_ping(wdev);
 
@@ -255,9 +304,25 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->wdtdcr))
-		return PTR_ERR(priv->wdtdcr);
+	struct device_node *np = dev_of_node(&pdev->dev);
+
+	if (of_property_present(np, "renesas,sysc")) {
+		struct rzv2h_sysc_wdtdcr *sysc = &priv->sysc;
+
+		sysc->regmap = syscon_regmap_lookup_by_phandle_args(np, "renesas,sysc",
+								    1, &sysc->wdt_index);
+		if (IS_ERR(sysc->regmap))
+			return PTR_ERR(sysc->regmap);
+
+		if (sysc->wdt_index >= RZT2H_WDT_MAX_INSTANCES)
+			return -EINVAL;
+
+		sysc->offset = RZT2H_WDTDCR_OFFSET(sysc->wdt_index);
+	} else {
+		priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(priv->wdtdcr))
+			return PTR_ERR(priv->wdtdcr);
+	}
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-- 
2.56.1

