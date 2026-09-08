Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692859B665
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889482; cv=none; b=YRe48lmCTVqNfEAthX8gYYtxLkJ1I53JRher13F6gfED4e/nX1gsqVbCICmX/p3SjaEq/AmKi2k21v94HLSsiOoty1/suB4AfrcOi4OfggMG8O1oVp+60Vxm9BDtbIBVIHVV1AV3AVO9jw8GBRYam1427oMQ46K3ixa1ZrQE+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889482; c=relaxed/simple;
	bh=pzu9DMe7iaDjrWFGbiXICChTmsydaYKLu67VDV5618c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILXkvFGi+57Enm6amZggmwGDjDeesKfA56CX3/QgV+Uf/GXRj7R7BYnv8t0czfT1izezsVN7Sb9YcGNuQk7P8AFe6tbhNDQ0wAtNKQ4aKazSdPK5kKt1B1SVmsFIGHb86v6pjfrQWBwPy7qwnzIZwcGKROSFE2TdJJM+TDgdfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih5Gnr2y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih5Gnr2y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so39887195e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889479; x=1789494279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ulU8x3Wy8nahtbqcLruGCqTsuJ9c7qAZmMPClxEabE4=;
        b=Ih5Gnr2yyKXy0eJ6W4WsFu5CQnEgNsqwkvn5dFCJRn477pObrOZKHYx5Bn7YT9Zx7l
         tIkmSeCPc2poArjhp8BmDIytx6HEiy0voabdn4oZVMHpHxnlh+Fyy13g4RO3VnzljZ9X
         UbXpLhUvIJKgO6SHR7ubhfO40xW2UEPARqWYd9TbPd36AhRls0qfExZXX+s3qh+JlsQz
         e6YFy7sIT3XdNByhzZtzXb6fH8UmVTjNYYMkFUxtuHUAKk/9KKd5lJwt6cmEQEvY7MDS
         WK/aNWK3nDRTxeJ9bR4vp+BjXcLRfWmIIshoumBi9Kj3tTISvzRTxj6yU2lC65Q/Ed23
         uMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889479; x=1789494279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ulU8x3Wy8nahtbqcLruGCqTsuJ9c7qAZmMPClxEabE4=;
        b=WTHWZOXmoOjim2jEsH2saVgCsOGoQ0Pomtof6CKm9n+Y1yrj/E8ys6Q2rMR/E7FrxU
         pmxzfWmlw5gi6BoX7axel3IvauZY9kxvNm99LJuQBmAUTzJd/uB1o+6AmI5N2ngGvhw9
         GuYJnzMpzyXVfqgMITj1SdK6DCGupNIi8SrgiRtqFat8HMtc2J2X3FELISNR12YasdBx
         AGil2CfmXwxSkqGPjjQyOeeNyxQVZg/HQItNJ1QL1CLvUv1emy6YvnQ+oc/rcc1NVLt5
         w9Ufh0kOoQdN6bNXV8xDookuCAKz9AxYtVVG+Uz207fyj2F4HU3CAf0xP0uu2bd4bngH
         nphQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPqiKYQ3N4j9GPNlbkHqKss2IPkIjWfXG/HM6pFN+xX+nme1ShgPttw8apz36N1QC0z17Q6DIdQ1LslmDMgw==@vger.kernel.org
X-Gm-Message-State: AFuF++lZfDf7/EEdMBkGZ2jzPLNm/GUswXWN3Nf+3w9fL3r3E33BwSvO
	d5A7gzX/kqTaAcKt7jpSp2/i/CYtMntaFjV+x0wM3pooE0Vbh7lAS+Z6
X-Gm-Gg: AYBFou0doQ6BOEgHO8LFZGp0sGO3jHAwlmAWjZd2NCklNO5fC2o9WT0FDAYTwH2wYyf
	40crccn/rb6+8Xg1aRxINGZ03s8iIUD97CVreMq0qJg/xuNxVI7KdMR5M9cgcQdcl+foXnzQOPO
	jNGuUjguOCuzcOMzo8Sn4d8QVKGFN89QcqzzSdI2+R+W9f9XEui4dpSVjvpr13oLIyOwAKxYT0N
	Yxci1Xv0s6SkG6VVFZM2gErzG9mp/0W5dRKzVVxhzUs3q5dyFyanKne3WoxPUyz09EiGZuRQgED
	eR7EQxCjdDMYcbb8sLbdK3y57McXPR2l5brBTzHckTjddUmRSxCVfnB4JCCrShWsnA8bFlyatyA
	BAVzO4uJ6w251jcMeOZkC3sIAbH+7Pj+SY6gTDUQb1M5kHAmegoIPlHTn9lu+mGQE0gsE/fIWOl
	M/UNZ453v2q7ORBWZtSZdSNg8r9OL8InwPMRyYkTMZ2J4uP4tYSKDtlCZU
X-Received: by 2002:a05:600c:4ec9:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49cfff39708mr256750925e9.17.1788889478855;
        Tue, 08 Sep 2026 10:44:38 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:38 -0700 (PDT)
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
Subject: [PATCH v5 7/8] soc: mediatek: mtk-mmsys: Add resets for mt8167
Date: Tue,  8 Sep 2026 19:38:34 +0200
Message-ID: <20260908174259.9009-8-l.scorcia@gmail.com>
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

