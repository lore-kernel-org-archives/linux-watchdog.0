Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE13FA5FE
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306517; cv=none; b=mwQTGMDj8JwTNxEl5YpmGPRwIrXnRE4wGyCHlYCeW0hpCSn7NMjdpNqwT0AWjOfMQczgmEmu1/svl+7StuAel2GBTFBgr3+3y+zdnaYDbKs3gZH7ibc4ecP5yNR5tige0ZPCZtwiC99MDN6HzDs2FqFYP/JmFg3jZ37v1dWQEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306517; c=relaxed/simple;
	bh=XmNye/vjiULEsxnBNVYOTUkUu6v2VjDCwyqHNObnENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fup9lXK87WvuZ/BbWMy9iFq7Tw8K7M5xZeh1h3iG9BDxoXmjpebqDxTVRmBmok8z4WW4Oc4tiSz4nt7jrt+5jvPvymr0TC/KiPINPO8OjYLmRQqWjIeLbXb+Z0RczFkYC9Q3yPeGmC6ERzt0pU6pQUU+4u1sModDq7AF81lQqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKi1RgHP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKi1RgHP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15e03c2763so401987466b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306514; x=1784911314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=CKi1RgHPACSJ/T/LGVhWmo3WUG8K8tc66yrvmLrWY3YplDbUQSIF5N0/Dia2f+WtLm
         K6NtVkIUOSwXiKLM8MBfgPrL8jWC2QGcCegK0DkbO6lwOdWrel+7mC4JyadrU+DmcLAU
         mDXhYWguzpqhorGde6LbUPO0vExSfwImGmZShkZlV8Y3ziExRJ4b3EoXfGml01EGH1A9
         uhB4t9r6cm80GKHlDByziN1ja4/PGar8Q1hQf7CWEdqF5cvTvi8gXUVYv8H3QYHbseJ7
         bAoyvoupv6FSP3L8/pRvGir/yWOjLfnMzVu4sTOHZqf+UeEqiohHzlk9oi+3vYDndWwQ
         nW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306514; x=1784911314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQl5PVCGH7sIQlsUqjynV5DnMRSCC9HSJ3vmRORytzI=;
        b=nC5RII54h/ocCo7x4F6l3gRObfYEZVEB+c2JdAVR8LEETOjUvDmo72E8PFPkThJGzR
         qJrpCLNzqSLz6cr84i6Excf4HLzyfQOvF2itnSINr6K7Jp/TWRoYEAbFfkhUeS7wxnk3
         L6Enao05T1AbwVMKK7ClEJTcroDtV0/44P+ZuYsdkeBHDTU8Z0q9SgvXmoVtF0UGkPg4
         FaI0sQbM0DF5oZha9RV5EeFcg0zdiBSsf2aWvKgTMl/AOBH5OteqUrI5lLvfvKPsikPf
         HkZQ2PTPRQWBApHAwYdkJN0NDTaS5AS3BxzNs8dgnDH9c98MzcnAYJCLYGDPMShbTazZ
         3a8A==
X-Forwarded-Encrypted: i=1; AHgh+RrK5sazOEQUaan/fbrZ9V0CF7pswey3JkyF6DcCeQM9dJmyzDPX22e5KPutJ3b0woY8jGqitFpFi9VlGD1A3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOsCkNFZ+ujofkfipvO8XvSyEraPZiqa/rl+1NfSI3NV/03Bc
	9mJrZtxg3ZntjJVRusSHLI4qRfAFrfOqlH2yfQXkUZ+OePV5fDE6fRw3
X-Gm-Gg: AfdE7clMZqJF00Z7D4fKlrWbXmXiTullqXMvx1P1yCzLZnGhpyQGEDKMYQn6olCddw6
	0TRCFA1SII3sxVByz6wF0zJDwPluTWT8gXHG8LnSzb3Ukl+ndR7qs5waddkHBUTlXAQFS9G7Vz+
	nzf5Ow9wuxq7YcytfDWDwj0nRLekKdDv+wp1ban/Pv7eDQchKuiTaKiBca45XPrx1LTMOE/qLiD
	LH9k3xBT0fPo9tUrDIydpzyERTnDyeszDAtN+EwH2DmaVv04h4SZq9FJawP5uUoirfmirp8p9Sd
	tq29oQejGtEp7Ex7Ui4kEHbMEj2iV/CZwKubjpjTXV1mfNM808BDdNKPOBrr4Ct2CiTw1XvGbu1
	m+uusN2NJs5OU+h8yB2YONDbuKX/8L9LzqpHaVmvyMwlmJ8z+1siSN3mdFqgDswzdCs6wHEiXuQ
	==
X-Received: by 2002:a17:907:9625:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1692413dd8mr352045966b.25.1784306513979;
        Fri, 17 Jul 2026 09:41:53 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:41:53 -0700 (PDT)
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
Subject: [PATCH v2 2/7] watchdog: mediatek: Add wdt/toprgu resets for MT6589
Date: Fri, 17 Jul 2026 18:39:13 +0200
Message-ID: <20260717163959.714561-3-l.scorcia@gmail.com>
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

