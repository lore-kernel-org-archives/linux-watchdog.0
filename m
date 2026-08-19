Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802A4503E0
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134762; cv=none; b=qCknJ+OpJFls4RwkCcI1kZP20gQTxeQ8yNGQmcc7LgOU+NlIs4fW6v4VnWyIrI1YJXxpCN8vFV1OFEVGQn8lO8pXiCn0Xz2ixDbyepFwxowWkEHNZ4tU5Q2f7yusEl+LWQDYFhBHdV+4wb5bXSpAwZBfHLXqE+wZtB84Bv6gvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134762; c=relaxed/simple;
	bh=1NEOgnSQQ+HAx7Rnjdw3+vZxC3b1RoMQyfHXNa3S5TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeCXnrp/1ibwYB7rU19nUvPOR8VFgsDb/RcJuml7Cu4W1KyVUMGncy+b8JH7bdYN33gjRuL3Sv15z/1nTHATytlsdUNX5yxXZcO1af4qNjazSYY2kEXmAcUwKzUIjKvnbv5Z9ITqi6jYGmQat8XBVRqVJtLnr7COqhtWN1bnfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHKiAXdd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHKiAXdd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso4237375e9.2
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134759; x=1787739559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPKoXj0537sjg7TtWfXNcXGDOvi6v2gbjQvu6MW0moQ=;
        b=cHKiAXddCtSbpU4eolJgdpZkzdMavZlaHeh4Y0tK2nzmHBntAS9CQwP7L68IeTJPSY
         yJaxJ3p14v5KEth/TruHk4maJ2RBahJr7Nv5jL2ZopHIhsD6mPnz9WpwTPGKI8xghaV1
         sZ0snb1MAcLVtTfsJysSysctSwNhJaqdNBbA+fnnYSSszuZOeliQSIuXmwOYSlHTL0Vr
         pjp/qsBk45ZIMSZ7Ei1xuYxMEy1XYcyRy67j3o5zVoeiPuwS5BLaEFgKQPcve743xEle
         fle6V1/UIhLQ91eTMIVcn9DA5Q8i5sPufy13TBi/IUfovhNmCxDKl7h8k9yY2zpZyqKL
         RZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134759; x=1787739559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPKoXj0537sjg7TtWfXNcXGDOvi6v2gbjQvu6MW0moQ=;
        b=Qtb0SJaVBcrTT3m247TQNO8mEKsSyApIi/kjLeUebec21H32C0fhMUqZWqAu04X4qd
         rpw4fjNgMwNwle/8QAkl///kkgpWlpJJ+xmzcGhI6SnsK1AB1mIT5KTEUCX98dSUygf8
         13mdJhwBzyuNtyiQ6y+cFvZZ8oolI5RTO0Y3Umz0zUzW0OsbS6CUBRcOqvHIu4W2ycwY
         cCCEjO3Xaq34n64QG4tmn0d5vJ37bLzWKsQQdBDtVx4BBQ6eb1rvlnxshLww9RjPYdfE
         q56ghobFJevCOUpdIMem/163EQYzT4DEdloKA7NZy9LcGCh8pr4vcR/XVoe+dU1+biDL
         gm6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr1EH0CaaBTm4L5OtaQ8OpTZMKLAcQihK+ag12m6AMAzyenfn/6UOWq+dJ+L7Wh6tDMvxbFRiUcPDb5/+z2Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiO4EJWtkph/sIFDWj7sf767uSIzjMaPmXev8p4rIIhWk+y0tT
	/Lf52/L5i+ioAA8s5HgEBaBN+RmMo1pqnfW1Qy1mZbJSbZdoS0q2oGsK
X-Gm-Gg: AR+sD11rL5Tvf118/znTLjv1JS4HvwF4pPlWeOKWwzwEla8H0O/eOmupmopR6tLdzI3
	5FrpgJd+q07IYTS1yHmIQNQSI+B8ZoHqiBCqOxXjjaMgswb0uDL3E82sdBr2VXyi5JKPY6QeyBX
	PK3Gr4RTu/ZzooFIj6JAe5TKkEOPlnRkgYLLfjb1TclwL1wJFe0eVNNENjenDDSoH9F8BnLLrrq
	HKMRUcUm+wKoqCWgU5LHVy1CPwTzA1jMyMkxkf3L39Lae6DIFoeOOhsO3cweTjwIaHvnYJsieRQ
	WVeF+AxiN2NVRBG06APtD5emHslVd0wWgW9P1SGOGN0YRtDflt8ENvoUnGeg4dxMEKXfGjwR/X8
	lF9BGrZgp9M01+gZQAVwrTReKBcwj3orBfIGrRnCtqrqKCCOpJ8jc9ms64m2VM5zqH8lzlnbJBf
	PSU5Uqav65eVuO+oAz0hoXl9yoneQJzD1J721u5psotcayYh5Hy4mCTyRU+xde54ly
X-Received: by 2002:a05:600c:1f94:b0:499:8807:345f with SMTP id 5b1f17b1804b1-499aa1b6994mr52091595e9.13.1787134758588;
        Wed, 19 Aug 2026 03:19:18 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:17 -0700 (PDT)
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
Subject: [PATCH v4 4/7] dt-bindings: watchdog: Add compatible for MediaTek mt8167
Date: Wed, 19 Aug 2026 12:16:25 +0200
Message-ID: <20260819101853.44681-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819101853.44681-1-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 toprgu is not actually compatible with mt6589: the latter
has 12 contiguous toprgu reset bits while the former has 14 non-contiguous
toprgu reset bits.

Update the mtk-wdt binding to add a dedicated compatible for mt8167 and
add the IDs that can be used in device trees to identify toprgu and mmsys
subsystem resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
 .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 +++++++++++++++++++
 .../dt-bindings/reset/mediatek,mt8167-wdt.h   | 21 +++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..f514be8a5851 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8167-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
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
diff --git a/include/dt-bindings/reset/mediatek,mt8167-wdt.h b/include/dt-bindings/reset/mediatek,mt8167-wdt.h
new file mode 100644
index 000000000000..1a24bfe079ca
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8167-wdt.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT8167_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT8167_WDT_H_
+
+/* TOPRGU reset IDs */
+#define MT8167_TOPRGU_DDRPHY_FLASH_RST		0
+#define MT8167_TOPRGU_AUD_PAD_RST		1
+#define MT8167_TOPRGU_MM_RST			2
+#define MT8167_TOPRGU_MFG_RST			3
+#define MT8167_TOPRGU_MDSYS_RST			4
+#define MT8167_TOPRGU_CONN_RST			5
+#define MT8167_TOPRGU_PAD2CAM_DIG_MIPI_RX_RST	6
+#define MT8167_TOPRGU_DIG_MIPI_TX_RST		7
+#define MT8167_TOPRGU_SPI_PAD_MACRO_RST		8
+#define MT8167_TOPRGU_APMIXED_RST		9
+#define MT8167_TOPRGU_VDEC_RST			10
+#define MT8167_TOPRGU_CONN_MCU_RST		11
+#define MT8167_TOPRGU_EFUSE_RST			12
+#define MT8167_TOPRGU_PWRAP_SPICTL_RST		13
+
+#endif  /* _DT_BINDINGS_RESET_MEDIATEK_MT8167_WDT_H_ */
-- 
2.43.0

