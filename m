Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B37AA91
	for <linux-watchdog@vger.kernel.org>; Sun,  5 Jul 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260078; cv=none; b=mEEob/D6AHczubV3NnVufge9up1X3Bh5SLQ7oN2vdJlhEYKmQ9PRfNc2vCMDK/zPjAgVrrO5i2bnwmQ5k8BK9EJV5NhhftlJsaQs9sCDbXXflc+cek6ERWR+0eOM8jGYz6wT/XoqLcZn6rhEhxiN0qnEBP5J72czbpkb6FGJEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260078; c=relaxed/simple;
	bh=2WMszP5nuAxuBz6AC35nwiSxvTcU8PZvDDhr8iiukR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iH1Ow83H8/bqY7Z4wXO+wP+0YOrXv/tcawLAqN878iENkE312iuXYpw/CGprbB0s6f2Uq+0rSIkLjUbnmmmoHGF9XbUOzELqBWo9jB9QdchENVaUULrFvCIR3chKI+mMxv6BmqL62wuEc6VlhC9ZCZ/Y/ambCepjwLYQoROdQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKcyZsD0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKcyZsD0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so19024245e9.1
        for <linux-watchdog@vger.kernel.org>; Sun, 05 Jul 2026 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260075; x=1783864875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuDU45OA6ggrf4VYV6YQ5pMRzsYDccU2hT9CMU+OAX0=;
        b=mKcyZsD0yzHa5gXFmYrw9n+APUR0npFKMan2459yqUbL+WhL/4taK5dWJ3KqIgAW5C
         bm0PbQXr2KS3oRUKBigHyo4Ss2jzCfd+ZV5DiKAZsWQxqavSdkQjWqvz0/I1tUj+B+3M
         6g7VPPS4iZDKNNg6WubAqXwCW+w0fSfqYI1pk+AEvN9HZlFox7a1QJ9JEk33d54Xm3lz
         97Fu9ut5JacsJG/OzOulJ3rOjVvfdRDZjbDoxE7nfOqbqz3A79wUpmg0q+nOn++AVUgq
         RZJC+G6rOwxDYB5IxZWaxmKJvQD/T3f/ANv++Pwc7imNhTKWeP0YRfskZKfn4eZ3NX7c
         w1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260075; x=1783864875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuDU45OA6ggrf4VYV6YQ5pMRzsYDccU2hT9CMU+OAX0=;
        b=koNnSVxEqUiW9bQbE3de9UMV6qi9iAInU6pR53wQx0678nVuEUmzVpXkybc70nwrDe
         Tg0yLfR8zA+6l4G1XvCm3ANOH0llEekfQ2YPVOf/CFyitRHHP1X7qRPfPjzgRLGMgjrA
         LChSWLsgW02a0MN7UAm0KIArad0nsosowZUNuyT0GVTOva+tjQSpqopfmY+DG3mSKy5M
         WBx3nzqOo0UegbsDRb+Kp8YRLYPK//BCOgJJNLXDtxNKnAVlbFUJdG7dIf/uBEhsOYwN
         AhqY0t7oPJhuTna9xT/5LNE5WSAjYGnExQAWxuDYBwozQ2mN74fEJtkG6omzTmFNq1FF
         1jwg==
X-Forwarded-Encrypted: i=1; AFNElJ9FCwUZu0BUXwXH0PSoYAskBZfN6HpvKsn1nMmyM0DYVbT8cVXurwTM0twlGYI4dLblBYSmha2npqVDposm8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaDS5BhYUJKZdwvc420KNK/g/Tpy3TCO/YgXgmq7tlNo02sPQ
	yY+f5G3PM+9Rq6uvxdv6k0rlP7auKVEUUXJ6fvnt0RCJBLt20xrBSIKg
