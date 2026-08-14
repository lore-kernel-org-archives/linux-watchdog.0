Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518E34A791
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734881; cv=none; b=q7hKt1mN0Rq9wA5yPLDnr2F0NmLeOpbqLuFGfSf+XoRaFrNyPKoVVbEPjqch9A8HyH+CLsilUfFLOW+SoiZ8vwJCypZB1Q9xKKGJJ1F9Mk3WVHeI4cUvDIFuLlWiDF8JR8UXHG2Lcxxcit2RLv5YA9FJT67T14mZPzJCxcFE9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734881; c=relaxed/simple;
	bh=5Y5sL6+J7vx7knLCO6QvJggTZVlGNEgVsdnejYmQ5hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRl80f328EqTcIrUNU3uOaXJa3pQNsIQ37VqJ9wPo7c/YqSRB6i2bcsRXvEVttrNiS7nUaN4W8dI2mxM9zsWMtc3YNij0rQ4gpOE7TFM+EqcT+BZ6vH23xsmTJCLElOxPqy+rWy8z+0tciX7bCcNxltVnFfXMz+DvS3kbUhG6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bywXAKZk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bywXAKZk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so13020625ad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734880; x=1787339680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcB5rq4VZBgFk1thgYSh8cIbkfOzI14sOVjDrq4EZoo=;
        b=bywXAKZkv+PUj3UcegTh+QMlAWRgbf3btpBGnJ/VINrPf2fdNVDXNKcOXXi4insOWB
         NCnfHf1L5W+Gsf9/ZbfaGi/CJXQdRwdFDYhGjnnnumrfJvVnM0svnzgzuFN09HE0bugN
         BoFxna0xvQTWaJi5E8RviII1ExWSfmO/ObirdSpBjTr4Ep9z+oLSmeC5GsFk8c0+odts
         3U+Oi8vtRXCwgYhhI9xlKJxb6TOUKaCAZKALLO+JNmMCZ+LZE8NHhoKAqwPSssgqH0jH
         ZFmVFgjGGzp7kb4O7uKLG5bGzteVdYn2DK7UmfuOFgxSWHMiFFfhm7MYxpX04vbsbG7d
         B6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734880; x=1787339680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcB5rq4VZBgFk1thgYSh8cIbkfOzI14sOVjDrq4EZoo=;
        b=Oz2TiSmF6AQ4s+4LAhMf0A9oZOWL/nqIXIf5YC/EH0hMmzWZLsU4audYHslUaYUlIF
         L8X3u0tokh1vW+XNuLysb45LpUhjN51q6qKi5SblqWPi0EC6P20yjL+ejZiWAocSrIqt
         q14DOVrQonEsHmC/776xaFqJzu02xxy4YyaeyLFeER3Jzt8c/OjkG8tGaL7tGlt+nljF
         CV+mOWUPszqRlwXU1mfPyUYWbTevkHk06fdMJ+HbU0Qeg94hvte5+pNRNIfSsuoC12z1
         64lBVdKnxidykqICKZUKWLQ4ErnSmgE0uXzf1GvctaQ0UkI9l6PjvjKX9qZJtKHY6HEK
         29FQ==
X-Gm-Message-State: AOJu0Yz7Nlehayh+sq9awvoq/KFXksZhaJgrf/uzvIl9MWRehuNNNJ8L
	86lOXHwCsjymTrzPjkPE+tJKcAIziGD5X00Nzp9Wn9Io4vpC+OOvXwnM
