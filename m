Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F482427A04
	for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421264; cv=none; b=I/vWXi++gs8UIGqox8xcwqGAheu2o+xDvCBSQfHe/PJV/MFLx03fUuSLNm7+zUmLfQ9KtTTY+3tuUEhXOple13JB6+TBdGIvCk3521JQ1v8NNu2oQyHKJaDN1izE+QHJ/F9EgFbrNX7Klzs2Ngm4opAQlIlv8HYuuCJhQms968M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421264; c=relaxed/simple;
	bh=C5rGdOL88GwpoqL/WkLQBcwq5Sk60a555stIbwUZWMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTvGsmSqsnwWiaJEGtMFquj4PvPzy3clOtEUw5IzCgAwGMxUh0e8d6gISDRr4Wb5yOZzxBfNqD4goHMxiSp9KQryyjEeYW24Il5yYTod6rNvNtluIEdrd24OOUcgnLZDmOqV2l+/UmlDWkTeIEpFkkEFUo9vF5f7py5SlmhaI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccNczrtC; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccNczrtC"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso769375ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 26 Sep 2026 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421263; x=1791026063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQIwLtwiv2GNar8YmdrUtxZP0jcj02NoHt6505OGaXA=;
        b=ccNczrtCgmPPSX3XXUWWBBmK+W3WLko1l1fmbu2zXAoQsC67eKIS7NQAIP3RAa5hm1
         0+jdhEGpLZ+96P3qNJojV3m/5w654rFBgJf9QdGgF4zT3kDC8TnLbFIN7tpxtyqNulVw
         kw3kFw9/e/CtngzbsO1m+djVZC9dTWNA/JDKwo4rAfsMdCWtpdM2A78OVa7Xh39QO19V
         f9sZy4o0MRN4vSDhDqWDCHUYq1yhM5MlA31Xg4GFrb4G6iIh2tfZkjuEgtE612fdcCEc
         ZjXig5oOU+tb7uDUImR19M8mb+1tC+bgH0zryDISOyjNdFjASrKJ1YDBPcy7vxe5V6DV
         D7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421263; x=1791026063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQIwLtwiv2GNar8YmdrUtxZP0jcj02NoHt6505OGaXA=;
        b=emCKpc8hdZf7K3d7HZYH1tLegtRRf2vdfIFeUoqKwd4cHkX+4VuELBLbAwQEJhQxDk
         6KPOjnaG3w7FbGSjssjQOsqjLOWHkm2Ys1WTag7jDfpFuEoX6RYX6EANCFRuhvvSBWcE
         v08d4zKJLURUDHIoxdgtsu/gbVaTdx1NdA/DSAp8E2D2pzri2JWMetASBhUls1+jR7rZ
         CaXT5HfFwxgIEMWw+XwVpGrLtXlUhYiwQKV5X5J0yjoHUdE9xwVq8Ik5zWzIsLDRYC4W
         osHSZFhLorxxhnVY9RzDL0Ud5By2L/zcJlFBfMA7QgwDPf6m7ZhHRk0V4t6rCY4BTFpp
         OK5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxL+yb4SMy2JOM7jMyVYhuqu6zFEj/R0HKpSoUqlqhQMueqqm4IkenOp+AS74bish3wDKN2LGrvjEU+EJWfrA==@vger.kernel.org
X-Gm-Message-State: AFuF++kF4FoiAMsAate4ilcAKjfay1f9uxaSTrd0NzHM+orojBswuLPA
	CNJSdg05lO/gmAZc+QhlOCtovdSTALuUwMgq1NpEQaWCnqIUqPzfSWjS
X-Gm-Gg: AYBFou084fQpkiqnAhfvzfppTBaqkr+WB+Ur0PWcB3GBQAAC5sgealFQ7k+LxLwi+v8
	UaHfmEfByfz5sCvsmqo+VqsVGrtfFSYQDDPxIijceaf+4u7O6iU3L/7G45tnXImVwrxyMpUl7V7
	vzOy22tnYl58cQsVcdgf5ZA6ZPDOZ2WltjNGwY0YO1QfwLaD2Wm2/Y8GJw8g0zNyMJESx8GFYsy
	C8VDNKUI7O9Qm3qytdQlZOjpIitphItFjwNAaERMcLkmdH2CU556oWIhqptHXSiQOWdtq+wHtZb
	BJCbHAQaj+h8j/EzM+OnjTfBZTDnl/+8O0gAYkKhMkaX58aZ1NRKMz135mu2FCiKkLfXz4lbmJm
	vTrXGvdYaFP6lj57H/tAEGxhrmNshqFNTs6/UUB4qhmwHsUfWpoMzSN1RlOH4ACd+EKZxDXv7xP
	sVCp9+6L5Lg36ZC4qcjqXVRJ7LtePtEqJbnT0vVuSwaHlakMM2HUG5MHXkCHtPEqjxbHtsbJo3W
	J/hgcSwWmBessUkiKMR
X-Received: by 2002:a17:903:906:b0:2df:8382:9181 with SMTP id d9443c01a7336-2df838294f7mr66998555ad.14.1790421262728;
        Sat, 26 Sep 2026 04:14:22 -0700 (PDT)
Received: from localhost.localdomain ([104.28.254.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa60bfb1csm7247365ad.48.2026.09.26.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:14:22 -0700 (PDT)
From: Chuanhong Guo <gch981213@gmail.com>
Date: Sat, 26 Sep 2026 19:14:00 +0800
Subject: [PATCH 2/3] watchdog: mediatek: add MT7629 reset controller
 support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-b4-mt7629-toprgu-v1-2-c124bf9ac273@gmail.com>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
X-Mailer: b4 0.14.3

MT7629 currently matches the MT6589 fallback, which exposes reset IDs
0 through 11. The MT7629 CONN_MCU reset is at bit 12 of the SWSYSRST
register and cannot be requested through this fallback.

Add MT7629 match data with 13 reset IDs to cover the CONN_MCU reset.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 1b95392c0f78..ad5f8fee0abc 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -69,6 +69,7 @@
 #define DRV_VERSION		"1.0"
 
 #define MT6589_TOPRGU_SW_RST_NUM	12
+#define MT7629_TOPRGU_SW_RST_NUM	13
 #define MT7988_TOPRGU_SW_RST_NUM	24
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -108,6 +109,10 @@ static const struct mtk_wdt_data mt6795_data = {
 	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt7629_data = {
+	.toprgu_sw_rst_num = MT7629_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt7986_data = {
 	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
 };
@@ -590,6 +595,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt", .data = &mt6589_data },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
+	{ .compatible = "mediatek,mt7629-wdt", .data = &mt7629_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
 	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },

-- 
2.55.0

