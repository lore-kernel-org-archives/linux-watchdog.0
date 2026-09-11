Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33411451981
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125498; cv=none; b=tc+n5RwhavWnPOejYLRc4sA6oht/BOYeCjGQMZNpf5KdHtNyBqhbAzQA/c8YqGi7HDXnSABilS7zI51BkSZjg3vSykfhsQDi/Qc15ZSTu07zrFG/xpSgn/wwjmI1L5O3vjQlI1EvGXsBjV4xGEXQR1K0/ewaPumIaE4WpBVTbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125498; c=relaxed/simple;
	bh=poHAk1iRSPkkWec7SAiFOpPgNT8Qb8coRxeZh15oi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYNggtnBTu6Wobst2Vrrc9zTJw6GfQOmoj6oFx2RK6fIkZifrpE6/FmJe/4XluQV3e9uykEBA+00cQ5vVXwCQa4F/QIa5s6UWNVV9JRcuTXygzEf9LA37JGZk/mlbOtv9DMy0wGwcR+pHVJK8sEE7LsPlh+yC/Q80TZndZnO9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6HveQpq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6HveQpq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485850cbac3so398677f8f.3
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125468; x=1789730268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfnV8b6AfEbN3w+t4mx2Du5Ole8Wgoa6AgZfitPXjMg=;
        b=Q6HveQpqJH0GGeri5qaeS1Zegh/Rg8a5oqcldnM7NHkB/YE6sK/c8zO3kBdc7/HD5l
         nglevh2+glLXKTQkg7FoGg7h5dy19g/ReTCjjUlB/T65yDe/IMuctxwa3K5G2MRzEEkU
         QRVvdmZQw25ZNqpXQJkpnGTnKGAL65iwEaOe8xyrvr9p9EkNVCHaaMTVFiKhd2xNypTf
         VQRQMNkFWOgFFSTURpeRwZaO1LOb/wwaTiul5lC619PEyqkw/HDqG55ld+dRQT2J5O/o
         8sIOBQe4+G0FTdetirra9kBdeSX+fPGHrOm4ew3MY38b3XZs5hkLLfII5jqYPpjYnFUE
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125468; x=1789730268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DfnV8b6AfEbN3w+t4mx2Du5Ole8Wgoa6AgZfitPXjMg=;
        b=TCetmEqRxn5NPw43k60N5p1MoBB3/DOXIbwrC928ogxYmQM3o74s3I2zOZbVgpUMUP
         OySigzA1DeNQcwl+m4NXw+gk03f6cbn1nJBa1+Hv8z85A7x/swMt9q7BpNzVxz3ydlwU
         lsZnVbBccI09qMMkGy+QzmIyJmLce7Taqd6sp4657quQJ9t+U6PbPauNeQAPNVKtIIFB
         rWKA1jQw+sJtVJ0cSbR1fbFeK6ooJpip6Y+HCzSY11qDdH3xoLsvB4CVGs0/iEE95CTD
         Ul/50iOcSOhA4uNiy2ah3cF1gIEWIzynI32tEOhXCjJh02P2pPPelxBvQbxYJo1nkNEx
         b1RQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6gBUsyA3r0W97wmVZxnhlvRfJB+UE1p3WdqnFAFPaxJijemmje3Mzmvof9g7a+XKFihyeYjmGKWxl4rxO9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mN+dOdsYBtDc0Zeci6Zv/yzN/SM7URmTG7iZTvzem+M/JD6WLD
	lmuw9bZByHyQCQbt1T1w2aUZpUFcUItVEdFevXsKgRdKPG1CQbGsD0Iw
X-Gm-Gg: AYBFou0b/t0Jbbv7sifUzfvijd74XWc0lxViMV2TnCCv9yFNGcz2MQdJ5K/bl2cwbCa
	RBmPBVIY1GascXqUVZAO9rTBWjHBIMomDp+xf5scH783TUPkDZAzEgftVoDsMMYbUKKOrkTHTD4
	2LX02B5jIWIkeN8QiyfYt8k19Jk0aWKmumJU3/LWm9hYa8rtlgVTK2+DBpsRa2EwEZmBz29i2bR
	pA9Yzrw84JKIIg59Eo5bmbo8uEpzw/8virJzzqnp5EVf3JMUpusDMUCtCkv4py3D+3BS3D5vU+e
	LPgYwHHsSXtbVw/PCM2kJ3GYLR5NquUvyMeb0YGRDBMjL82ZU2P8MG+O334ARuu60giVrscS+oq
	bKkkq0F2jnnMY0bfZTze1xd2WkgAoRLMnK0Efe37xsumXH+L3agV/pYCoq+Typ+PivCJaNg29EQ
	VUNTPdTk6DJ0K41pWqkG8n96nlLwcxbsTAoGBnZDd6dmacuXXqDGauK/qfEtyNmZJUX5jHCNrUo
	EmCrIViombVYvdBuVmynuLuJ2E4ZuEcC7iqGQnGYLuXizAL0hCqYzl0lwjBgO5+CD8ULML0V93h
	mduJUahb8gaMatavBVo=
X-Received: by 2002:a05:6000:2c10:b0:486:e37d:c57d with SMTP id ffacd0b85a97d-486eb345e9dmr4546787f8f.43.1789125467738;
        Fri, 11 Sep 2026 04:17:47 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:47 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/8] watchdog: rzv2h: Use pm_runtime_put_sync()
Date: Fri, 11 Sep 2026 12:17:27 +0100
Message-ID: <20260911111731.3404308-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index cbf414e0c9a3..4a5a856060e9 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -270,7 +270,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return ret;
 }
-- 
2.55.0

