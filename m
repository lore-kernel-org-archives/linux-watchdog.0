Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1864599A54
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889480; cv=none; b=d+p2WfAnmEjghOZERKK421PKgX+9XsYFIWdetfun2z+29HYJSTHqRdbnMWVp6GGr6Y1BQueJT0TUVl2KcdzoAUQgQYJcpL/dIN7ZCPtayHk5LbCTmpl3ftPhm5o0c7pAAre0fpdPErH70sNTPQZTx3xYJqc4bXfbAM6QrUXT02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889480; c=relaxed/simple;
	bh=hc6ZuX7B5l+uxCyGyy0uxZcdQDBI+zQbtClyyGJbFxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyKh6jbJmJjpO6ClKNA/dqnzZ/DSh+KF2Vt9Tvx3qIgH06MpeOrmvt3TQiZ5ZArvoAa0nusm5LvMMcm5z+UTQPmWcPmEAZnx1V4jN/ECE5qLMY+PIsgnw6M+1HGaWR/6ckUhGQ7yBCm/b29MQjlRVC3GeZjatrJQNVgZ//lOeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOzCEftI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOzCEftI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso48712095e9.0
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889476; x=1789494276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LV0nGy7Prgird+t9YLnwanXWuEc7A0E5cLswUODru1c=;
        b=TOzCEftIKhEqtLSPEYeGsCQUHBLCz4IvZ3qOnxz0YFXOazoA5m0CY+zmw+uf8LDKIU
         RnY8qGOhUCTVyqITzGyofpcWQgO9tqbmlHk3yHuSidk0P1NqCJZ18euj4+73W+2DK7hR
         2SQanr3r/sXQBi6D8F2dLGTZMhM83aFftb5ZRGaaBx8u9xEgJ/vvTDOD4ijIAYaTOp4z
         sR8giExiVHR2eI81DvYX3/ql89oIKBV8/hy/rl+K3lvIe//qix1d0z8UBxOiCLsNa//9
         KN3LdWOWJsiIa9gECn1LToOpA0psYKvE5PXa7KuyVq7dzHu5mc2yIDuhuo2IokpVzd+X
         t6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889476; x=1789494276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LV0nGy7Prgird+t9YLnwanXWuEc7A0E5cLswUODru1c=;
        b=O0F24N+dgC3VlA1ekzToLuBt+TqVKV06X9jQh5ijqfGeKVtE6Fzn37Hp9L9QB18Lwk
         zobeXIcCbPaWZcZQZAAnUkeSbOcR2+pra29OouEmczMTZ4thVHwsuzj0dYaFy7H9m1Zp
         A9UBr6zp2Sf8GWmy3t5DOdOOR4VsNf0ArJ6M2wLRWRiXtTQKvjc9Oyrn50K4Y4inlIbw
         lM890EhGIu0T2Bm7gKDfcSRMfMVtMqSPKvc7Xpa1I2K4gRAw3tGUUJYA6XSNIIjeWaMs
         ONJnhMpRcXtozfryWy310/GEV5MYEm7X+WB6tLA/XYwzkUSq6mBNuinrtbvoWiIjNqc0
         ajAg==
X-Forwarded-Encrypted: i=1; AKwUvBwEJOsGJGLsTL1U3mGsJL37cnIlZRnirrlimAo1c7d1qVyF9tVvdIjZruqyaky7+hZts/LVqN8m/3pDdO7DYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nEd/oX4FgrZ5vcfFnhunJH/AtQXAM4F9NVgK1rlY7NUdNoLhOY
	5TZLGmEMgZ6yWONpbnv/MD4hPkGvjT0MJRFD4CS7Jl1lIuH9llUsw3QI
X-Gm-Gg: AYBFou1xlydN4IpcvS633qKZ7TwlXvBlfHdhMcOdQ31Vf5t1Q/Syc8eJ2RL+xPf27Hw
	OalwA1a3BBUd9WYEju8rwFkNFMeHn/G0lv2WMB14J48AidF/wxclrp0n0vsqg+0jNbKjvXykyHD
	2bFrNapy1FJlv6fCEh+VjXEBj1y7V9zrVc3Vh7jgnuyFtVl9zPIgnDiDxbsCrYcXV8WaoDAm1PA
	cmqfrX7Pxbf9jcVHHSggcKO5meazbtqhfWVbcOZwS7DflfLzTxlAXMcASXQv71eefKWEpvzApOX
	Gop1sfB1QbHVkl0nnhrvILWbO5L3XB2Tnl39oOio6zUVbZlDcaoPhgSPSwbreVf5hQ5SjAVtvne
	Mg1/HEc1IEwkY3z3or2v1zcpb+YKLcY6B4p7VwPAftu4iyxKpaREFZ/Gc6yRVpyTui6gLfp8MGe
	Pb1RoDVUcZH0Iz5q/+BA6tO2rB547arTWhu2WKL+hRnq1Iab314UJdYI8g
X-Received: by 2002:a05:600c:190b:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-49cfa20cd63mr290493175e9.20.1788889476492;
        Tue, 08 Sep 2026 10:44:36 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:36 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/8] dt-bindings: reset: Add mmsys reset ids for mt8167
Date: Tue,  8 Sep 2026 19:38:33 +0200
Message-ID: <20260908174259.9009-7-l.scorcia@gmail.com>
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

According to the SoC data sheet mt8167 has 28 mmsys resets. Add the IDs
that can be used in device trees to identify subsystem resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h

diff --git a/include/dt-bindings/reset/mediatek,mt8167-mmsys.h b/include/dt-bindings/reset/mediatek,mt8167-mmsys.h
new file mode 100644
index 000000000000..b21f67b3b55c
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8167-mmsys.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_
+
+/* MMSYS reset IDs */
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
+#endif  /* _DT_BINDINGS_RESET_MEDIATEK_MT8167_MMSYS_H_ */
-- 
2.43.0

