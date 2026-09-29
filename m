Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511D5208CA
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679052; cv=none; b=EGVprA0Bz/iV7EtEVwYO7ahksGhftyxNqkSPNde7WSRNBO/IbmCvV5qEHgR0/XT3T5lA6nEKqSbzdLmqEbMjQ8N8gqnJYCGjPf8fiP6nv93ktgoAxZUYOzJSeGFBsF3OBCqSvY7+TVi10zuSrt33160assZQrDU6aTKcZ99D1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679052; c=relaxed/simple;
	bh=24VJL4yr71yDjFK19B91jRLLCZCsRy4Ks9vH5rORZX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUT5y9oWnP6zh/AByLzEenvNujCioUrm8WFdofC9qnpuxFCYDnRsQr6tKI8yR/YDjH+psm/O/Sh/PgHjFnyazMEHhGe40YdE63ZTBFLFCuKTC+PZJTRz4wYl8Fhs9Suaz4FY9SzsxmDnEWosuAv0jzOyr3GCp8U9zFH/KpTKCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtehukGn; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtehukGn"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso3160851f8f.2
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679038; x=1791283838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRZBWbdx2V+lf3HeAagoP8lmXsSParpAXBpfb0Sv3U0=;
        b=OtehukGn9KxWSCiqayr5219Uscq6hSCHyeC2BaRNzBVSXArCaiANl3+diBNX4G32UV
         Ixu5l7k+rd2QR8VWU6k7pBVIAYGjEIFWSZ5Weg8baIZQNJSVWvQrnbcGSfQ1FYFZAk4f
         yxE6vSsdjPwiEXZvJiOcX7QJAoedGPyi8lXqe4cQ3bGQkKZWiD1fk3T11tRukPEaaQXt
         kLlMbbesUlbSUhXX0AeA+Nzw7r9je8GnGrqk3RaoVjYuYcxMLPUMh3e1LfPfhHBuSzJo
         1zzk3sndv64ToDf8bzz5TClovmh60MFE9mPywD1vbgJClJxOUmkba4MPkbGUQge0fEaf
         Li/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679038; x=1791283838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRZBWbdx2V+lf3HeAagoP8lmXsSParpAXBpfb0Sv3U0=;
        b=IphfPlD1qdWiKTbnFo8G2j1Gh8gQxXx5Qdksb7YyRF0HUFUu1R8KymZwuwUNqGWy9U
         1uBT9wRzpdfkFutPQa9Dc4IQhyDdtFUJwuBsBC+38wFIgg4n3BHkDSIG9J4rDf1PP2pS
         1Ek6yvoI8oj89ze79/LxY9ntZ50A0jgE3XB4AqQuximqZkrX2M8JEeCzsE9188geByw/
         BVnakCQH/QuGZ1fRu6C1RFkZYQ3hqPja6qsRgKyrOcrHorHNOEeTyMdObtZ4BBN0aiG4
         miwHVIud4dy/vRcbK6GbdMWEd3ZtGpVFf/Vq9z8ROQ8aSIrNvvM9Weh/MXg2kc5Zleg9
         gHhg==
X-Forwarded-Encrypted: i=1; AKwUvBzNw3TznhH3vbAhmgwq+9Sr9TmjvJKTas8TdYdWS+BZBQQytSnBsAb6ZKurvfUqdIPxdXB2ZDqoYGS8wl11oQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lN7jFYbmpnj1xdVxchokzTDxzjYZWVWOCvp1Wz33v/xVv91IUU
	ULQ4GemWE43/Pj0KPykUZ651UocJzUVGWPxtwuwQGAf6TNw0JtlKx/n8
X-Gm-Gg: AYBFou2NUjfnB/ql4jX6iVrYWwTqE/WD8Cn+SSjlW/8Hn1rRtbK4Yv3Gw+VhpDt5OpY
	sc+yg6nDfCx4XgKl7nDoL8JKmbhTfq8YXQgv7gIj6tU2bwTsk9xCKoqZg3qUm+cHaJ5c/c6jcWk
	ibqR8Ts53bxyzt3KjnBjRAl8s0hRONA0+4YGmB4MsvKuqYb93edSeEVp9qR7ymKTwB73pez5PDw
	I3ase0jRhSJBTZIyvuoeo+NXgIedGWVN7BcpK9oAIAH2Xf9axTqvntuAoluPgn88w6rLywEoCM4
	P5JRKUeGSNl3AtWA1i0A5ZNCn8ZxldjCRn655WVAKZsmecUwePqf+v2YyrBA6f79sYVbtPbOgVb
	eIm0aLipP6M6zhF1KktBBmHzLq/OEWAW12z4ZS+T+a8jKrW0BDPX53lzRAPfcYl4/QduBkJTuEe
	8L5+Jh0C4icvcOgx7d1jO75tsZC+gm7RwnqySTUbng1VytD9AIUq7t2lBfFy+vI/1V3kVW+YeCs
	c14dv3FX3avS8pJOpxHWvFojJ53EOif95bjJBGDlY82ObfeHr/2ABHi+M1DOwRV9cPLPQQCpCq8
	6xpiKeAxANYqwKiqdx2Q8ZGRx/ol
X-Received: by 2002:a05:600d:848f:10b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a00bc928f3mr39671375e9.34.1790679038306;
        Tue, 29 Sep 2026 03:50:38 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:37 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 3/8] watchdog: rzv2h: Drop enabling clocks in the restart handler
Date: Tue, 29 Sep 2026 11:50:16 +0100
Message-ID: <20260929105021.542730-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The watchdog restart handler runs from do_kernel_restart() with
interrupts disabled and after smp_send_stop() has halted the other CPUs.
Calling clk_enable() from the !watchdog_active() path takes the clock
framework's global enable_lock. If a stopped CPU held this lock, the
CPU executing the restart handler can spin indefinitely and prevent the
watchdog from resetting the system.

Keep pclk and oscclk enabled for the lifetime of the watchdog device by
using devm_clk_get_enabled() and devm_clk_get_optional_enabled().
Remove the conditional clock enable/disable operations from the restart
handler so it does not acquire any clock framework locks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v6->v7:
- No change

v5->v6:
- No change

v4->v5:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index f247e42d54f5..55ac11fcfcab 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -192,22 +192,9 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	int ret;
 
 	if (!watchdog_active(wdev)) {
-		ret = clk_enable(priv->pclk);
-		if (ret)
-			return ret;
-
-		ret = clk_enable(priv->oscclk);
-		if (ret) {
-			clk_disable(priv->pclk);
-			return ret;
-		}
-
 		ret = reset_control_deassert(priv->rstc);
-		if (ret) {
-			clk_disable(priv->oscclk);
-			clk_disable(priv->pclk);
+		if (ret)
 			return ret;
-		}
 	} else {
 		/*
 		 * Writing to the WDT Control Register (WDTCR) or WDT Reset
@@ -292,11 +279,11 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->pclk = devm_clk_get_prepared(dev, "pclk");
+	priv->pclk = devm_clk_get_enabled(dev, "pclk");
 	if (IS_ERR(priv->pclk))
 		return dev_err_probe(dev, PTR_ERR(priv->pclk), "Failed to get pclk\n");
 
-	priv->oscclk = devm_clk_get_optional_prepared(dev, "oscclk");
+	priv->oscclk = devm_clk_get_optional_enabled(dev, "oscclk");
 	if (IS_ERR(priv->oscclk))
 		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "Failed to get oscclk\n");
 
-- 
2.55.0