X-Gm-Gg: AfdE7clMNJbl3B9DzqGjU+bGnPKntHfhgaEa0cjr/3W2ncphs6oFdcRYYPKZUE8l/85
	4WahxNOYVZ6s63wOTy95/SW14PVzAphCYdhXBdEVzNeKRUvfhmhv027J7h2KCcvUxR1YmJIhfNm
	1L8Yx/xnGqScQ8wQQAmuxt8yjKBnWIikL1FxeVcCr+8Gom2kH+gV+XZis9qMbAanAmKZVMTcaLy
	uMcY99gf9Dn61+WzYG6lECZjPLNTRFqn/YwSLlQLGKSKifXdHJy+dDHnQZu+MtUATMjjhTGaGpc
	t+40ySKdPOyw1Uj36MbLuSSO7uzsmE4GMqCPdx1mapIbb5XfiBuEGIrmfq9OgucQ3ueyj1CtbiE
	3QyjbPidCiVQDRiSYhcAsP2N08Afdof4rh/rcJ1KHkAzda3aGpxMzUmyaV4aJjmkKb9Y1mZYygZ
	0MAVJgzjQTB853QV9b475kWonip+Kx3i38qg==
X-Received: by 2002:a05:600c:3515:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-493d11894f7mr81253085e9.0.1783260074531;
        Sun, 05 Jul 2026 07:01:14 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm275911115e9.10.2026.07.05.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:01:14 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	joel@jms.id.au
Subject: [PATCH v3 3/3] watchdog: npcm: add bootstatus support
Date: Sun,  5 Jul 2026 17:01:00 +0300
Message-Id: <20260705140100.1543486-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260705140100.1543486-1-tmaimon77@gmail.com>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset
indications. Read those bits during probe and map them into watchdog
bootstatus flags.

For NPCM845, cache the sampled INTCR2 state in SCRPAD10 after the reset
status bits are cleared so later probes can report the same boot-time
state. Also report WDIOF_CARDRESET for the watchdog instance whose reset
bit is latched, while leaving WPCM450 behavior unchanged.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/watchdog/npcm_wdt.c | 217 +++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index e62ea054bc61..cecfd6e574d8 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -7,14 +7,52 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
 #define NPCM_WTCR	0x1C
 
+/* NPCM GCR module */
+#define NPCM_RESSR_OFFSET		0x6C
+#define NPCM_INTCR2_OFFSET		0x60
+#define NPCM7XX_SCRPAD2_OFFSET		0x84
+#define NPCM8XX_SCRPAD10_OFFSET		0xE28
+
+#define NPCM_PORST			BIT(31)
+#define NPCM_CORST			BIT(30)
+#define NPCM_WD0RST			BIT(29)
+#define NPCM_SWR1RST			BIT(28)
+#define NPCM_SWR2RST			BIT(27)
+#define NPCM_SWR3RST			BIT(26)
+#define NPCM_SWR4RST			BIT(25)
+#define NPCM_WD1RST			BIT(24)
+#define NPCM_WD2RST			BIT(23)
+#define NPCM_RST			GENMASK(31, 23)
+#define NPCM8XX_TIP_RESET		BIT(25) /* Replaces SWRST4 on NPCM8xx */
+
+/* Per-instance mapping of MMIO base address to its RESSR/INTCR2 reset bit. */
+struct npcm_wdt_rst_map {
+	phys_addr_t	base;
+	u32		rst_bit;
+};
+
+struct npcm_wdt_status_map {
+	u32	rst_bit;
+	u32	wdiof_flag;
+};
+
+struct npcm_wdt_data {
+	const struct npcm_wdt_rst_map		*rst_map;
+	unsigned int				rst_map_size;
+	const struct npcm_wdt_status_map	*status_map;
+	unsigned int				status_map_size;
+};
+
 #define NPCM_WTCLK	(BIT(10) | BIT(11))	/* Clock divider */
 #define NPCM_WTE	BIT(7)			/* Enable */
 #define NPCM_WTIE	BIT(6)			/* Enable irq */
@@ -47,6 +85,50 @@ struct npcm_wdt {
 	struct clk		*clk;
 };
 