X-Gm-Gg: AR+sD11moydBQkdQAprZy1vWxwm+uQ1URXLTwYMXgp92CVyV1m1pu0eB7TzY7eqFy5F
	LuL6qQ/5AAPJb8n/8wCuxNlkndY9EgHutxYdI8v8NoAcAbCHuyEcu5Cd2Wb02GZ72mHw9uUhNCW
	9f7TCESokGNTBWrleuor+677OOo4xWD47G9XC3RYoBvkjvKuMm7yCl/npb61bRf/j9+6qvYYfPZ
	yLjhVdNVJPzcnV/ptimleXUmRTxS7LrmYwoCXXUx8v8eH29RgG42bs8zfqwF/ykwpoTZar8cJH+
	v0hLuBsIc9jG1gRhMUvBjc57WyXCxgvDP6I7Pox17GZyJEafWLOgbBiX0oCwVUslw/zkeYVky0J
	uQEz2ISQnWBzeXfzdT1Vr1T39nU8wKkqaWAE+G0WBnOptSraQLttM7rR4Ppq5FoYm+pBw2SAZSp
	t8vPg3fRQlUh9Ox4rZWPQcdia1Otlr+9QUdg6NapAk4I0bnocZ05J+BsByrdTu1D8z2kSZtleTj
	LDvdPmthdPnrFnKq701SWc58G4MTGx3Fb4dFoJP9WSQnS83XJJ7sfslFogVhst56A2aNVjGTKkZ
	eFiYRa4M
X-Received: by 2002:a17:903:2bce:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d3b0aeeb33mr96710455ad.4.1786734879498;
        Fri, 14 Aug 2026 12:14:39 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:bd48:a716:c86d:67a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ead105a9sm6734865eec.31.2026.08.14.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:14:39 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access errors
Date: Fri, 14 Aug 2026 20:14:12 +0100
Message-ID: <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR helpers currently access the register directly using
`readl()`/`writel()` and therefore cannot report failures to their callers.
WDTDCR is located in a shared syscon region and will be accessed through
regmap in a subsequent change, where register accesses can fail.

Make `rzt2h_wdt_wdtdcr_count_start()` and `rzt2h_wdt_wdtdcr_count_stop()`
return an error so their callers can propagate failures.

Handle these errors in the watchdog start, stop and restart paths and
unwind resources acquired before the WDTDCR access. In particular, restore
the reset and clock state and release the runtime PM reference as
appropriate when an access fails.

The helpers still return zero with the current `readl()`/`writel()`
implementation, so this change does not alter the driver's behaviour by
itself. It prepares the error handling required for the subsequent regmap
conversion of WDTDCR access.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- New patch, split from v2 patch #1 to make thing easier to review.
---
 drivers/watchdog/rzv2h_wdt.c | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 3b6abb66a1da..b770226f785e 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -89,18 +89,22 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
 	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+
+	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
 	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+
+	return 0;
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -150,8 +154,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
 	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
 			WDTCR_RPES_0 | of_data->tops);
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_start(priv);
+		if (ret) {
+			reset_control_assert(priv->rstc);
+			pm_runtime_put(wdev->parent);
+			return ret;
+		}
+	}
 
 	/*
 	 * Down counting starts after writing the sequence 00h -> FFh to the
@@ -171,8 +181,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_stop(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_stop(priv);
+		if (ret) {
+			reset_control_deassert(priv->rstc);
+			return ret;
+		}
+	}
 
 	pm_runtime_put(wdev->parent);
 
@@ -188,9 +203,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 			     unsigned long action, void *data)
 {
 	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	bool active = watchdog_active(wdev);
 	int ret;
 
-	if (!watchdog_active(wdev)) {
+	if (!active) {
 		ret = clk_enable(priv->pclk);
 		if (ret)
 			return ret;
@@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
 			WDTCR_RPES_75 | WDTCR_TOPS_1024);
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_start(priv);
+		if (ret) {
+			if (!active) {
+				reset_control_assert(priv->rstc);
+				clk_disable(priv->oscclk);
+				clk_disable(priv->pclk);
+			} else {
+				reset_control_reset(priv->rstc);
+			}
+			return ret;
+		}
+	}
 
 	rzv2h_wdt_ping(wdev);
 
@@ -266,11 +293,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	rzt2h_wdt_wdtdcr_count_stop(priv);
+	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
 
 	pm_runtime_put(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 static int rzv2h_wdt_probe(struct platform_device *pdev)
-- 
2.43.0

