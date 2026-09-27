Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484837F30A
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521790; cv=none; b=epdEkXjPz4ODfZoxyqeuiXRV+CRDYihpUch7miY2nBOtLx9JuSLHz9x2Zv0VW3SbMxq43WsydvZavD9S9VXRkdeZmLcMBkxRZzSe3DoS7VxqGZe2YuPLur+lWz0XN0JUQwP9o5zhEDmN+HMqiBUzv9fGl7A1d3uy1CvZrFtJSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521790; c=relaxed/simple;
	bh=TtY1udbB9gRXhhoa8lgh2rPwZAXk1yyxXBkV0bDcmsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kmurtymjkGpImvC6PDF6tyBMT2t5Zue5H8wn96p63/of+n47r8BgTUJeQhi3bdWiTiTf9Og8BFGaIIhRMR+v0udDBdpPd790X+3CmFxJDHcOKG1Kwlup8IYG7M7EO0R1Ke2N6ky1assJE7OlhluzLecrM/TcSA5AL3xzbqjkSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fk/Z4QbI; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fk/Z4QbI"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260927150946epoutp0242ccbec5554805da34dfc3bc656a5cd5~ZNhPzi1p10572305723epoutp028
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 15:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260927150946epoutp0242ccbec5554805da34dfc3bc656a5cd5~ZNhPzi1p10572305723epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790521786;
	bh=nDm4kQwri/+NG+rfAwqmk0AAalnRCMyPs6xBcvSRO3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fk/Z4QbIy2bY5AYjUxN8iEG0/TDhoO48+8W3UV5ZjhSlx9Jhl79uXmXqSu5juz+6l
	 Rm13Rg8oryBExvTcAWfKpz8yS3poo8CROpb6yYxkb6QUqMl6ilZmOn6/uNpA2ijXc6
	 p3/GGNK9iWjg2t66LXZyDITwjD84iNZ4IooAtPgQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260927150944epcas5p128db862a275cfc265e892e14263acc1b~ZNhOWY1AI1972919729epcas5p1g;
	Sun, 27 Sep 2026 15:09:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ht7CC6KQSz6B9m5; Sun, 27 Sep
	2026 15:09:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c~ZNhNKU8Lj1972919729epcas5p1d;
	Sun, 27 Sep 2026 15:09:43 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260927150941epsmtip14d660914bb453957f22c1a66c2850d5e~ZNhLhckoP2148721487epsmtip1Q;
	Sun, 27 Sep 2026 15:09:41 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add support for Exynos8855
 SoC
Date: Sun, 27 Sep 2026 20:57:38 +0530
Message-Id: <20260927152738.3673504-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927152738.3673504-1-alim.akhtar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c
References: <20260927152738.3673504-1-alim.akhtar@samsung.com>
	<CGME20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c@epcas5p1.samsung.com>

Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
different then the previously support SoC.
Reuse the offset as much as from already supported SoC

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---

*Changes in V2:
	- Fixed Sashiko review comments
		- [Low] watchdog: confusing reuse of CLUSTER0 macro for CLUSTER1
		- [Low] watchdog: space-based alignment for EXYNOS8855_RST_STAT_REG_OFFSET

 drivers/watchdog/s3c2410_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 7053963fb0ac..007c05ed2c7b 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -58,6 +58,7 @@
 #define S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
 #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
+#define EXYNOS8855_RST_STAT_REG_OFFSET		0x10
 #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
 #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c
 #define EXYNOS850_CLUSTER0_NONCPU_OUT		0x1220
@@ -73,6 +74,7 @@
 
 #define EXYNOS850_CLUSTER0_WDTRESET_BIT		24
 #define EXYNOS850_CLUSTER1_WDTRESET_BIT		23
+#define EXYNOS8855_CLUSTER1_WDTRESET_BIT	25
 #define EXYNOSAUTOV9_CLUSTER0_WDTRESET_BIT	25
 #define EXYNOSAUTOV9_CLUSTER1_WDTRESET_BIT	24
 #define EXYNOSAUTOV920_CLUSTER0_WDTRESET_BIT	0
@@ -281,6 +283,26 @@ static const struct s3c2410_wdt_variant drv_data_exynos850_cl1 = {
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
+	.rst_stat_bit = EXYNOS8855_CLUSTER1_WDTRESET_BIT,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
+		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
+};
+
 static const struct s3c2410_wdt_variant drv_data_exynos990_cl0 = {
 	.mask_reset_reg = GS_CLUSTER0_NONCPU_INT_EN,
 	.mask_bit = 2,
@@ -400,6 +422,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	  .data = &drv_data_exynos7 },
 	{ .compatible = "samsung,exynos850-wdt",
 	  .data = &drv_data_exynos850_cl0 },
+	{ .compatible = "samsung,exynos8855-wdt",
+	  .data = &drv_data_exynos8855_cl0 },
 	{ .compatible = "samsung,exynos990-wdt",
 	  .data = &drv_data_exynos990_cl0 },
 	{ .compatible = "samsung,exynosautov9-wdt",
@@ -723,6 +747,7 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 	/* Choose Exynos850/ExynosAutov9 driver data w.r.t. cluster index */
 	if (variant == &drv_data_exynos850_cl0 ||
 	    variant == &drv_data_exynosautov9_cl0 ||
+	    variant == &drv_data_exynos8855_cl0 ||
 	    variant == &drv_data_gs101_cl0 ||
 	    variant == &drv_data_exynosautov920_cl0 ||
 	    variant == &drv_data_exynos990_cl0) {
@@ -740,6 +765,8 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
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

