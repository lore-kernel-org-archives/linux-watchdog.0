Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120142A7A0
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301313; cv=none; b=Ibhhkcq0CJ9MfFQmz76OoKRbH86PxK1UpX75CTKWoi/0wUQG6DX5bCehnERQZsEVSMdAi+3KbqRgx/X+K7Yl/tFkjsttvoyyDkrK7rYnuC4vuKCnT7bQJle3ycCrtwxxsPXBfVM7Hq6SD3Yr4YUxpg8TsWU8bkqqOc72/mwqgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301313; c=relaxed/simple;
	bh=Wl8PbtVcbqcYg36RIsWzXPaNK7DI0KcYAEDi+vEV6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXdNKkOwelU2SVJ9fhrmzFB4UoQSI0bO3WNpowRI2L+YlaeWZzMToiydicPkRNel5eI48Rby802/9ZkDQzRYV085Vm+e8OzU5cKA3UPUdjT3f+tY6Y8iFDvsgxNFKMSG6NQpnTr6wlCgf3Wcec1513WhrHHRivyU5j2GB1+MfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOwsA+yE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOwsA+yE"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c5eb6dfd3so11195633a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301311; x=1784906111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=LOwsA+yEuMc4IkKFn/AYQpN4WVxmUpyxRWcBc5sWNzOcHBHRdnTh5o3WQOTx/3uNQ1
         gyJe9lc8AzLfRiLG/gr6G1C7VWpKaAU4E2lcBpFP+VVT+iBAewBx5mhZyymTh2HSaNOX
         9kePbG7SFSrUyNtAoykFvz4Yzlmy6xfztgysM6sLlql/6/eCuhxiRnw5G5N8dVpe2Cqg
         sQkIqgUhzyemienC1xebu57T4809dcRXxzfgZVWzkv2uwFqwM3Oc6yGUSSJNxTPc7Be7
         zofY5pQwK28kTBrcibosYQ3xNWVMk2TdvVE11bHsnmYBE3BexKX9+WSRP53RIsZoWbPV
         paVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301311; x=1784906111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=cKJNcTGtYWagqbP5lnk9vZ40qXd/bO+Zw/MMgYM5MJJjfqB0CcqFNPEAQd9RsEvmY9
         coT7lyrz/CapsiXP5hmO185airt0PgrmsyL7ajKVeOJlnho8AaQwVEXcVcWi/b+rpvzd
         EzGuE8cyYLynhXVIUAU/cLNd+k6IOPboHehKumVdcv7SaqsE+We/x7sfCTnSXuWo5E60
         CLY1Gw30zY9kL6RG+jY42sALuAhq7AW8DF9K6/HB0ek8lHOVGW5C4XcVUSwqw6QF3f4z
         eL3DzgoAUfcWzEOHbYqZQ8NM07qGZU/96f32RS8/c9htZZeDEsMSQveZr6XCt1NIA/KP
         bb/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrBo+9UcATFLp+YdrKLKhZkRM8BcleHlxpk4BkqCP+wPCFfBRksnRYgZnGeDarjvSn1hWKnG5vGi5O6jzrwCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIo4VqtgkvfUP7Nwl7LEML1u+l/yU/DCaYa/ye3Ulses/zMj8
	dqQ4GHeVwTJehFuqxVIYbLlWAxFAvJxpiUqvg7G1KBQUqR7/hheJDkHN
X-Gm-Gg: AfdE7cmb1H1vcJP+6YyYjwS1KClQneMBPVFVBKxeNo8dd2RdGcEzcbsWMM/rfIX2VEL
	mi+XP4hOHgHgug5qb6k1ctSBijESo4PEkgxTDlEmbr2yHl1Zq/4CxsgQZ6BioiQNXSGkLD2I92w
	Bh/z+mCnLOukM8IAlN5o0IbUdeKB1iPBK8+G2XnghtJDcr8oP/H88Zj3u3iXjsKF2UlkFO44xYI
	CgMBfXW0zK2SDrnI1Hfh2GHxMBGfYu+fyqtkmzAF+uqokKBqgyW3p/AKdntl44MiCcmZUtDctXl
	pN1Ahq3jjS5ZgZXd14DosN2qeRgjVy+FceLWGGUQQBAarzj6hClJFP4JTh/TLAA9uwDHNsZ2wfD
	jIkUrzvoUn0dLSfztRyDVpEfmp7M9/zIcom76ZKUDT+WcpKHppW3cWRwKfbnj5+l8Q4eGx3fhvQ
	==
X-Received: by 2002:a05:6402:528e:b0:69c:7406:9492 with SMTP id 4fb4d7f45d1cf-69e652e1111mr1154154a12.39.1784301310590;
        Fri, 17 Jul 2026 08:15:10 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:10 -0700 (PDT)
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
Subject: [PATCH 5/7] watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
Date: Fri, 17 Jul 2026 17:11:12 +0200
Message-ID: <20260717151134.678839-6-l.scorcia@gmail.com>
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

Add support for the Top Reset Generation Unit/Watchdog Timer found on
mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index e61f6ae74327..10a3d4b5ee30 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/mediatek,mt6589-resets.h>
 #include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
+#include <dt-bindings/reset/mediatek,mt8167-resets.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
 #include <dt-bindings/reset/mt8186-resets.h>
@@ -110,6 +111,10 @@ static const struct mtk_wdt_data mt7988_data = {
 	.has_swsysrst_en = true,
 };
 
+static const struct mtk_wdt_data mt8167_data = {
+	.toprgu_sw_rst_num = MT8167_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt8183_data = {
 	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
 };
@@ -503,6 +508,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
+	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
-- 
2.43.0