The mt8167 SoC has 28 mmsys resets, split across two contiguous 32-bits
registers, MMSYS_SW0_RST_B (0x140) and MMSYS_SW1_RST_B (0x144).

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/soc/mediatek/mt8167-mmsys.h |  3 +++
 drivers/soc/mediatek/mtk-mmsys.c    | 38 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
index 001379373507..5c7cded5cfa4 100644
--- a/drivers/soc/mediatek/mt8167-mmsys.h
+++ b/drivers/soc/mediatek/mt8167-mmsys.h
@@ -3,6 +3,9 @@
 #ifndef __SOC_MEDIATEK_MT8167_MMSYS_H
 #define __SOC_MEDIATEK_MT8167_MMSYS_H
 
+#define MT8167_MMSYS_SW0_RST_B				0x140
+#define MT8167_MMSYS_SW1_RST_B				0x144
+
 #define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
 #define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
 #define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 2f3e0778bb17..015dc5b86478 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -4,6 +4,7 @@
  * Author: James Liao <jamesjj.liao@mediatek.com>
  */
 
+#include <dt-bindings/reset/mediatek,mt8167-mmsys.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -53,10 +54,47 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
 	.clk_driver = "clk-mt6797-mm",
 };
 
+static const u8 mmsys_mt8167_rst_tb[] = {
+	[MT8167_MMSYS_SW0_RST_B_SMI_COMMON]	= MMSYS_RST_NR(0, 0),
+	[MT8167_MMSYS_SW0_RST_B_SMI_LARB0]	= MMSYS_RST_NR(0, 1),
+	[MT8167_MMSYS_SW0_RST_B_CAM_MDP]	= MMSYS_RST_NR(0, 2),
+	[MT8167_MMSYS_SW0_RST_B_MDP_RDMA0]	= MMSYS_RST_NR(0, 3),
+	[MT8167_MMSYS_SW0_RST_B_MDP_RSZ0]	= MMSYS_RST_NR(0, 4),
+	[MT8167_MMSYS_SW0_RST_B_MDP_RSZ1]	= MMSYS_RST_NR(0, 5),
+	[MT8167_MMSYS_SW0_RST_B_MDP_TDSHP0]	= MMSYS_RST_NR(0, 6),
+	[MT8167_MMSYS_SW0_RST_B_MDP_WDMA]	= MMSYS_RST_NR(0, 7),
+	[MT8167_MMSYS_SW0_RST_B_MDP_WROT0]	= MMSYS_RST_NR(0, 8),
+	[MT8167_MMSYS_SW0_RST_B_FAKE_ENG]	= MMSYS_RST_NR(0, 9),
+	[MT8167_MMSYS_SW0_RST_B_MUTEX]		= MMSYS_RST_NR(0, 10),
+	[MT8167_MMSYS_SW0_RST_B_DISP_OVL0]	= MMSYS_RST_NR(0, 11),
+	[MT8167_MMSYS_SW0_RST_B_DISP_RDMA0]	= MMSYS_RST_NR(0, 12),
+	[MT8167_MMSYS_SW0_RST_B_DISP_RDMA1]	= MMSYS_RST_NR(0, 13),
+	[MT8167_MMSYS_SW0_RST_B_DISP_WDMA0]	= MMSYS_RST_NR(0, 14),
+	[MT8167_MMSYS_SW0_RST_B_DISP_COLOR]	= MMSYS_RST_NR(0, 15),
+	[MT8167_MMSYS_SW0_RST_B_DISP_CCORR]	= MMSYS_RST_NR(0, 16),
+	[MT8167_MMSYS_SW0_RST_B_DISP_AAL]	= MMSYS_RST_NR(0, 17),
+	[MT8167_MMSYS_SW0_RST_B_DISP_GAMMA]	= MMSYS_RST_NR(0, 18),
+	[MT8167_MMSYS_SW0_RST_B_DISP_DITHER]	= MMSYS_RST_NR(0, 19),
+	[MT8167_MMSYS_SW0_RST_B_DISP_UFOE]	= MMSYS_RST_NR(0, 20),
+	[MT8167_MMSYS_SW0_RST_B_DISP_PWM]	= MMSYS_RST_NR(0, 21),
+	[MT8167_MMSYS_SW0_RST_B_DSI0]		= MMSYS_RST_NR(0, 22),
+	[MT8167_MMSYS_SW0_RST_B_DPI0]		= MMSYS_RST_NR(0, 23),
+	/* bit 24 is SMI_COMMON again according to data sheet */
+	/* bit 25 is SMI_LARB0 again according to data sheet */
+	[MT8167_MMSYS_SW0_RST_B_MIPI_TX_CONFIG]	= MMSYS_RST_NR(0, 26),
+	/* all other bits are not described in data sheet */
+	[MT8167_MMSYS_SW1_RST_B_LVDS_ENCODER]	= MMSYS_RST_NR(1, 2),
+	[MT8167_MMSYS_SW1_RST_B_DPI1]		= MMSYS_RST_NR(1, 3),
+	[MT8167_MMSYS_SW1_RST_B_HDMI]		= MMSYS_RST_NR(1, 4),
+};
+
 static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
 	.clk_driver = "clk-mt8167-mm",
 	.routes = mt8167_mmsys_routing_table,
 	.num_routes = ARRAY_SIZE(mt8167_mmsys_routing_table),
+	.sw0_rst_offset = MT8167_MMSYS_SW0_RST_B,
+	.rst_tb = mmsys_mt8167_rst_tb,
+	.num_resets = ARRAY_SIZE(mmsys_mt8167_rst_tb),
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
-- 
2.43.0

