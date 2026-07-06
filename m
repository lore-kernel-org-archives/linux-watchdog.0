Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937B3BE16F
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349327; cv=none; b=WP+CHFJ2LJfF4Vlf5ifIfHSKM4E6Zid+XrjjONHhUVRhjdC1ulYK5uiTSZ1HuBT+PYC7cNsGQ0Q1YrIejSDezQTgR6jNkUuqETGNGrilYoJEgj25BnI4mK5XZ6WRNBOc9ZAnfs9r9hf0kPFOwLElMI/tMBRnWXUD63qplWTnpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349327; c=relaxed/simple;
	bh=2WMszP5nuAxuBz6AC35nwiSxvTcU8PZvDDhr8iiukR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdFpWZNP30Lgbp/jMxHOeRQhH2MebaZAPPY2w6s00mexvrs6ozoO7Y/4rQhxRvDY3/OAqmjK3krEC9jIm/Zk3GLqAviwT1wrAv2ky2S74LOv+Dycy+Beo6iK8FfGuxrFkhpdJoNs0veHWxhBxaIU0wKCU+3gW7ZMHDGdW3HKaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfEAFAgz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfEAFAgz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47362928f65so3066650f8f.2
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349323; x=1783954123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuDU45OA6ggrf4VYV6YQ5pMRzsYDccU2hT9CMU+OAX0=;
        b=dfEAFAgztKXRI0IK8s+Xlcbww5Bi2NgHAWzZwdcs4e1TMeg/lbl2R/v4gg/KIY4ngO
         oEuPCHXIHEKh+915rch6OekicTwCzuz3YB+oMZ2jEhusmeGOX5pL9diFv6YtuK5GYZFi
         s4/NeOzgGmHxBbCTpxIKSqFAs1TMevurjzAJxOO9T9tWmsS82Di7de4FfyOn2qsJJdTa
         nr1SiOvBeEJ1SCmbLdjoR4KEZfIdOEmWbQM4LZha3NYQyi4XfcwupGWydacSBxjkshxT
         SAexS1WAyg8pJVh5kzyBVymaSoeIsjg0MElWoNpIvup5Joh0d9mikn17PRKk7ZuEzxYz
         KiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349323; x=1783954123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuDU45OA6ggrf4VYV6YQ5pMRzsYDccU2hT9CMU+OAX0=;
        b=eD1jgPYLMofH6fQS88TDfSO3GZqkQJBacF/D7msGBZuw6ZyRcbQFuQ9jW+ljhiA9pg
         tpaacHWErpFSoQx+/G0lyGm2c+w0RvsOOjqouUDFGnknc6r/LswYOd1DZU9N0/x/MWLi
         gGAKaq8mGheNXnm0etpzeGLgr6WNVPBPIGrw64yNzy3c9cgYBQcL3fMHhE5En9/KyWfW
         bdj+fOou+yWv7/b/hM1EL9deb6SSu0heIQpfuIYgJXQu5l4W/VV2Mj2hPWoebr2ZLSZa
         2T8uepdt8GBTCVVnyFNCqE+GmylsNWjSPaiBC1byf00nW1quBkXpl7EBRGGGoYasxYWv
         X+zA==
X-Forwarded-Encrypted: i=1; AHgh+RrwENKTOkvNbSxoNsefjy98WfPUQkR5ZRmTtPa1lToSlAxKnEHPkxGJcBYZ9pky7hMceqT99Eyf8KfNyby/Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJHBHzcsQ7R9RlLV7L+jxNve8LTGgDgy/S0LfKXg7K+qIGzqd
	URiWilOwoGJGW6/X3WnFfvoe0r/2L2+fV+cUjZQglokg6OLJFXEh/Sc9
X-Gm-Gg: AfdE7cmfY4E+fcCYA7iG7hRNeqfxNTdIeU6zZu+XnUKFQRaStKnpmWNeYGEqpvUsFHE
	N5C21eD2EDEWYVoNmSLjI9/oowstc8M2KhP+JoYyz1Pv/O68FzN+IzC5g5VtC2rdHTxnjDjiF8n
	/WRPiCDvqFPgJEAKOQPjpnCjinz9eHbwJmpVBLgpSlrfUJrwf7S5iRT2KC43s41Ece3PRY0LCu+
	TCOmzeQg/N19IPPp4uDV0MTsXN2IJLzB51dBYmrexnkrhn3TrIVOwYotC+oH+1VcPhNo43VLRvs
	xQ5/RPmkeIWFaZHzjpQbmAwvcEQuXmAc9QtMz2OmUAxNzJL1XS/kZM3Dgbb5HkFRwBlEoeHT9Yb
	LKz7dAfNcYp7YGue0E+GUdgo3oEVELCaBjPBDDsrEhg6mwZSp+S9WcVv6j7RBuYYAo/wZR5O/Vq
	X/wNAB7c0VTr9KkNgD0mVGqPXPPHPMoH+pTw==
X-Received: by 2002:a5d:5304:0:b0:475:f0d1:eb63 with SMTP id ffacd0b85a97d-47de6656ca9mr608554f8f.48.1783349323396;
        Mon, 06 Jul 2026 07:48:43 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm26798473f8f.26.2026.07.06.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:48:42 -0700 (PDT)
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
Subject: [PATCH v4 3/3] watchdog: npcm: add bootstatus support
Date: Mon,  6 Jul 2026 17:48:28 +0300
Message-Id: <20260706144828.3517631-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706144828.3517631-1-tmaimon77@gmail.com>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
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