+static const struct npcm_wdt_rst_map npcm750_rst_map[] = {
+	{ 0xf000801c, NPCM_WD0RST },
+	{ 0xf000901c, NPCM_WD1RST },
+	{ 0xf000a01c, NPCM_WD2RST },
+};
+
+static const struct npcm_wdt_status_map npcm750_status_map[] = {
+	{ NPCM_PORST, WDIOF_OVERHEAT },
+	{ NPCM_CORST, WDIOF_FANFAULT },
+	{ NPCM_SWR1RST, WDIOF_EXTERN1 },
+	{ NPCM_SWR2RST, WDIOF_EXTERN2 },
+	{ NPCM_SWR3RST, WDIOF_POWERUNDER },
+	{ NPCM_SWR4RST, WDIOF_POWEROVER },
+};
+
+static const struct npcm_wdt_data npcm750_data = {
+	.rst_map = npcm750_rst_map,
+	.rst_map_size = ARRAY_SIZE(npcm750_rst_map),
+	.status_map = npcm750_status_map,
+	.status_map_size = ARRAY_SIZE(npcm750_status_map),
+};
+
+static const struct npcm_wdt_rst_map npcm845_rst_map[] = {
+	{ 0xf000801c, NPCM_WD0RST },
+	{ 0xf000901c, NPCM_WD1RST },
+	{ 0xf000a01c, NPCM_WD2RST },
+};
+
+static const struct npcm_wdt_status_map npcm845_status_map[] = {
+	{ NPCM_PORST, WDIOF_OVERHEAT },
+	{ NPCM_CORST, WDIOF_FANFAULT },
+	{ NPCM_SWR1RST, WDIOF_EXTERN1 },
+	{ NPCM_SWR2RST, WDIOF_EXTERN2 },
+	{ NPCM_SWR3RST, WDIOF_POWERUNDER },
+	{ NPCM8XX_TIP_RESET, WDIOF_POWEROVER },
+};
+
+static const struct npcm_wdt_data npcm845_data = {
+	.rst_map = npcm845_rst_map,
+	.rst_map_size = ARRAY_SIZE(npcm845_rst_map),
+	.status_map = npcm845_status_map,
+	.status_map_size = ARRAY_SIZE(npcm845_status_map),
+};
+
 static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
 {
 	return container_of(wdd, struct npcm_wdt, wdd);
@@ -169,6 +251,111 @@ static bool npcm_is_running(struct watchdog_device *wdd)
 	return readl(wdt->reg) & NPCM_WTE;
 }
 
