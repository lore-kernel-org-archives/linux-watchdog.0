Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9942DA48
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301319; cv=none; b=GT8TMVP9zfdYk4Nvg/xdKoaM7aKcM1/tAGxmAeTFOQzjCt1kXTGqDJaowqSyRlO5QPY3bnhfmsq/p4lb8Pc6VJX3K4Mm1Mw8y42iRYzqnzqwAu9BzKSc+M/zvkzgGneEzfq/uk2o9ZQIo2mLVkk1zNq8cokVJp4mwLZ14iksKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301319; c=relaxed/simple;
	bh=tzxEdl4ko0nkT7PQb3oj9+Gb1UmzZ3kdn+n/fShpK0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioX3g45lcTMckZi8QWqQzKhyyqpvDhoeTGkG/ssvF9KfLR7JRcbj8DGyeIa9IZr4OrfZxWJWfWapsEcKLwjIN/FwlZrTrlqU9RK99jDzyfwuDFhwNhW/36oEppAYpxI1z6yfIee4QWLTRhKotBMfGYk0lKj0QRLQnLwOvxcwJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns//273v; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns//273v"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso12791324a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301317; x=1784906117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6Nle1J2Z37EDbTLYDXicAyW2PuOELSBhKsjOPEFE1Y=;
        b=ns//273vscLNwjdTLKPycd6Lu+f24zotpWLAsmJd2bNHU1fIs+3BkApew5AWwy/7qv
         +vf4VzSbcLt1Ht9BKZmDZS9nTuCJ/K7CRm53K11CV3Joyq3YX7XZinO7ga2IfS6iOaj/
         0IqfUZ9rA69iR7QrDXpmmxBz/AV1mKmOoK3Yogep6Roh68kU1Mh/QKMHu3KfN2lVMnRD
         yi6YJbKOnz3BHCzNQ3+PIOCFLcn4biJVEJXeQSQ/DWLVWgd9D/fK3ncEpc02fwDUitJH
         CTZysMiJWe99YaCB3Gl9VwEGOAJkR3+YjV86tPlbk1VlyHw+T4ZzW7OG0O3jikW7nIP1
         mTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301317; x=1784906117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6Nle1J2Z37EDbTLYDXicAyW2PuOELSBhKsjOPEFE1Y=;
        b=mP8NmE3bo7RFS74OQz0J66sTXiIXe841xorTv4/41CEip5WYtNjJ7PC2SF2Z5+2GPT
         SdhvzjDjcBFNW5aTssBm9ebb2lEdhmqU6TKkNwunxvrBpxukGCckEQgvgZgHy0Y18YcS
         7gTqA3itvzNT9NiQcFJAZQaEoYQE8Rx7goJamzmds4GGJ0boL2vSOhc1htLGtEUdoGQD
         lrn0RG98BDnwCe0O+3m3wuVhBY3SNKnSeBt5mXJiZuyjYSKI+mI+kVdV/PA5DdCIqMh0
         nIIR0EtPP/vzI2JU7RlfX0quFni2iepSkKXBTtQ/1qG+w7t13uRs6eSvjftuJJ6YzvHC
         YlaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ZNXSp6S3cQWGJalfc0SdEegj2bxsN8QD+PhuFjiz8a+wSPX0Ov4KY750uz/rY/rBJ6sYq/4VR8bpkc4dCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygV6AbtL4oXul67Ob/lGa85XuCCE8jlnK1Y3tqzo9Z3VmXcg4q
	PgexZyDi5/7dpAvkp6cu52qtkOye4uDkZtrnU9Uq83Yj02+XfAZVXcBM
X-Gm-Gg: AfdE7clEzxXyXUWPd7dPvQVG9ZeUkMSju6afYHCFIrw/5U6hQNx/0h9w5fSA1H0PO95
	L0FQrbtZL7cY6Jh5is5Bja48BpLlsrr3q59Yii5pnypnJ6xfbHuD5oOB3Q27vrLk6hFPee7P6GK
	gBpqaOmyzJwkt3V1e69Sj+E9ztoDAKhX05N6SQasjDu+aiplrdvQbqRTqoqtvO38wTcfHQb9lEA
	sQuKDCpPO2wsosuJucHLOcBl/jjldn89tRweyN0ZpGAot6sfNRUKCI9K/Ji0pKBLtRRVeS5RVyH
	xPQ+E4cZvk9m06HYcX+OSpsjTxuTVZn42XNfjzuF4ThMs43w41w65Mui6N3GcBsXkUoNYDqenF0
	V9MdRA+oePcwGmd+nwL6dJn0ZhQb5BH7e4MWv5DH8koE2HAOqsF5aCxiigbI5OwH/C/OvvmyzNA
	==
X-Received: by 2002:a05:6402:50d1:b0:699:6d24:e298 with SMTP id 4fb4d7f45d1cf-69e65228d68mr1306044a12.8.1784301316360;
        Fri, 17 Jul 2026 08:15:16 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:16 -0700 (PDT)
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
Subject: [PATCH 7/7] soc: mediatek: mtk-mmsys: Add resets for mt8167
Date: Fri, 17 Jul 2026 17:11:14 +0200
Message-ID: <20260717151134.678839-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717151134.678839-1-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mt8167 SoC has 64 MMSYS resets, split in two contiguous 32-bits
registers, MMSYS_SW0_RST_B (0x140) and MMSYS_SW1_RST_B (0x144), as
also stated in the downstream kernel for the Lenovo Smart Clock
in the ddp_reg.h header.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/soc/mediatek/mt8167-mmsys.h | 40 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
index eef14083c47b..b8f38ff8cf44 100644
--- a/drivers/soc/mediatek/mt8167-mmsys.h
+++ b/drivers/soc/mediatek/mt8167-mmsys.h
@@ -3,6 +3,46 @@
 #ifndef __SOC_MEDIATEK_MT8167_MMSYS_H
 #define __SOC_MEDIATEK_MT8167_MMSYS_H
 
+#include <linux/soc/mediatek/mtk-mmsys.h>
+#include <dt-bindings/reset/mediatek,mt8167-resets.h>
+
+#define MT8167_MMSYS_SW0_RST_B				0x140
+#define MT8167_MMSYS_SW1_RST_B				0x144
+
+/* MMSYS resets */
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
+	/* all other bits are not described in data sheet */
+	[MT8167_MMSYS_SW1_RST_B_LVDS_ENCODER]	= MMSYS_RST_NR(1, 2),
+	[MT8167_MMSYS_SW1_RST_B_DPI1]		= MMSYS_RST_NR(1, 3),
+	[MT8167_MMSYS_SW1_RST_B_HDMI]		= MMSYS_RST_NR(1, 4),
+};
+
 #define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
 #define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
 #define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 2f3e0778bb17..abd96634b63c 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -57,6 +57,9 @@ static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
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

