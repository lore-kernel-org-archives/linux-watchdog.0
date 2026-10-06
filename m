Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2F45C6F6
	for <linux-watchdog@vger.kernel.org>; Tue,  6 Oct 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302348; cv=none; b=IG6eONJFEZqOdORh3ciyFvwl6ZGWeVWCybOkZ849e8TXxx62GuPPVyG9yxN2pCHCnWmSXAcq3j2EqFIlfHhk0z8yTPBBDS0bL3voDqNcpLtYCJgVUiUiWiDyr30GTsYC0JpXz5FDQ4dfJIIWonThz3pe4BUxrBagr7l24NbrFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302348; c=relaxed/simple;
	bh=ff1D2bH50Ynt58NUDZ4l8/6s5FXJ1UAPQyYFIJtPsI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GgyLYald3Wajh89GlIurpwvNafhl1OPjbtX4+7GyS3eTFLdw4xfSX8tawVdVh+7lM5/R02tafNfMwEfFBtKovya9fYzcxLw1RQ9THeJNa8VwuYg1nKQUbXEFjeM4A7atWJt8nviJimERIrxtRApcI8fDtPoZl+SHjKHJXrFXC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rw8mLAdZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rw8mLAdZ"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261006155903epoutp036bb46a73758360a739a644db59fc6ef6~b_-2P-OT90538205382epoutp03W
	for <linux-watchdog@vger.kernel.org>; Tue,  6 Oct 2026 15:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261006155903epoutp036bb46a73758360a739a644db59fc6ef6~b_-2P-OT90538205382epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791302343;
	bh=LwqKq7AOFyzAaVzBCsYm6GFytFQT8pUNRjYDrtN2KiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rw8mLAdZ3xIowmyENWwLjz+lo+aZqc8bljSbQqY5TMhq3ACSagYweKfJpwhi59lbI
	 h+Xb8MaI/bkdjV+S5UlgCkMLvi65ra5hyFXZxs5JY+RaqK0Ly3u8L95u/e5NzknhR6
	 QGqEbmXa42k2Al8VZSDgq3mfpj1dEIFA+NWh660E=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261006155902epcas5p300dd286bbc826cc534ff583a816fc9d2~b_-1iWPQ80752307523epcas5p3x;
	Tue,  6 Oct 2026 15:59:02 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hzgsx5YZ5z6B9m4; Tue,  6 Oct
	2026 15:59:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261006155900epcas5p1b842116272ea9d75c815ebb11303cfa5~b_-zppPOU1729417294epcas5p1T;
	Tue,  6 Oct 2026 15:59:00 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261006155858epsmtip1d7474f0e7dd372ba74e46d8b277c7f56~b_-x-W6Hr1367213672epsmtip1B;
	Tue,  6 Oct 2026 15:58:58 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add support for Exynos8855
 SoC
Date: Tue,  6 Oct 2026 21:47:00 +0530
Message-Id: <20261006161700.2185432-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006161700.2185432-1-alim.akhtar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261006155900epcas5p1b842116272ea9d75c815ebb11303cfa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261006155900epcas5p1b842116272ea9d75c815ebb11303cfa5
References: <20261006161700.2185432-1-alim.akhtar@samsung.com>
	<CGME20261006155900epcas5p1b842116272ea9d75c815ebb11303cfa5@epcas5p1.samsung.com>

Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
different then the previously support SoC.
Reuse the offset as much as possible from already supported SoCs

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
*Changes in V3:
 - updated commit mesg as suggested by Peter
 - Added Reviewed-by tag

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

