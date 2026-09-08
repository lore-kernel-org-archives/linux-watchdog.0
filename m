Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9659598C16
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889476; cv=none; b=ULPIQmtXNUKD8BE5go5lMmPYOy9jvqqRgvoSWFwhGiSSdp35s8xlsPozSZ7aFF2Cs9pcMktbx9BWG+h5iSKGEiugnqRkAbnMTKZDbqDAYRnmNzqQA9HOTP8gW6eQtiQVmXaSfoybnGcTPK+1C3DlC/RNu1awhkjCQjLjJ8VXUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889476; c=relaxed/simple;
	bh=TAJj+TwVjSlyGmvVTWRFZsqSUyrNUZEXjvLcVekafrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0ZGnH441EqNF+TblJCCyCl/7R0ukDFiGGIg7w80MEVHDkss6L5ipNmg35F01Ggp2AbrHDAN0I9h7wPZ2gXM6lViEyYsHD99Go+TybBxstowgx+rKnUvRdTU2tqnFWZx5m904z58d7JdrzMHpZg9LChUpaPYxt8zqW6KWrtiEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqxcFBNl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqxcFBNl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49557167508so58427575e9.1
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889472; x=1789494272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDZxGaJw3VHG9TEwz+w10G3uJpNDZbfnCjCXATUC2n4=;
        b=fqxcFBNlEPv18LWch7OkuFWnePEEUrEzR1f7B8tJfwF46eNDV3qMaLWLM4VfSZ+R81
         FSPFFWT+t1WB+ke7dQoVfCdzFHQA8eUCBciMZPvrw2bIBfIfhzrsB4EQk41IiPllcQ/T
         njD5k5tmYaK0zAByhX93R1fsd1PRYOwpPFOOuV4CFQo9YxCw+D4Vmhh1wIfm6ZF/A0Xy
         3CjcZRf+SJpLpJqHBevOWXMZO+qKuRBJLxzSMmNQ+ufOshH8TMqldK8ljZjGVs3OExbn
         bD7FHlTKx7OZSiCE6p3bhnXxvWSe68O1ijW5UOKeAjtjiOnTIi2v9hIqYas2EdRQhrdd
         BwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889472; x=1789494272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDZxGaJw3VHG9TEwz+w10G3uJpNDZbfnCjCXATUC2n4=;
        b=A3cVtpC4lvm7iMSJ39BLKcFCHNZuv9CFinW+YmYJlAejIsFx56kQsirkHQCyCdgtdy
         CfBTuUvdNJrPUQmtNOlm+xpNcAxNe0v0MS5qhTxiYm5QnyUlvK1PgtnwhKUEVJHykp32
         K1g83me7geW0OtFe984boIAsqR0EuokQ6nxnCUAys6MXaTb+/CtCG8jrC17kC+v2cW1a
         FAtahs8dSoEz+h4C55bx4NGyZm2wtdGFDPzibMfCfyaG4UPGVvzPUUI+atKkezdtNK1O
         y+Z0t4FhG+pVK0nUnp2qgIjIZsaWoi8WV/tOF/tnL0IEaaR4rPKmu/jMICtgqL136gHT
         yAug==
X-Forwarded-Encrypted: i=1; AKwUvBzGGpZGY6NcRhN8BA6Ne+BBwbqM3OyAw4ZrkPhamvdgm64NpXYCMnRSv37nA4RxS6GBIkzSS1FQ1Ob/e6J8hw==@vger.kernel.org
X-Gm-Message-State: AFuF++nQLsHxoeNbGtk9WxAsVFFLRaSxpmnQPUOvjuYuSYJ9haJ2T4vG
	H0IzDgAs47Qp4RGyuPT2LI0+6V6NvV6w6jlyoDwjJ1vKMiWLzmBtArVL
X-Gm-Gg: AYBFou3uOglLbsbm3jRnpqYzx+t2lu8JJmSJdzRxGQPo2QgAg3RoxpHyFEaG4ZzGW1b
	1azn8nInBrH/XvS6rlQc9t1Un7OohQeax4lPL42+1YMhGv13nEvDo4+ahu2D/ZKkEuP257oNOC7
	r1YRb+ERRRmtmSZl6uutKQX1EQNLtHyPcmEa0R6v7XnLoRPX8inXk5vSQEZ2jZ/0GGEH0w+2wP6
	xGuucNzmzT/0KlTTStAenWcbPVnE9qwWw/x+vc/hoR4mM1PxjjFjazZPPRBt/vEtTO9osujNW2r
	w4Z1PvudQIDf+iEhqde/Q+owRMc8pA1rRNnoZAI+hYLXgWmXtZChkEAwlD03SAi1gqn9Qjp033P
	yBSSMEjWwC/TzG3MYnPKJ90UVZwS+GUvN+YzejV0nlObYSyIHtK8rkRv/Hzx4U4jek/rEviR6DP
	vXi2bdx8VXnpou1rhpl2oNWQ5TkMFk3MiP9Yq69G1fDPBeIoHbsaI5YSYW
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49cf82524a2mr465943505e9.14.1788889471625;
        Tue, 08 Sep 2026 10:44:31 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:31 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/8] watchdog: mediatek: Add support for mt8167 toprgu/watchdog
