Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2642CB16
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301311; cv=none; b=h4jj5mKU7+SMOy0qZ57ugFDbxVqzrAv1+6FEg8KTso+Rf61gSQWflJ0CXkvAhaGhEjsKLgnISX3i6jzMPmuIXHkrHJBhRWCyySQz4yJznQtBlCSISXd8+mTxF/O0suRH+5zRI+cyVzI63Jmc1DLOiZZ7LLG3RBC6oB07CxFwX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301311; c=relaxed/simple;
	bh=azANXe+5M9L9zSq3Q+0m8DIbeD+viIH7/dL+bU2mmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBFVE/N65fBx1qAuFNOBOQZojqQga82cNjKKgESL1U/hRPnngvx6fllt+X3qskQlIRho1p0DCg2j3SBl52fR7YDKecuGlYHVLE4LkYVHZrPDqaHdbgFPbTsKTImnwBa7x2XydDu/fx/LIZwgoBUKEUcduQyImYnYF9I0F5ECG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD5iN7wG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD5iN7wG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so7942630a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301308; x=1784906108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnd4qpp2azkxFnT2IbU2aZLbJ87tRh7KRsXF70B98Xk=;
        b=FD5iN7wGiEcdLFoz6N7kAKM19W+DjvH6Cn32TiqS8a00Wfvl0jflrs5q7MuQjUiOLJ
         27cEalQ0M2sY/bdWhTgBbFHLANi6QP8DmFnHnvRAK5WTOVZXRTWkFZTXKr7O/bJhrrdB
         GSkET8JhID9wa42UcGzR3r11+IC3Rb2uZZ8gBc7EPK7LkfdXGoMKBHf2NIjd+3eAbQTg
         2yEAclh/mEJHQXnCuWhR6kGGyGZilrCaz8TwNkljPCFpmAGKIql+8xNWWap4MtJNB4PP
         mZgheo3mRbEv5JGMVSbJBEwai5DYBPWqXvqDFbII0KKl99tHWYdNx2kBBGI2A8yKxnmD
         vUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301308; x=1784906108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnd4qpp2azkxFnT2IbU2aZLbJ87tRh7KRsXF70B98Xk=;
        b=AvBsk97e0W6L88AfOttcK44xnpZCr8FQHcZiisICcZOcx4XQQ4jXZPBTzLnOs5fRoJ
         QhhPkiR4kFJkzSZs9hukEggIGb2JX3jWnLlfOkrpuwWMncIIXu9SQPrcgMtR+EGSVsZU
         z/dwV2JItgjBra42C6TEsKtLbv7nKoplcdqgauUGzhEzY/YiaXdotTSqeMIblZ0YbSeA
         FhekokqALsYAtiircYDEurGcWmUh+wOSog1K51h8kBFJ5AkxctP0UyWhZsHCE0xsuk09
         dji3zjtTgMYvo+yBoZQwg3WpD2xlglbuRw66nYpP/rM+THOLvvlGNT07TCTLndmgFPk3
         xxaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtDboHzEXfKDmTkIdlFd3Dctv3ll0cdaHNQ5JGksSFOcEhbo9QcmajNL6SvYv7WWfHcza8F2tFYT1SpGCLKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2yFSEUyHy4MtyeSwC5NOAjJziznGRSbPDwF1cuU3JCFC9Yxf3
	aWIWgj6BCHRxnc3z0tzTLq9knjGNVkz6ciUPj3YY/FjqXEg1hVPLRBlz
X-Gm-Gg: AfdE7cmxUkUf3qHwZyI34b240p+wzMVjZm862KQTomu9NinbI4r8MN/vfoqO95na4By
	nMdmfaesmkuP9yIiUzlowB/9wRfuhjdmINLvdS83O6rWbyZOYfnvTPKuwC5NFYZSzyyubP1BTA3
	eg1GcrxTXmJ2ONkgUtw7HE7w1I7TOUz6irgYkmXK7cKUGRcs6AiILl1vFLY0SzifHt788Eo32nZ
	zVBJAK7ZO/wGIt6rhcZtyn2DEQk71afUgQn5PrOEhce4ePQwtpgqz8QHh3C0ORs77g2k3DNpjRR
	7EDDLhp2dr8L7RsV0suxFBescnl46iJx6B+UF9E/VZ/b2mFsr7GSMbX5lGugmE+2yER3jNgfXLQ
	LPkRdLkEALzjYYMgIwydI95nbTAPRwIxmQR4Lbqx9tFtMu36u+LeAJBJnfKeeF+VsdkBw/9yt2A
	==
X-Received: by 2002:a05:6402:3554:b0:69e:35ae:8af9 with SMTP id 4fb4d7f45d1cf-69e65272664mr1237776a12.14.1784301307558;
        Fri, 17 Jul 2026 08:15:07 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:07 -0700 (PDT)
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
Subject: [PATCH 4/7] dt-bindings: reset: Add reset controller constants for mt8167
Date: Fri, 17 Jul 2026 17:11:11 +0200
Message-ID: <20260717151134.678839-5-l.scorcia@gmail.com>
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

