Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EB42903D
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306523; cv=none; b=e12Rl1wDwF3Z/otIwjGHNz0yeT0WaGAKNZGNiWhIh1YFn1OZQCTpkjKrM9VZZgEJDQueSEcygZaAi34l0/N8HX1fjQCGVYBPUuF+eApRFQcFr6eF8AVfMqLIfv2X5ZbUMg3k1EnYqele96UBgG3qqzYaHTrbblek+0NlVXg4Pf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306523; c=relaxed/simple;
	bh=azANXe+5M9L9zSq3Q+0m8DIbeD+viIH7/dL+bU2mmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t92BdS10v9tVfjGFXYeAYS2nn6mg/Mu0SUWLFX8MVMgDNjMlaDdDh4O6akqaAOhnP1q+EPXEnPkN+NwwwPiIyDgQQyQ2jl5zVopy345qFNBxdEdwE5WO6i4wG7b9pl5tvQkdtHrI7ONSgr17rsh6Was6zcWXTqnCk8HhmArt8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyLU+cn6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyLU+cn6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso620815766b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306520; x=1784911320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnd4qpp2azkxFnT2IbU2aZLbJ87tRh7KRsXF70B98Xk=;
        b=iyLU+cn6/jg3oiD3D2TDzS9vIku8wIrh5cXpU0TiXedFVCFC2rzLOVmZ5ozr1IjC3G
         alDTYvCpye3Rdv0MXFQgIuArJePmDGsvgiKc1j4oVzsf5oCDZLt2ZYBX0Z06NvqGgZnL
         mVqZi+VWtQt/3QnCxVOg1GoJJnNQBWL4PDfJvgBdd/vjJwTRaOM79HzQ7H6lDha9nYmq
         UukVCNT51EKilvUAPNFCDeYB2nMB/7+Ysc4C5lzcjO2gsm6p94YbkZ9k50ZbrfsmoeWc
         YGNjdgMHYSkY3CyVW9Gke2iTdibGnFYv03igZJ3Bj+e9mws1xmWg6MZGXNEgEiwoCGJL
         ZuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306520; x=1784911320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnd4qpp2azkxFnT2IbU2aZLbJ87tRh7KRsXF70B98Xk=;
        b=KtssF1K6Mn9k8nCa99vddVLcKgZCV2UGHALLozHcVSfabeQHn+HM0ehz7wHEeufUu1
         VllHG61TGMH+FFXfRDadKD7k1hoFCiWoPX58lwgmU/cy12TsG0f9hWhcBzUrKLnVccjn
         iLFWSzXUfRQJtKP4+jNNPVD8609CwE8jM2Z7JrHoCdOorausONr+gZtv8/h3UifB/QMH
         Yp6VOJ2QZfGMAf9ZVRvGT1pMKHXx8aCjeEhXElnZnwFDqopkgwmvKYf7SoSEs9Y/n+J8
         xlb8++/SCL/yFR0xeg2l/2Adw6qpB/hsfKe7deRvhAGgzV3AQLgLaFhukoHAFDzqmzNP
         R/dw==
X-Forwarded-Encrypted: i=1; AHgh+RrOJsEC6VRXB2vptKAF/maZ2YtL1esCGQSBW0I6rifmdrv1sMGdVNe6qQGQX/lACqsq44lyyR6SIid2YVm7eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJVqwjNuocjswArUNpFlN1Pkg6kXnz62dEExJS/IRwsaxlXiB
	grZf3Dy5agv+IP6OTEbG9HQJ5pwFGClhnKLkV4lmPxM8uLg4YA+Ss9AN
X-Gm-Gg: AfdE7cliudWneKgEBDnHWsvMs4qL1Yp9Nb/s+IP2M8ZmeN0BAa62oDrYf51EorZjTvN
	Do88/yetUQmqiiNCHevzXjT45lRxIewp7CFQ1AFdbAFNNCRJGMmt80RpVGk9mw1PutYVqLwEcy7
	ek1expFZqZ9BU1Lf4cfrL+LjYdH5TsZc42M69LlEJHXolKITEz0I2gO/+rtBNVsXFoy5SZj44Qs
	gj6ezJwZNlRUqhZhKToH/7sOlRHudn7G1588OY3cLZaxi6WSG4tCuziZvhZ32mEnginTIzQnXMe
	MjBY8n4E+9lSz8uuBxkdr1hiAfftmQ4WdCXodS3MGnco6+4DCTjy/8So4XX1rDv9p8Q3641ayY4
	vgcaq9qm+qvK9rHOao2kegpK2mEaoAL7KU9jtk8pgSHz+TvRsGuELvEfsIP29IkMdhLDYqG8hZg
	SwO2O3vBQ6
