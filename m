Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC364CA262
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525474; cv=none; b=BZTNapqW5olQSnwIYdxbewQCgQiywJr0+bS09D77IDj1vQib+nm7oYRzcYFvB+Fu4UKS3oD154khHZoKvxcTjtnqtwpCP+3V51sFAu2tQSXc3/SUha0JzCUHsNzdEG1/xYbEWoHl3BmJhvBGAcM+Zh/KFssfWr9cfpolD/UeVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525474; c=relaxed/simple;
	bh=nDJAbJCFuUB7OnJXjKjnKvBkXflAc5qn8SUxoJPyYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTRoKYoxjd0AM1A6VcADVdrJCbr/jTLI5/1CD8UKbpj/8y3G4Sck73qHbijIUMeFxaLOXPKwG7XjYOvjXXFMaVBCiQgFh3A0tsKAMjb9rCeAx04uisPONTQ47kTBPToe9QkVzM9hB+cy14rjszg9x7Ygr2SUpxAiQx9Fxv/yhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ2Zzveo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ2Zzveo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso43415135e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525470; x=1779130270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Av9KMOeHNoLZjJvkQ1HtWMUmgg+DhH4RllPkn9qKDs=;
        b=jZ2ZzveoTEvVY1IJ2YGdes/ZtrfZ+Oi9pw5DbzFjU9kA6j+d1PsEiJn6u6aqvs+KzM
         7R19IjFUsajdZNxYHYEhleJP3YRFIJ7x8OHCHGlEuDEQk9nLYDsPa5TTJ05QO5DlD0JP
         /p0MDO/7JtDv5UFR0yTJJmkojv21NbEnIQJ6lOSa27bJF50RMuFZfWinUhNYGoPc8n4b
         uo+CpSj2tgwXHNL9qNQZsgve0P1EqfraqODUUHoMo/OESO/DQ+lL0zlaEalVPzsAZPPg
         /aXgqEG4XTpNYQSlyoA7SfJWSrc9/MSnzdm01DR1gvDFqJUTaOprc7i1Msy2Cwd9fvZb
         g/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525470; x=1779130270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Av9KMOeHNoLZjJvkQ1HtWMUmgg+DhH4RllPkn9qKDs=;
        b=HbCnjtP2SFO723CDji4VjetkM1hsRLEt6x91U6h59s+3WYrO4IutqZrWliV7h1GJaC
         x36EvFFK333KsE+KYO6pfH6LkPxQU4nhOORP/WqU8Ya5mkRWj2+0nqCNuUJW5w/GU+Lf
         1O7ey138C/03zmvaLLnrojXBr5RwZjMS72vfXBMrA72MIlT6d5R7BtCRBLtoajT7RcLe
         QO83zBGAG36Vgm72RacWhGmYrFe2WnhFnzVyrzhS/Pg+/MF0zZDjE8+qFeR/fbFsLTYK
         Ui/re3HUx3cDVnddBqKloACQaQAhI9HmAzHLgoE8SzBjErbkgtp6hgq0jIn/lTBFtY9O
         X1mQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xNbyNvJA84t5SLJBadxJ6hU8g6r2HGIYP/OubbfJjY9qkBVFtmSe3Ph2fIGe3YLwFEw80HM/X+7BErQuAkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpgxsDrETc3UpYglks09QYQntBuiMWCuxSaZ6d59VSzMxrSL7
	Stkc4C3kZi/SSGfPwl4fwg7OTD0uZfoPDy2gNrp+uizkwtY/T7dhqMeV
X-Gm-Gg: Acq92OFCKHso19M1Tvy12msqTAPmAZCyn+47tCsibK1ZnFrqR+MlIdoGO6El24pdyEU
	7eI5F5Z0SvHRY4+kdiNcXIN5+CU8FNVdmofksMFnMl8FtcuRAN7WkbH5sKxPQMvH/NHaNMiShgd
	qXKVQZgkqPIkncFsIDaKI4inAj3GlUSqlqEyqC77MRzOjUnO3Y+4p2q7BDDvTTMPQTX4HH1XlKA
	zDZQ8ABvH3/qKZ+zRKeKm1TURbIbA0TVMsqK7oRDNj0RP8fY3s5eoRGfjFvDMoUUzGaspi9POlP
	3AFn8XsHpXHjH+xqUeZibI5IKdf+8tFF/JcpdJjcOMRTpsematuyvfw7domd+jwfAzgRAOdfFhY
	P36LvgoOmDnFrQlX2z5BK9ypCbBX0IpCM/mZIUmeUcY7utr3afHeeK40QixBQYQtBy2FN+VkkFt
	4gwrlyjmCuBw6ueR5q1W6XzwsdftpHkZzu+11jeViOzNfrscszolMTDBp9QM/NPXt56K3iXWXkK
	8sTES2qYvkKpYp+iDWhUS2nsfskEduUVDsfFkNA1eBPiuEi
X-Received: by 2002:a05:600c:c11c:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-48e706e0168mr119438945e9.26.1778525470462;
        Mon, 11 May 2026 11:51:10 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 6/9] watchdog: rzv2h: Refactor WDTDCR start/stop handling
Date: Mon, 11 May 2026 19:50:55 +0100
Message-ID: <20260511185058.1926869-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Refactor the WDTDCR start/stop helpers by introducing a common
rzt2h_wdt_wdtdcr_count_ctrl() function that controls the WDTSTOPCTRL
bit based on a boolean parameter.

This is in preparation for switching WDTDCR access to regmap-based
handling, where consolidating the control path simplifies the
conversion.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..e9545b8f5fd0 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -89,18 +89,26 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
-	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+	if (start)
+		reg &= ~WDTDCR_WDTSTOPCTRL;
+	else
+		reg |= WDTDCR_WDTSTOPCTRL;
+
+	writel(reg, priv->wdtdcr + WDTDCR);
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
-	u32 reg = readl(priv->wdtdcr + WDTDCR);
+	rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
+}
 
-	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+{
+	rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
-- 
2.54.0

