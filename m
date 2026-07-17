Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66842A783
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306514; cv=none; b=OrF8P9y/QsPu1uyM9wS1vFoXtHjxoRK1qj/5BAR2LaKGK6eo7ROqEJjNWSu5kOX4snkfBVJuvd/SQVUF2fUVpuobydSoBnMG/GUAAfuSvcEpfrn4bkkXpA/dcpdWYKRbCOquB/jhrLB3DN7teRzLIjADw+d8/5i9xNRS+WJ0aJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306514; c=relaxed/simple;
	bh=lzDkvhh2lb30hMamVDhq/leCdMYgOXSSuP4HjE1UCy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnwUZnqrFeFbl+/L54IHUNIBH0sIJrib3H7GqXHUlL4IjjWBREZW2y8Sv5o6d+hDxtb7pUqL1POE/PXJzMKzlJ/MuZ46YcS/bnD6zWN61TXjiDYBFMkhbR4/BefG0Y2rJxBwAQ+7SUZ8SsMxc61jwtsGxsGcQdMgqpDPSlh4r/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfDDjFGq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfDDjFGq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so940545966b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306511; x=1784911311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ns/s8X4FLGsUS48lb8y5zK7Xq5THvoJSYI6z68H4XAE=;
        b=ZfDDjFGqcaqW17LDrEJugv3bf0L7tkA5SgseBp0Wmt7IShKzn+BDGKVniZTCZJkWVC
         l9IPPvIj77w64stSTWTTdPmfhAhClJ//ogjvz0KwUATe6JIe7LYd2qZOC8VrtxkBeoGu
         Vn3fBVHbev/sEM+eefYbdJtgezliBdwuPI7QQh8wQf3mj1D5ycmZSnXmglYReeXD7eYc
         nP5fPTvagwJATr/GMej9Qy+zwubhcpxfs0X0AORxrXjbwkwN/HdBQlgXGOYVHnDz6ftp
         BhBsTTA7XweBSjIT1c+ABAXaqVe3XFMjkKZS1CrZHLFgvbF5v0h+i3WKIjE8XDojNPYk
         ARcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306511; x=1784911311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ns/s8X4FLGsUS48lb8y5zK7Xq5THvoJSYI6z68H4XAE=;
        b=mWW7xhkI3e7icJPRXJyhXWwoOkrj5Bi1PwO5a76KNjmpMMNqEjxHdkXHIMrPyfLI6S
         jdWcCBQNe8l/yFi7plQYXWE1Z1FoxqOoPI8TLHynmSZZ1VF+7Lxq6EVaUmuNAUCEqW1O
         cGBxehbIjwUOKHYBfTxBWjfmR/Cru5JnxrDim08KDNv1jzRmwi2OJqwS8DRtLzZo1D9e
         j2Qoh3evSeyf+JzZp5/9nyLNWF9xS3HqfMCBp2p83P8O6cSWLen3g4WaQKo8qJ1vMBfy
         5u9gg52A7JguA62vF9N+f0XTAD84zyfCqLVG8tm7lTjFKX6KvcKHFvosZbcChXXsO6pU
         2VUA==
X-Forwarded-Encrypted: i=1; AHgh+RqCZDXbXqpzHTGt3rEnoxTKJvEx4UbBhgakp+H8dxnRJBAJYJDMRigImim3irZYBOIAvl5Je/7M+bIvNM08uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPx1lxnCDAQ7cY5tl1MZIyFqRkYYrT7cKtlENn6PqFSZgNHFyG
	7bHAQF/M7k2cjlXfN98VgvEm2jCoah2y9CorT873fEEUDKXWJSTqGM8s
X-Gm-Gg: AfdE7cnLu1upoDhvzAcsnkEPexoy7p6pm6hTR2P5jUzGFUuwf4Bp0CStwfzqCjxNyP8
	MwveuIuNidlEBhe5uIF6UoaEn37GVxGy3r9x57o4LmPVAeQ+dThFjsMiWZqEckbXFJ2NhBtJLdF
	T6qpOKMhZQVL/5pPQrZ6/ilDPnedlz+Q+A+RCLjGgHAm3nJsjyuvIEIyRvvx7Nl2V/GbzsV5NUZ
	FrMid1zatDAmotWXPxNI6ea0rngTrgKZ9r4kXQtEc4LoB2qk2cVO4uVfwAywrfnEf/M+y8IjtmA
	YlrqOpREQhPPeqA29hyCOzxN16PMZKjHCsWYcxGAG4cH0wW819dL5CL90WGiEenuNYrnfRkv5sK
	LgleKXJ/kvCHvIVNnpKNI7g0oNQnnZTsAR37FvlXjeLzdjtg8bIFW7s8wvg6ATbNRfGmX8QclBA
	==
X-Received: by 2002:a17:907:1b26:b0:c16:14d1:b529 with SMTP id a640c23a62f3a-c16b46e2b24mr154301766b.18.1784306511183;
        Fri, 17 Jul 2026 09:41:51 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:41:50 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
Date: Fri, 17 Jul 2026 18:39:12 +0200
Message-ID: <20260717163959.714561-2-l.scorcia@gmail.com>
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

Add reset constants for the 12 MT6589 toprgu resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
new file mode 100644
index 000000000000..ee08c39df513
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6589
+#define _DT_BINDINGS_RESET_CONTROLLER_MT6589
+
+/* TOPRGU resets */
+#define MT6589_TOPRGU_INFRA_SW_RST		0
+#define MT6589_TOPRGU_MM_SW_RST			1
+#define MT6589_TOPRGU_MFG_SW_RST		2
+#define MT6589_TOPRGU_VENC_SW_RST		3
+#define MT6589_TOPRGU_VDEC_SW_RST		4
+#define MT6589_TOPRGU_IMG_SW_RST		5
+#define MT6589_TOPRGU_DDRPHY_SW_RST		6
+#define MT6589_TOPRGU_MD_SW_RST			7
+#define MT6589_TOPRGU_INFRA_AO_SW_RST		8
+#define MT6589_TOPRGU_MD_LITE_SW_RST		9
+#define MT6589_TOPRGU_APMIXED_SW_RST		10
+#define MT6589_TOPRGU_PWRAP_SPI_CTL_RST		11
+#define MT6589_TOPRGU_SW_RST_NUM		12
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT6589 */
-- 
2.43.0

