Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64C480971
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995499; cv=none; b=LB741S0UaxsSXtrzt/mM6eWM8kwi6Nk5wM5t2QnqINfaOmTDuPgYE3R7U1DvAcmnjbiBePW4qJlk3R85STFUngUI0trJmN5wc5DIj/goP1wuwQVBd6Il72H824mgGCEr6ox+tbndHRG2rRIQO1nkFHrHLR/NBplnOVcqGDay7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995499; c=relaxed/simple;
	bh=xos7in5Tx5zjrpPU8l6pvfEG31w4lotqHqq8+a6Gya0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEDpFeEAaa3U3mJspYqkiLAr9hVuPKyIlfL3cRmZ5RYYDZRtinSux+Y7uhAKa7NgoSVDxdCqD1bJrdMud8n2QU9C6PKdi/nurvUomQYvSoXWQB/A9aY7TbUDlEZZgU91Bfzfvw7v3moq/6SpgjUT6HzN5gyjosqB6WZjCwXigbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLMsQTMg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLMsQTMg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c00f74baso9939875e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995490; x=1783600290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSc0cDIDo1ZXEmAON/XiNWuduFFW8ewj9EMw/32lW/w=;
        b=tLMsQTMgR5OiW254DFThrfMEqVwgSv5X9RP7E926YGgn8hZuU9NbK81qi9+uln57TG
         c9WXWuYBgnx9JwFHT1/i3Iq/o5cnwnO/bJq5dK9Jms9NESE/zdtJaBSbQBBHdbUUyOkX
         iiaemvBSLgqoGYS3/WbF4h1LIwzHv596J2jotIY/aSP5m/8jQFT1iEj4psEJpM2riYLt
         YiMGfe+SvwUqdpVh9e5iqiAEVeKbpqY6/RUJcCB5eO8FzxY6O+Au9PqL0FuXwVz92GXB
         u/K0RdSIfbNdLAOOQO7TyJu1Vt09YrA6Gcnp9eZa5eh4jPpdGP4/q1aq/q2UTofrpPLu
         9e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995490; x=1783600290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSc0cDIDo1ZXEmAON/XiNWuduFFW8ewj9EMw/32lW/w=;
        b=rB10Ze0wHi/UAUQWtO5uxV2fcznryj1HW52g0HPOLhIiLd0MTQtFqa5LScXS03pYg4
         d0TRMFZsg4hBY1RvmvwCSf9pstocAq3Q+I/ofpk1nfkUz48dkZZ+NOxktovnV6KTeVY0
         yAJDou6u9NqrfpyEsJTGHKoddRN8+1EZ+O1+l8IavZsEdL0BpQugzqROL9U4Yr0tS55K
         RD2u9h4dPpD4Xx76Jk+mQroG+wJC9wkpGFDrwDv07kSZYADUc2q54mNIaKuHO+vwEyp1
         i6CJCfGp889nrd3m6UPY0K5/mXuCGteW7t8Lz/imMDewBWU8Bfuw4w0WBNTpSLJ6ziUJ
         S1wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sRxPk8MMNc1Q6VQliK47uMoZJNiRdCcTu4Q2uY8Ot8c5ATAREZ7ULE8jE9/WmnVUStKo/8EgVY/RssYZAQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwooYsRQz4r9ESHryxftJdIkQnEYFQFkt9PhNUh3ROptCSKyL5O
	PQJFs5UK2lomtXSaLyd0oO7VpTBjwZNga+Y1qwX6nA3I/WkSF+bZc1St
X-Gm-Gg: AfdE7cmMal8YzekE7+2nbcurZJjm3zkYfV/PZq4jWmRXVGQfPLBmRLpipewH5qTpCC3
	Rjvn5CUt7RZJ4CxpDfqd1U2ULQr/ssXTxQu6SdPA8Z/xm6k3yPRuLACUsqwfNVrQeaBnoePDTvF
	8DrXmFdb9A2HBgn6WP2R4x57mbYr8DawY+JrN6tXzcq7IX36QjUGiyqP9HPyGx6LxMc9L4+ezX5
	L456KSstiKHjOouBdw+AWiIfZ/O9JqMZzXJdDfDolIdEqeaCpjwXBHB9sCgRegd1J4QrRZTGh7y
	1ZVIQE0jvICGo8dIF5apfeffXh8XBZYfT22klgQWws1xm51/Wdcgo5QiFa88XulPhIEZCtmg/gB
	KuYasN7phw/J5YwuXAPwr3JgNjw4xFj/hNcXAhIQMh7souMMGP0R532UOE7BD1fHX3m5H5abUNW
	iCRGsRH7MrktigV7SAxM5+T6/J1aEZlXOni4/loOAez+pl4w9gl/WhqBzE7LSshMT0ckMJiF0du
	g186oL1fT/UyaDF7ObWjsbBFQvZdmeL5LTSQg==
X-Received: by 2002:a05:600c:4f48:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-493c2b5400amr102965325e9.15.1782995490018;
        Thu, 02 Jul 2026 05:31:30 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:29 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC v2 6/9] watchdog: rzv2h: Refactor WDTDCR start/stop handling
Date: Thu,  2 Jul 2026 13:31:09 +0100
Message-ID: <20260702123112.161160-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- No change.
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

