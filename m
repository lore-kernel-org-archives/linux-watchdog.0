Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8823D47DA
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291630; cv=none; b=On1B4Dw3NXkiGOaRnBV6oBnBskR1C15RZxxrOTie2eAXr0j28qh6xC1Kgpb5rArwBJ31alHQvb54TeUiwWNm9pcqJOGU5CaOh3ifgHScF6myqK+ESwV1qh3zS/Mw2du/OjXFDnyIeCn49XZh2FUcqwW19BVHY8YBYkSNaRVE6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291630; c=relaxed/simple;
	bh=XmNye/vjiULEsxnBNVYOTUkUu6v2VjDCwyqHNObnENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3aVe/PgF8eaECv4qYKX3uHJIUIATZvh544fa7KE0/nO45ukxCIVaeiUUvZdbDzJkY/rGnSROUzfF8F1n7U9K5Lb5bHMZT8TTu2f0Ro35QZatStGaA/c+aNUujfUZohQeLJkUN6Rq8xY6hhbbP6TAV5AhfUxy1yi2mjT2Yr6Mtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEam4mkG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEam4mkG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954afac04bso11871025e9.0
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291627; x=1786896427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=rEam4mkGRWTaJ9BGTKs4XcrW6gcA4/kFhMfky+DCdgJPjvkzQUhq1goPwz+hvwXuYK
         7MD3FePlFX8mh9HoL1FZUKsEeCVIOXLHVDdzHRVao7IL/M0odWTrbUXmw9qJ2jGWbq+u
         SfuyzYXGmIz+fZEP4sMgVtEUgd4qmdOOC/HiScudcS529VgOmY483YU9MaQ22fuF20fI
         TCC2Bki96lXfR3HfrMCNK5Xzf+r34YsY08dO40mpigOPd9i6nJK37PkvmYt593pEmY6X
         jBknLQRSX874/Aqx95l74MrYkbXz7ldaboXcUPrOLAqvRCAHYQl3IYLmt+EDQ7HsGu82
         rwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291627; x=1786896427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=le9z+OsW8Rkm2RprSgZhCq4ryq/xVvEwRDxDXxqe55+7V9vdobKZayoNd/DWpfvjSw
         HI9BOYEwcW4XyBl+/vfNEMgKiQlfE7ojJp0TJBe8db6A56jo7PDa7mpPVXv7SkegbqXG
         DdHWT1acnJtI0BECmxu8go2nzUeEkeCTd3ir905WHo6UVQ4Mm2z+y4qDWdqBQCpNTUme
         IVFUp+NAf202LXOTwgXSGLX/I7PNkexqarCnyv6QLbOL/AqFUW5vam68dQEXx8EYJQjc
         nQaF29MisobsbbL74YvteADH+JFLnxY2TOAGNtcFvIOF97Hf04qpVgLxEYW9twgg7Pzz
         EMeg==
X-Forwarded-Encrypted: i=1; AHgh+RoA+9NLHyc/0zVsMC7qsoa+BUj1eU6W0IOG0jUVpdZnu1s5LXAlTpQ4a7SkG3ZVLr5v11o7xgage2Uv5tlNrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5v38+DtXcg1P8zOgCkvVV9Pc6IgnkZVJTfUUjFiJgNM7xwZh
	rwBCSoYkoGVfR3PylshWL1ovJl8BORQrFWJOdSWKFeEESOwvUD+JOVl5
X-Gm-Gg: AR+sD11H7sByTfYTapUXs70pFZ3OT4gc04G/3VomR3FFxLhgXkPuB5vuq6ewsjm3H1f
	UJ9qNW8jACrK8OibnrLJBPpYmY2U6B4bBYqp0yGACNuwkKS/F1w/ZtrCuZKOxJ38enBs96fyBuc
	f8reK35kXz0DG1wOFgt81ZSdfracut31UixX6O/ie3iT8eXBeCEhuDIqXcAAvJ0CGjaDr/jhlC5
	btS1FlWxw+c15h1qaMBZeTwzaHJ4jmd1qQTvdTBb2gUH9pIefuxv+LV2M5hKHskyqSf8BNKsdUu
	Fmx4UfdhV9jJmD8aMgdk+quXnxOGCb0vSFcSOd9MvOuFfHU/PGXpmGkYs1H9d3KvvUbdItzHEDs
	kCcJBJMFbZ3KmHG4UDq7p585U0G/NwpTZ/YvXo/pHw0/KdyPcm9JtmDUGs/VLS11QfhCgwXN8tK
	c7tubfzcYwFToGdHf5tcqxQ6b3rJbtYhzOHIrHR0t7wyil9Yk+wzXh4A==
X-Received: by 2002:a05:600c:3b88:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4996194e24bmr211098485e9.1.1786291627278;
        Sun, 09 Aug 2026 09:07:07 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:06 -0700 (PDT)
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
Subject: [PATCH v3 2/8] watchdog: mediatek: Add wdt/toprgu resets for MT6589
Date: Sun,  9 Aug 2026 18:03:26 +0200
Message-ID: <20260809160643.33991-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809160643.33991-1-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Android sources, MT6589 has 12 reset bits in the
WDT_SWSYSRST register. Populate toprgu_sw_rst_num to allow toprgu resets
in device trees of the many compatible devices.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 91d110646e16..e61f6ae74327 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/reset/mt2712-resets.h>
+#include <dt-bindings/reset/mediatek,mt6589-resets.h>
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

