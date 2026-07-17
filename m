Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9902400964
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301305; cv=none; b=iabN6Uad2Undk2dZ/gtqythZGOOkDLWE/hPQm8sG6WHcST4r4GykVrlsDzjoLU3Z88OgahdWg82MJaCKjXS0xgkTTJYbzZW3ei2BTaQ9XoxRojNyIZn5VoklC1cQFXL3uzi7GK8Ke/x2pEeQ7dfruRO2E5SJDdkBlwDMYhp55AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301305; c=relaxed/simple;
	bh=XmNye/vjiULEsxnBNVYOTUkUu6v2VjDCwyqHNObnENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUwuFZwVc/2Ys+pWjSK6BqSm0pFhkdIISrZIgVmfag6zMydoc4maMxVsj4EJdXKEBHUHoTw5Hr8Li4MnRpwyWz+rDJwz02ZEf7KR9VhdAs6NkVqxwyEXS/NyYCuUbySUPg85GX9Kj9p9B36Ks10jAgxgB3Q9kqU3UFIeD/h0u+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yop5ldWv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yop5ldWv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so13118251a12.2
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301302; x=1784906102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=Yop5ldWvdhq+ld2CrvuOGsxRch+rhHHbIYmp+Isf+U218VII7jeTwhReyhEkvQHcsS
         2Bsm2YRhs8bd3wU015Jg8RqR7b6winDsD13gO6tOtmwVvkk6BJuqOyxVqMhSdHEM+Q7y
         dfnoIES9UllB3kJoxrliWguT/aghWPQ8SfdvvFXwwWjvdekdqvegkdXvSiDpiPAvYelb
         ahjUGhtEhYrvE1qewUSMLuFrOX7GH9dP5vEncXK+LGOWSNomNkwACavNlB/fFI93we6T
         vKSv3/fJLOCX94wbbDuQ7P2o3Ec0G8Qup/la3BnXw5P834+lwOyf/xXA8g9XZYlFQygT
         M1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301302; x=1784906102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=sHAHkGwUQBfP+yDt7V0bbzSZ3oa4NTFNd2t1M2CVH1NyP4sKcORgJCcqCcvUdX3iXc
         Ebi6fvr85jebulPmRAA6LwZEIvn1CnHcK2pbmHBUk3+nd4/OLBmUvrOt59J3gUY8ECUA
         TTAQUDnfiXB3DuBiCzfAuHh0+RemjhOw2rXqY2HXl2ZLItXiog3/GFGqvvd7QZyCnZRG
         IyUKan0pG0mgStVRuibYVQjjsHSkJ6tiAX2u/+6TceM9LotOT8RZPB1Iu5rzLeqJrAUm
         J1eGEMeQ6XjIKV2YpJX/1OpJVm42UkM6Ck3kiXuzXawnnUzNjemZzMTpLETebE3EqGfO
         DLSg==
X-Forwarded-Encrypted: i=1; AHgh+RqThRBRhZjcvHKCaexdzjQqmK6siUzyvCiLvKfwXla8mU159GXFmMQWsOzHQB/BrCNGx5bOWiZBr5RTBvrFzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZ0dzInYdADwTOxVIgStWYnovGB+82DQlaQIwicNAX+GTPGM9
	hLdxZmOgbnQDOvrL4wv1TzVPD9pgUfscccONTJtlxMJrX20482yen0sN
X-Gm-Gg: AfdE7cmi8gt70n57ryuJrhbOFL2APyavCd4yLxUy5IXWvzh25acMaE0hSEjJ5lj6cgr
	4aGOd7xxdsJqRM6uEXvRcThYxI0QuCtwUB/0Y/rqkyUTJN/U5lmwmb+PlJFPpJ4IywGeFcpJ6fv
	5SM3OcHfzayTM3+MACUr9e5d/n7Pq/lIAp4Imo9C4ZLHZMH9vLviSG3VGRUPTkh8VSRkM9iuz0V
	dG9bffazdxvvlQi/BR7QxcwMZCJCWUbejGH3ERIcAed+PjXjtf/wYzupH4pJWLsXNH4c9dHTyPN
	lCiagIE52ps2Ri63LoJVjF9fYKTpv7BDwYLyOx3vl1KHP+fQr2QRE9jigq/OssGn+P6z6CWzbJK
	ISGjcfBzP2PPNjvbPN6Zztt15U/rywV5uGiWt5Y3aBs8cxy+WzMDFG5z8FhBaj2a3Llr2qKDKYw
	==
X-Received: by 2002:a05:6402:504f:b0:698:e614:e4bf with SMTP id 4fb4d7f45d1cf-69e6516b4abmr1042998a12.0.1784301301694;
        Fri, 17 Jul 2026 08:15:01 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:01 -0700 (PDT)
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
Subject: [PATCH 2/7] watchdog: mediatek: Add wdt/toprgu resets for MT6589
Date: Fri, 17 Jul 2026 17:11:09 +0200
Message-ID: <20260717151134.678839-3-l.scorcia@gmail.com>
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