+static void npcm_get_reset_status(struct npcm_wdt *wdt, struct device *dev,
+				  const struct npcm_wdt_data *data,
+				  resource_size_t start)
+{
+	struct regmap *gcr_regmap;
+	u32 rstval = 0;
+	unsigned int i;
+	int ret;
+
+	if (!data)
+		return;
+
+	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "nuvoton,sysgcr");
+	if (IS_ERR(gcr_regmap)) {
+		dev_warn(dev,
+			 "Failed to find nuvoton,sysgcr, WD reset status not supported\n");
+		return;
+	}
+
+	if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt")) {
+		ret = regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstval);
+		if (ret) {
+			dev_warn(dev, "Failed to read INTCR2 reset status: %d\n",
+				 ret);
+			return;
+		}
+
+		if (rstval & NPCM_RST) {
+			ret = regmap_write(gcr_regmap, NPCM_INTCR2_OFFSET,
+					   rstval & ~NPCM_RST);
+			if (ret) {
+				dev_warn(dev,
+					 "Failed to clear INTCR2 reset status: %d\n",
+					 ret);
+				return;
+			}
+
+			ret = regmap_write(gcr_regmap, NPCM8XX_SCRPAD10_OFFSET,
+					   rstval);
+			if (ret) {
+				dev_warn(dev,
+					 "Failed to cache reset status in SCRPAD10: %d\n",
+					 ret);
+				return;
+			}
+		} else {
+			ret = regmap_read(gcr_regmap, NPCM8XX_SCRPAD10_OFFSET,
+					  &rstval);
+			if (ret) {
+				dev_warn(dev,
+					 "Failed to read cached reset status from SCRPAD10: %d\n",
+					 ret);
+				return;
+			}
+		}
+	} else if (of_device_is_compatible(dev->of_node, "nuvoton,npcm750-wdt")) {
+		ret = regmap_read(gcr_regmap, NPCM_RESSR_OFFSET, &rstval);
+		if (ret) {
+			dev_warn(dev, "Failed to read RESSR reset status: %d\n",
+				 ret);
+			return;
+		}
+
+		if (rstval & NPCM_RST) {
+			ret = regmap_write(gcr_regmap, NPCM_RESSR_OFFSET, 
+					   rstval & ~NPCM_RST);
+			if (ret) {
+				dev_warn(dev, "Failed to clear RESSR reset status: %d\n", ret);
+				return;
+			}
+
+			ret = regmap_write(gcr_regmap, NPCM7XX_SCRPAD2_OFFSET,
+					   rstval);
+			if (ret) {
+				dev_warn(dev,
+					 "Failed to cache reset status in SCRPAD2: %d\n", ret);
+				return;
+			}
+		} else {
+			ret = regmap_read(gcr_regmap, NPCM7XX_SCRPAD2_OFFSET,
+					  &rstval);
+			if (ret) {
+				dev_warn(dev,
+					 "Failed to read cached reset status from SCRPAD2: %d\n",
+					 ret);
+				return;
+			}
+		}
+	}
+
+	for (i = 0; i < data->status_map_size; i++) {
+		if (rstval & data->status_map[i].rst_bit)
+			wdt->wdd.bootstatus |= data->status_map[i].wdiof_flag;
+	}
+
+	for (i = 0; i < data->rst_map_size; i++) {
+		if (data->rst_map[i].base == start &&
+		    rstval & data->rst_map[i].rst_bit) {
+			wdt->wdd.bootstatus |= WDIOF_CARDRESET;
+			break;
+		}
+	}
+}
+
 static const struct watchdog_info npcm_wdt_info = {
 	.identity	= KBUILD_MODNAME,
 	.options	= WDIOF_SETTIMEOUT
@@ -176,6 +363,20 @@ static const struct watchdog_info npcm_wdt_info = {
 			| WDIOF_MAGICCLOSE,
 };
 
+static const struct watchdog_info npcm_wdt_rst_info = {
+	.identity	= KBUILD_MODNAME,
+	.options	= WDIOF_SETTIMEOUT
+			| WDIOF_KEEPALIVEPING
+			| WDIOF_MAGICCLOSE
+			| WDIOF_CARDRESET
+			| WDIOF_OVERHEAT
+			| WDIOF_FANFAULT
+			| WDIOF_EXTERN1
+			| WDIOF_EXTERN2
+			| WDIOF_POWERUNDER
+			| WDIOF_POWEROVER,
+};
+
 static const struct watchdog_ops npcm_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = npcm_wdt_start,
@@ -188,7 +389,10 @@ static const struct watchdog_ops npcm_wdt_ops = {
 static int npcm_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct npcm_wdt_data *data = device_get_match_data(dev);
+	struct resource *res;
 	struct npcm_wdt *wdt;
+	resource_size_t start;
 	int irq;
 	int ret;
 
@@ -196,10 +400,16 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
 	wdt->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->reg))
 		return PTR_ERR(wdt->reg);
 
+	start = res->start;
+
 	wdt->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return PTR_ERR(wdt->clk);
@@ -208,7 +418,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	wdt->wdd.info = &npcm_wdt_info;
+	wdt->wdd.info = data ? &npcm_wdt_rst_info : &npcm_wdt_info;
 	wdt->wdd.ops = &npcm_wdt_ops;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 2750;
@@ -220,6 +430,8 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	/* Ensure timeout is able to be represented by the hardware */
 	npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
 
+	npcm_get_reset_status(wdt, dev, data, start);
+
 	if (npcm_is_running(&wdt->wdd)) {
 		/* Restart with the default or device-tree specified timeout */
 		npcm_wdt_start(&wdt->wdd);
@@ -243,7 +455,8 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id npcm_wdt_match[] = {
 	{.compatible = "nuvoton,wpcm450-wdt"},
-	{.compatible = "nuvoton,npcm750-wdt"},
+	{.compatible = "nuvoton,npcm750-wdt", .data = &npcm750_data},
+	{.compatible = "nuvoton,npcm845-wdt", .data = &npcm845_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, npcm_wdt_match);
-- 
2.34.1

