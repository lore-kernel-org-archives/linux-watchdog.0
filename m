Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53644C51C
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134755; cv=none; b=OV+3niX+C8oIsPUZSbJlSYdQE/rtvL3akNfYKc3WSNc78MxsnfnKrAT9mAzxUKySYVRlLHWOcIHFlWI+WrTzWejU+5NpkC+dQJcSpKMSJ5nY2gOGEWrenEmnQjRVoLbg5eRFxYwSQEbXJCuh7Ow3C1KMYUx/5A39s7lV0tEghRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134755; c=relaxed/simple;
	bh=4pf4OTamBGMYBWE9OUDagulAeam31oZk/0AX8NxjzdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlVYb++2Yry10sAOv/dYLhY5lnWVQSvzIdkFMTmM+tANn16lk/uvYfMvudJRSXRv3JF4vXbJACq4BgTsHOSU5COP2KmyQX9KqRfGHJhvjotJdLlet592SFzFkhKo6GJPRgreI70LiQ4ILf4MNtc7oRAfJNIT9n+gMGGGZ5paruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrOTjlad; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrOTjlad"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so8060855e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134752; x=1787739552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BNNHoWdgT2CrEfPiTooQfwweAtxpbzmh3UlJhmBHMrM=;
        b=SrOTjlad6w51iG36Tv4iaISHGqVyC/nHLs1XCTO3mIi4bupYprqnOb1qfS2GtxHb8E
         JKtpFrf/6+cDVg6/w7FG7iCi1e/LB6hc4yH41+YGN13p8d/jVmNGmfgGnNUK2KnZLjGe
         sVZMB2K7RMdKx5SS29aIScfWa/p2l5oYjW5RCcIvyp2zpWowU8WIK8GqMAJ/n+tSXQR6
         Mx9h/+CoE2QAP4EsjbKdW76KNxNxKvurqbXNAYlGahR8i5VwoKSKn9Twn9FE0oq6exmx
         emPMUeEdAZnae5H9cEvXrhiPdoQ/UIhPyDBoZ/izVYWw+KNaZhR+lY7pfbszDWJBSOXQ
         i09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134752; x=1787739552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNNHoWdgT2CrEfPiTooQfwweAtxpbzmh3UlJhmBHMrM=;
        b=eP53AxUo1RkGe9Ks1yBCmudV790nJ4LSiPPavfqqvwuvChqcZtRFA4GYPk1rGJUgHv
         7aoe1lPDs6ELYBzH4ornm9UWuJvVv930U4OorUvWHwTvQJdyyJ2AiYcvVlDP0PF8gVJJ
         +GoRaK8TuAJ7VLEq7YdkHTrYuvGaCmtOMoSZO8wRE2wVJ/tihCxmZ3Fu1Knt8peVLqdN
         fOuHVjR86txSn9TTBmFxKt3FmQBixgEmo8NEANQC25Svo4VZW9ozat25E3Bq0gORU9rr
         vlNx+Ry6oY7qdHZl0JgoyIbLX6XambTw1/0ofnHwff73b52dPz7nTTeHxwNczjSYRJ/m
         hbNw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/ZQuqsG3c1qWAq/30b9bZwp5lPsBq1XDgWSR64EB033JBREE4oUdo2ETXncT/3zEEsNCHMhBVKg4QQJQ9Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46igsl5mdgiYZat8l5tknmW2i2gSxDAI7Wk3k4I1FrjE2AxSL
	+dsNYbl+J23kArLKyoW6VYv2sDk/xjx4oR8lg0K57xJ7khUs27QgVj2I
X-Gm-Gg: AR+sD11okdEiLWqs4EZdG5M/70dqic3xXeCMl5rf7upBDkL5IhFZJ8BhVavuzMHwC3e
	2gulT69K8LajJF/Dv4d4xqDsL2aIc4z/WgawTpPu3LVZqMJUxP39mYuDWmR/nR92jL9gqUN3fwY
	YJN0egnTtgR9Ayy0DjNXr/T53qURn2abXyYEo+dS/WSqxyoEtvVEs5zw0jdHAKW8CC+w8/YDGB1
	iwfjH4TjUULd8NEqPlBTIaAdCoAtRdYicH2456Lj+O+9JyUPNif0WfPxpIbtLukBiXehES5a7se
	deTam3OkiHVVOpuT9Id3YW2CkUuXEupIsEaQArNO6TIDIt6k3BKTVWJqIQKY3+oXC6KPBSKLKsr
	Q9piwBbtwE1ivo+BSnAmGV2cSTHDf7gfbKs5fPt2Ls+R+VCFUNSNKoXqZSq5si2MM+GU8ndGjzC
	b4zleW7xE66j3pexZc33BOwavCwfh8AviV5XlBXKf08im5XVY4ZqbGOw==
X-Received: by 2002:a05:600c:4e01:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-499aa1d0747mr66690555e9.11.1787134752059;
        Wed, 19 Aug 2026 03:19:12 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:11 -0700 (PDT)
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
Subject: [PATCH v4 2/7] watchdog: mediatek: Add wdt/toprgu resets for mt6589
Date: Wed, 19 Aug 2026 12:16:23 +0200
Message-ID: <20260819101853.44681-3-l.scorcia@gmail.com>
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

According to Android sources, mt6589 has 12 reset bits in the
WDT_SWSYSRST register. Populate toprgu_sw_rst_num to allow toprgu resets
in device trees of the many compatible devices.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 91d110646e16..f8208fb0f723 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/reset/mt2712-resets.h>
+#include <dt-bindings/reset/mediatek,mt6589-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <dt-bindings/reset/mt7986-resets.h>
@@ -88,6 +89,10 @@ static const struct mtk_wdt_data mt2712_data = {
 	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt6589_data = {
+	.toprgu_sw_rst_num = MT6589_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt6735_data = {
 	.toprgu_sw_rst_num = MT6735_TOPRGU_RST_NUM,
 };
@@ -493,7 +498,7 @@ static int mtk_wdt_resume(struct device *dev)
 
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
-	{ .compatible = "mediatek,mt6589-wdt" },
+	{ .compatible = "mediatek,mt6589-wdt", .data = &mt6589_data },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
-- 
2.43.0

