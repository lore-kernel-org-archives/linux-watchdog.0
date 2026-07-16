Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669639E18E
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218799; cv=none; b=pku6zMMNqbBzApqr1EIsV4eU4gexj47sGRabRtPq//kwVVRzJpG8mMit7qRkpFysTZKSnQaliAtwOTkymBFUR6bjKBOP7mL5d5x8LnGcHnURh5SHQVEolHkdAMH/xXeBSuMWpfZ6MeS110eRGRZfMvOX3/IsH9jzgYe+wSCp1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218799; c=relaxed/simple;
	bh=tLw+0y+B9O3GnoE6d2XmPzPWeMAXQz//depzg3ARTl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU3ixTRMnKqPOWIMMbSm7FGDeCpdUORbyzjxSVRt4NTyEYUCkCR0gGLgdcbslrbXfNYf4s18JdaiaJGEnw01IQd+XJtKWYndJGut8Edvi9srWQOFFqQZHd/thOFux6vdufB1Xa+AQ23NBwPUXE+7eNHTnnp8q9hI1E2O+tL+bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fogiWtDN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogiWtDN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2dcede83so4840849b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218788; x=1784823588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XSWaTM1tBQVfHgrp4sw1lVesZlq79impBsPYXVNYsQ=;
        b=fogiWtDNOousPac/OyveUgsmm87+0mTnjpxOKhzls4ZKlYUZlOU/EP0nkBCLgkOOR3
         +mW5I4uQGbmXp6oTKkTaKlW8DdWARdsm1V4XqruDWOm5S4LsBPRYnQZI5jrCD/I2FK6B
         31BhHwiQFysK/xWwXpZpPOQDHgHgPyal7hkEd3jldX5APFpgEz41KS7w8PUUBXLgbpag
         K+439QSF0VLbzeRIe2rxM/DPpYLbQxtltHr1ST0CmzRJbP/lyNkf1w6hPPshHsTmDIyN
         GMRCYldw/oCX+QD34bvIfVD9D2qEjk/PCiysq+khRDxkXWVtiYFS1v5q9pHzJSivorev
         0DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218788; x=1784823588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XSWaTM1tBQVfHgrp4sw1lVesZlq79impBsPYXVNYsQ=;
        b=gdV+PREvQnapEmHMeC4MS83Cj0e5OVWgs22dABXXCMPWwjdzc6Uo0A2u0kf9NXxxy0
         +vSoXdTpWSSaQfGvUe4SbKVmCRVQNSJ7adZEZAHZES/oqJJV6Gyiy7BzLsNW8RAYalEm
         zD8U6FxoUbUM59v872EasDFujdJJkk/NkMX05na0SnGeZZQTAD6ehBa8eAHLN6uugUw/
         IhlF1wLfyJriCA/Zo9iiVZ7Dx23wiX9RyQiHuxdu/KW2AmBgDX4t0p8hdvTFAiQ3Z2u5
         L8Une2J3HgkyG2ZpC5pprEZwg20QWUI0wVUVpeLuiI2L1eR+qkaJ9OXZq1tvufXe7Amz
         qHww==
X-Gm-Message-State: AOJu0Yy5pSapyOxif2tl26Pc+LqFMU1YWxMRyK8CSDv7GC9likhd0T4V
	RBsLdG0won0CNtRlUUKy1S00ClOkR9OIgfZn+fEC/g17+OtzleCAM1rF
X-Gm-Gg: AfdE7clIyzH/Fz7VcmvJ5h4UodW6WqF8pTE6v/6S2rPJ3csb8353m5YXR9r7bKpgZKK
	0n5BQcTcN1a2YW10Y2RSpe23Tr/sDnd3u9UmF3WWYjrFzYaP8+QNLcVVziEZ4IE/P2ypCGc+Muw
	84bSLIi4pClcOYdciVCuxIMawKwcGC3Ptc3bWPK1N+xYPzVaqPMDhc3JK7n6mDetKKeFOdaqAT4
	K7652u7X+z8Cf2n+u6Gz3vAUrTZlN37waeBDbE5vMPy2qUlB+MsD7nVKkssADciexJtiEVpmiAf
	r/GDCiVYfu6184dHavHr1V17D0vaXbLgKnlKMqoFJ8aU7kd7fBRyN1VD3kHvXrOxEKPGJfKPnB5
	SFYzv9o6TkEcedBb/+jMzgb4hM8v95CwZjNFeWfbQ0n/xlxNxXOxcOBU9wkX7w8zEs7TKp+ygtp
	TP1swHa9JeOiCPJvZWR7KSd1KFYZLBzpicQg==
X-Received: by 2002:a05:6a00:9504:b0:848:6895:b754 with SMTP id d2e1a72fcca58-84889643b57mr24897638b3a.28.1784218787589;
        Thu, 16 Jul 2026 09:19:47 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:19:47 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Roman Vivchar <rva333@protonmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH 1/7] watchdog: mtk_wdt: add explicit compatibles for SoCs using mt6589 fallback
Date: Fri, 17 Jul 2026 01:19:17 +0900
Message-ID: <20260716161923.266315-2-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several SoCs currently rely on matching "mediatek,mt6589-wdt" via the
fallback compatible. Add dedicated of_device_id entries for each of
them so that the driver can match directly on the SoC-specific string.

This is a prerequisite for DTS to safely drop the fallback string.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 91d110646e16..345d2e89f414 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -492,17 +492,28 @@ static int mtk_wdt_resume(struct device *dev)
 }
 
 static const struct of_device_id mtk_wdt_dt_ids[] = {
+	{ .compatible = "mediatek,mt2701-wdt" },
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
+	{ .compatible = "mediatek,mt6572-wdt" },
+	{ .compatible = "mediatek,mt6582-wdt" },
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
+	{ .compatible = "mediatek,mt6797-wdt" },
+	{ .compatible = "mediatek,mt7622-wdt" },
+	{ .compatible = "mediatek,mt7623-wdt" },
+	{ .compatible = "mediatek,mt7629-wdt" },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
+	{ .compatible = "mediatek,mt8173-wdt" },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
+	{ .compatible = "mediatek,mt8189-wdt" },
 	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
 	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
+	{ .compatible = "mediatek,mt8365-wdt" },
+	{ .compatible = "mediatek,mt8516-wdt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
-- 
2.54.0