X-Received: by 2002:a17:907:db02:b0:c12:8b1c:454f with SMTP id a640c23a62f3a-c16b457b132mr151894766b.2.1784306519677;
        Fri, 17 Jul 2026 09:41:59 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:41:59 -0700 (PDT)
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
Subject: [PATCH v2 4/7] dt-bindings: reset: Add reset controller constants for mt8167
Date: Fri, 17 Jul 2026 18:39:15 +0200
Message-ID: <20260717163959.714561-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717163959.714561-1-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the various bits that identify watchdog and mmsys resets. IDs for
mmsys resets restart from zero as they are used in a different device.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt8167-resets.h b/include/dt-bindings/reset/mediatek,mt8167-resets.h
new file mode 100644
index 000000000000..85d2d0e99c68
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8167-resets.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8167
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8167
+
+/* TOPRGU resets, these are actual bits in the register */
+#define MT8167_TOPRGU_DDRPHY_FLASH_RST		0
+#define MT8167_TOPRGU_AUD_PAD_RST		1
+#define MT8167_TOPRGU_MM_RST			2
+#define MT8167_TOPRGU_MFG_RST			3
+#define MT8167_TOPRGU_MDSYS_RST			4
+#define MT8167_TOPRGU_CONN_RST			5
+#define MT8167_TOPRGU_PAD2CAM_DIG_MIPI_RX_RST	6
+#define MT8167_TOPRGU_DIG_MIPI_TX_RST		7
+#define MT8167_TOPRGU_SPI_PAD_MACRO_RST		8
+/* bit 9 is reserved, unused according to data sheet */
+#define MT8167_TOPRGU_APMIXED_RST		10
+#define MT8167_TOPRGU_VDEC_RST			11
+#define MT8167_TOPRGU_CONN_MCU_RST		12
+#define MT8167_TOPRGU_EFUSE_RST			13
+#define MT8167_TOPRGU_PWRAP_SPICTL_RST		14
+#define MT8167_TOPRGU_SW_RST_NUM		15
+
+/* MMSYS resets, these are IDs */
+#define MT8167_MMSYS_SW0_RST_B_SMI_COMMON	0
+#define MT8167_MMSYS_SW0_RST_B_SMI_LARB0	1
+#define MT8167_MMSYS_SW0_RST_B_CAM_MDP		2
+#define MT8167_MMSYS_SW0_RST_B_MDP_RDMA0	3
+#define MT8167_MMSYS_SW0_RST_B_MDP_RSZ0		4
+#define MT8167_MMSYS_SW0_RST_B_MDP_RSZ1		5
+#define MT8167_MMSYS_SW0_RST_B_MDP_TDSHP0	6
+#define MT8167_MMSYS_SW0_RST_B_MDP_WDMA		7
+#define MT8167_MMSYS_SW0_RST_B_MDP_WROT0	8
+#define MT8167_MMSYS_SW0_RST_B_FAKE_ENG		9
+#define MT8167_MMSYS_SW0_RST_B_MUTEX		10
+#define MT8167_MMSYS_SW0_RST_B_DISP_OVL0	11
+#define MT8167_MMSYS_SW0_RST_B_DISP_RDMA0	12
+#define MT8167_MMSYS_SW0_RST_B_DISP_RDMA1	13
+#define MT8167_MMSYS_SW0_RST_B_DISP_WDMA0	14
+#define MT8167_MMSYS_SW0_RST_B_DISP_COLOR	15
+#define MT8167_MMSYS_SW0_RST_B_DISP_CCORR	16
+#define MT8167_MMSYS_SW0_RST_B_DISP_AAL		17
+#define MT8167_MMSYS_SW0_RST_B_DISP_GAMMA	18
+#define MT8167_MMSYS_SW0_RST_B_DISP_DITHER	19
+#define MT8167_MMSYS_SW0_RST_B_DISP_UFOE	20
+#define MT8167_MMSYS_SW0_RST_B_DISP_PWM		21
+#define MT8167_MMSYS_SW0_RST_B_DSI0		22
+#define MT8167_MMSYS_SW0_RST_B_DPI0		23
+#define MT8167_MMSYS_SW0_RST_B_MIPI_TX_CONFIG	24
+#define MT8167_MMSYS_SW1_RST_B_LVDS_ENCODER	25
+#define MT8167_MMSYS_SW1_RST_B_DPI1		26
+#define MT8167_MMSYS_SW1_RST_B_HDMI		27
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8167 */
-- 
2.43.0