Date: Tue,  8 Sep 2026 19:38:31 +0200
Message-ID: <20260908174259.9009-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908174259.9009-1-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Top Reset Generation Unit/Watchdog Timer found on
mt8167.

Since according to its data sheet mt8167 toprgu reset bits are not
contiguous, add support for a reset table to the driver. This lets us
define reset identifiers as contiguous indexes in the binding headers.

Also address a preexisting Sashiko finding that noticed that the
has_swsysrst_en configuration was set after the reset controller
registration.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 47 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d609f0fa35e3..abe58ed6a504 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -12,6 +12,7 @@
 #include <dt-bindings/reset/mt2712-resets.h>
 #include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
+#include <dt-bindings/reset/mediatek,mt8167-wdt.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
 #include <dt-bindings/reset/mt8186-resets.h>
@@ -78,11 +79,14 @@ struct mtk_wdt_dev {
 	bool disable_wdt_extrst;
 	bool reset_by_toprgu;
 	bool has_swsysrst_en;
+	const u8 *toprgu_sw_rst_tb;
+	int toprgu_sw_rst_num;
 };
 
 struct mtk_wdt_data {
-	int toprgu_sw_rst_num;
-	bool has_swsysrst_en;
+	const u8 *toprgu_sw_rst_tb;
+	const int toprgu_sw_rst_num;
+	const bool has_swsysrst_en;
 };
 
 static const struct mtk_wdt_data mt2712_data = {
@@ -130,6 +134,29 @@ static const struct mtk_wdt_data mt8195_data = {
 	.toprgu_sw_rst_num = MT8195_TOPRGU_SW_RST_NUM,
 };
 
+static const u8 mt8167_toprgu_sw_rst_tb[] = {
+	[MT8167_TOPRGU_DDRPHY_FLASH_RST]	= 0,
+	[MT8167_TOPRGU_AUD_PAD_RST]		= 1,
+	[MT8167_TOPRGU_MM_RST]			= 2,
+	[MT8167_TOPRGU_MFG_RST]			= 3,
+	[MT8167_TOPRGU_MDSYS_RST]		= 4,
+	[MT8167_TOPRGU_CONN_RST]		= 5,
+	[MT8167_TOPRGU_PAD2CAM_DIG_MIPI_RX_RST]	= 6,
+	[MT8167_TOPRGU_DIG_MIPI_TX_RST]		= 7,
+	[MT8167_TOPRGU_SPI_PAD_MACRO_RST]	= 8,
+	/* The data sheet describes bit 9 as "reserved, unused" */
+	[MT8167_TOPRGU_APMIXED_RST]		= 10,
+	[MT8167_TOPRGU_VDEC_RST]		= 11,
+	[MT8167_TOPRGU_CONN_MCU_RST]		= 12,
+	[MT8167_TOPRGU_EFUSE_RST]		= 13,
+	[MT8167_TOPRGU_PWRAP_SPICTL_RST]	= 14
+};
+
+static const struct mtk_wdt_data mt8167_data = {
+	.toprgu_sw_rst_tb = mt8167_toprgu_sw_rst_tb,
+	.toprgu_sw_rst_num = ARRAY_SIZE(mt8167_toprgu_sw_rst_tb),
+};
+
 /**
  * toprgu_reset_sw_en_unlocked() - enable/disable software control for reset bit
  * @data: Pointer to instance of driver data.
@@ -160,6 +187,15 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
 	struct mtk_wdt_dev *data =
 		 container_of(rcdev, struct mtk_wdt_dev, rcdev);
 
+	if (data->toprgu_sw_rst_tb) {
+		if (id >= data->toprgu_sw_rst_num) {
+			dev_err(rcdev->dev, "Invalid reset ID: %lu (>=%u)\n",
+				id, data->toprgu_sw_rst_num);
+			return -EINVAL;
+		}
+		id = data->toprgu_sw_rst_tb[id];
+	}
+
 	spin_lock_irqsave(&data->lock, flags);
 
 	if (assert && data->has_swsysrst_en)
@@ -457,12 +493,14 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	wdt_data = of_device_get_match_data(dev);
 	if (wdt_data) {
+		mtk_wdt->toprgu_sw_rst_num = wdt_data->toprgu_sw_rst_num;
+		mtk_wdt->toprgu_sw_rst_tb = wdt_data->toprgu_sw_rst_tb;
+		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
+
 		err = toprgu_register_reset_controller(pdev,
 						       wdt_data->toprgu_sw_rst_num);
 		if (err)
 			return err;
-
-		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
 	}
 
 	mtk_wdt->disable_wdt_extrst =
@@ -503,6 +541,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
+	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
-- 
2.43.0

