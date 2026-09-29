Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E851EDE0
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679048; cv=none; b=iTgB0Z12hmTSaP7yLe6tcTfnEs7/jNz94Dl9CihN3TE3qYwv1Oj60U4z96Nbv5SrU1wkcS6lG1d38e/xj2NSvlsb0nbNj9jN2xzMnXGzI7PqKoAypWVNBEdYZBR3k/N3uiVYC0tDiGGhE+jxNxw5r62HpgguCMP8FPXPOApMCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679048; c=relaxed/simple;
	bh=Nlv1m2l7ghTkT3cO5yFi20nfIAUpd2j8NLnXbA6e+rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k79XMV/Bqci3htrxSh5RMmuzCtYvrMoIvcZpfa97ZqD0q1tI5HfEAX4nDE1zjZoCvLXXLN7D1QTZ1x2yJDTXA5lpUxlVkshCKbYz86RYpktSKSaUcR64yUWrqZ+TDsZDVbyiPTxvWuSVocaIjXgQcBhr6/dptDSRYO/uK7pUY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgtErF8d; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgtErF8d"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so3623725f8f.2
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679040; x=1791283840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5tHtfYr9TOddaGe2pXDMEwIuJ0LgMwAhApw2cB2IqU=;
        b=NgtErF8dUX2SZCDiJiA/8syDRYJR4n/Kazm2CT+81R3QoJzDZwJylIodtle9Lv5RyL
         XEH9E2btWxkb4PnG9azveAWhfNMgiRhoredtO2GXY0fs0qFvT+ASdAim63AKLPzdz+UX
         zgbX/rAmi5iv4db3yQI11XDfYGFm6joBjpkOJyaTCs435mjuwDJYOfmsHMBNqiisix17
         k7TlvZnxyXjxnveiirGeOwXSREMNk2YrH3RFcugZBv/dNP/mR4BP+ICVuTNtjkVVtL7X
         4buwxQaDyyBsSSFmD8QDeKtgq516jYSwHeGBY1cTq7O8P/tI52VGD2gLwzCXNSdGOsfT
         6TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679040; x=1791283840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5tHtfYr9TOddaGe2pXDMEwIuJ0LgMwAhApw2cB2IqU=;
        b=hgJ5xtCPKh2FFagA1/2KT4oFHxO6H/Aj4Nc/8d4Fdbnf4NkDosEWBdsywGAH8NtFD6
         NVU2oJdGDLBAQ4Zr22xH+Jb2Yyj7fcwguL5a0ztdrWYzAhWGuIdeyT3KGXgKy2QFTLuQ
         Vk/4hT3orBT+Kusnz0H8OmDWwi6yDnGR87R6pn3E/akFR2D0dhrwPbWHXuiWr9/+BthV
         WGfhkMv+gx6/mULxWm/9BxHv8YUM/5h/rKOWG+h2IwR7asVS1ru1tFBF6hn0m2ptwWk5
         oftvUFHafPg5PGUilKgOlOojdtZ7ILV/mCZbY+04yChf3UHD8e4bOixC+UR2adY2vQRs
         GOHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLHvEQhCdyanwrBLfd6UPlb8aBUBw+sdd7bu18MASZFlkljN8juzEGhLVAXZrXSbU2JvTAq5loomZXvwTDDw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLc3LRrjki3U8iNGImyZdtGoITmbmyzXJnubDxB16f53Ccye32P
	dTaOsXuStpvg7/+bUbPZzDGZc+LoEgzUz8uIUWQjIp086dTXTZyb0x2M
X-Gm-Gg: AYBFou2XJZWyxiKbALFyUPsY2NPBi3D7NbSCXam44jzvQzctoAUNERULFpz/ap6Sohb
	oJR8n4pL/CxCWGHHmLFo5CTEZW02rgTy1sYconfPR9EE4DwY2sVePVWa8TeqX1qgTD6Y1QWe840
	oCOZ/Jr4EHyInQMy5fd50xp76t831pcdaDfYBa1E4BgdB6tT88+Ma8AsZjYkz65j+0QoJcX9w/n
	wpUPFdLlXis8JIz8YogNxx9mJ9kpx/BK6hDFPsVtxCLy6b/F3YRJuTRLfZ2vjqBS0JpW1vAHFHQ
	eENT7EKCuD9ncqq2HFy9m15VofvintjjhcRrBOjAY4r+t6xuvpZPZjNBb9sN54Oj9tMRmHwj3gs
	8IO37asB1RXA/sZBozI9V5bBOKt1hM9rekGZi0JXpF65FSFBPZ4ugLll7H3Yrzo67NYwgjGDna5
	N2xt6KgkFRP0pdUmaYgiaOFQjUc9k9Qxla/d8xGRIm955i0BmTCOEdDmDSxS6Qpy+0Hkc3t+Vbw
	DKdBGGBYgU8hAHXx1HTBtmFyeFeNIe0ADjqNVIT/tMLtkI702xpE/hVCFn8Gr1xXD5Atusm6klY
	L2ANz/f6ssMnjTqpHg==
X-Received: by 2002:a05:6000:230e:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-4887175f986mr28573245f8f.36.1790679039746;
        Tue, 29 Sep 2026 03:50:39 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:39 -0700 (PDT)
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
Subject: [PATCH v7 5/8] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
Date: Tue, 29 Sep 2026 11:50:18 +0100
Message-ID: <20260929105021.542730-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

WDTDCR is located in the CPG region, outside the watchdog module, and is
accessible regardless of the watchdog's clocks and reset state.

Drop the unnecessary runtime PM handling from WDTDCR initialization and
access the register directly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v6->v7:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 17c9e9a24ce2..40157e969f58 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -242,20 +242,12 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	int ret;
-
 	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->wdtdcr))
 		return PTR_ERR(priv->wdtdcr);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.55.0

