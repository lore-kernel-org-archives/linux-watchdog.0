Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BF3F5BD7
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518390; cv=none; b=TQQ/5g6dJ0F+N8TREdoQL3vtLmkDGgrbn0TUtcNdzCLKY+GhnKouxYlYcOrJwKwjH8/IhzdlX8rDamn/grQe0XWpsGhQhbhFzPlI4RXyJUfUxGaOx5uFVAO9Nl33DLDE7KEcmlUcLM6oWFSpt4ZBKuYSBPFbEdfJZ9j5pHVTUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518390; c=relaxed/simple;
	bh=y2Pk+VKr2oWzmpdhICZM5jJqQo9EX4ZAox6PbNuyg78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nCEpOURCuS5tNRrfV7ZJf24j3ltGFfbeLSA80a0qsw4xo00wrB/NgTNPKb46hRLdqCA4+POfw3lc8DVVvfLcRzGFLNftrmSz923wBjRMKq7cp+HKN2DbnVifXHiph4+rLo41DwBK2bJclxvmiNDHLclPZjbAdgRTboynoeBZ/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=afBaOezW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="afBaOezW"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260927141300epoutp0320862b68dc07f99fd3efa05fd3f772c5~ZMvsX-hGr2812128121epoutp03U
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 14:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260927141300epoutp0320862b68dc07f99fd3efa05fd3f772c5~ZMvsX-hGr2812128121epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790518380;
	bh=uMKj4B80Sj+8Bg+qrBU/19l1aInp+KXwFHG5XTBxbss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afBaOezWGhvlJdnORaSqNUQh9By8VMCyinqailm9Vx1asCcQ63/05tZFDr4nWQXFg
	 dTCJLJh4YJ3hzoZbww+//T4ErMLx67PIFxe5BnkjDgMOD1TGqxdMK2HlSFTzA6HUcS
	 oikebQMqmA8gh8T5MSA0cSEEX4sDUQtJ875DeBRE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260927141259epcas5p4034b101541745c9a2e401176e7e71a37~ZMvrMEn5L2456524565epcas5p4i;
	Sun, 27 Sep 2026 14:12:59 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ht5xk6S7nz6B9m4; Sun, 27 Sep
	2026 14:12:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260927141258epcas5p12769f53e7911b72fd26dcbec15950b9b~ZMvqHdT_k2230922309epcas5p1Z;
	Sun, 27 Sep 2026 14:12:58 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260927141256epsmtip1857b0ce212901aefa21a5c8816ddaff9~ZMvoeVcMG2426324263epsmtip1L;
	Sun, 27 Sep 2026 14:12:56 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 2/2] watchdog: s3c2410_wdt: Add support for Exynos8855 SoC
Date: Sun, 27 Sep 2026 20:01:00 +0530
Message-Id: <20260927143100.3576195-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927143100.3576195-1-alim.akhtar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260927141258epcas5p12769f53e7911b72fd26dcbec15950b9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927141258epcas5p12769f53e7911b72fd26dcbec15950b9b
References: <20260927143100.3576195-1-alim.akhtar@samsung.com>
	<CGME20260927141258epcas5p12769f53e7911b72fd26dcbec15950b9b@epcas5p1.samsung.com>

Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
different then the previously support SoC.
Reuse the offset as much as from already supported SoC

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 7053963fb0ac..8ce4ca3e2aa8 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -58,6 +58,7 @@
 #define S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
 #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
+#define EXYNOS8855_RST_STAT_REG_OFFSET          0x10
 #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
 #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c
 #define EXYNOS850_CLUSTER0_NONCPU_OUT		0x1220
@@ -281,6 +282,26 @@ static const struct s3c2410_wdt_variant drv_data_exynos850_cl1 = {
 		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
 };
 
+static const struct s3c2410_wdt_variant drv_data_exynos8855_cl0 = {
+	.mask_reset_reg = EXYNOS850_CLUSTER0_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.mask_reset_inv = true,
+	.rst_stat_reg = EXYNOS8855_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = EXYNOS850_CLUSTER0_WDTRESET_BIT,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
+		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
+};
+
+static const struct s3c2410_wdt_variant drv_data_exynos8855_cl1 = {
+	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER1_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.mask_reset_inv = true,
+	.rst_stat_reg = EXYNOS8855_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = EXYNOSAUTOV9_CLUSTER0_WDTRESET_BIT,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
+		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
+};
+
 static const struct s3c2410_wdt_variant drv_data_exynos990_cl0 = {
 	.mask_reset_reg = GS_CLUSTER0_NONCPU_INT_EN,
 	.mask_bit = 2,
@@ -400,6 +421,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	  .data = &drv_data_exynos7 },
 	{ .compatible = "samsung,exynos850-wdt",
 	  .data = &drv_data_exynos850_cl0 },
+	{ .compatible = "samsung,exynos8855-wdt",
+	  .data = &drv_data_exynos8855_cl0 },
 	{ .compatible = "samsung,exynos990-wdt",
 	  .data = &drv_data_exynos990_cl0 },
 	{ .compatible = "samsung,exynosautov9-wdt",
@@ -723,6 +746,7 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 	/* Choose Exynos850/ExynosAutov9 driver data w.r.t. cluster index */
 	if (variant == &drv_data_exynos850_cl0 ||
 	    variant == &drv_data_exynosautov9_cl0 ||
+	    variant == &drv_data_exynos8855_cl0 ||
 	    variant == &drv_data_gs101_cl0 ||
 	    variant == &drv_data_exynosautov920_cl0 ||
 	    variant == &drv_data_exynos990_cl0) {
@@ -740,6 +764,8 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 		case 1:
 			if (variant == &drv_data_exynos850_cl0)
 				variant = &drv_data_exynos850_cl1;
+			else if (variant == &drv_data_exynos8855_cl0)
+				variant = &drv_data_exynos8855_cl1;
 			else if (variant == &drv_data_exynosautov9_cl0)
 				variant = &drv_data_exynosautov9_cl1;
 			else if (variant == &drv_data_gs101_cl0)
-- 
2.34.1

