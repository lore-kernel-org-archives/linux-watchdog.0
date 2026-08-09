Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA223D7A0C
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291640; cv=none; b=LIYMNz0aORc6v5AsdhdgKtUSf+xX4DySoESp2eom1J1o0iSIOE+kH7OIPf8jaIvMSqqgAbwx9f4ol4CqU2MFsEy0s0WYokHb5iQ+jbS9RwH5RmAqu0leQKB1GvO4W54USmwUivuBK6mDvy8jL6dFLDBUfzEl20taPmsJEeWUtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291640; c=relaxed/simple;
	bh=Wl8PbtVcbqcYg36RIsWzXPaNK7DI0KcYAEDi+vEV6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aevOfx2xFnRa7h268S9EvsaQRvjpsUTUzntGp1ivptccMi7XHuPvYsVIw4BJJlfAeMhHXWmoWzVUkcV1+CfUu1Q4TabGGLJDcIncAshyYFEdec3b5XPPeF1R1dAxJT1OHZYlL3rjfQVQWofCrCAqQNytnNnSD0WQzIRs6Dm7SOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ6HluZ1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ6HluZ1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so19579405e9.1
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291637; x=1786896437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=YZ6HluZ17KVFCWkNF/Fyg2QabdLRzNa5PqqczToI8JdwcrTmWLoS+wreld4dABiI0T
         7eqccKbFmheyH8/9esxlNBO5jOvyrE7dZNHhq/nZdIGiHUs0jjkiQMCxL5o7rfyuGAc3
         SRbaWY9pH/L8hMHjzbE0mJ/wsPC4hi/XNUT3JwcvGvxPfljyWb1FTHoDszK5/Ukx8i0C
         d0Rs0i6Ray1Hq06Da5PLGc+M/eaHMS6VDsfKL/a6mf0+eii4uWTu/Qo7a5oyA+mogM+r
         EWGk6ttIXuX3d7hUEVjyGwoyRmgJwZvR5nka/I11dElhK7Yc1fr/FusKLHWhrpM2Ih3L
         jBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291637; x=1786896437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=hiKPf8flGQER1hpurYcIRnjDx9RchNsdhpFQVCVzXR4yGG/8eW02ZSzYqLTA/SM8ve
         xZVruLymNICMbOwZiGYDQBcQPh4/W5CK+eFJnbi+LFFJqc3uG9/YxRw699xz9CX41a15
         ZU+Gk6SdvBbMQzaS+VsA6T5Sw7PdDEHuQRLLFEQlVLBKwI1r65N209wQmj3UHK3G19hO
         rsazpam2nK4i/s+1vekdQnjDTvwenKlOjIOVYte0G1QN2sIu2/nvM5r3a4gF8CzOTp2f
         B35PvdaliwUM8fiPEHwrAMBSpoYoznqx7k8j1CxJW1/ndJT/pwottJlVGDSdr598LgpP
         SzYA==
X-Forwarded-Encrypted: i=1; AHgh+RqTPJ/byVFbOlBCWCQPH2M57tXBGAm2xdYVTrM497My604b39jNX+dfjk9cWdK9Ky0WtG0TuRA2rr09PT2j8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/Db5GrILpyvqgRxQVBXTUR2XLbrq1tDYzEwBuPxpxY3CvUra
	rp4Wrm2mfvooyDJvRmTHm0IWKzFCC8M8LNZ1djjrS65ZMp2VeykkqGYC
X-Gm-Gg: AR+sD12MuLKNpHfLBpSZMVsGObhr/2mxwjN3i0cdj8MVX9i5/IoyLyUF9/EYh7nxySn
	H0SMzW0wwIv/Uk2CaEjcVx66ms5s9Az9J/SgKetvy5FSlUP3sesSlmB8REP5W5dpo8zsIuDGWDr
	E/kiW17rB6mToUAA+ly9jx1BpxQ/ctODMZ6VHIOJuL57sggS0XDYtCxErga68T6spM5ocVPCErS
	hiTqFjnKGEX0wL8VlHkn+oOWnRmpdTl+F17GoJXQicA2bULUS1XMonaBwkhZGQKHREzUtS8OItw
	lIiPCpoyogPVmjogWHcYE1wMoL9elDQFVHlLUVhGbzAuECCYZ0QXrMSSrsK8AHQKOrYHI4dTf3u
	Kx/F3r37G9vWdkAkGntqMPwor2aTSNgJuAcc3DjeiLMJdp0z1bdt7i0dVGrbrN4WNxvFE4vXCsU
	QlqHe4fuWeGEB6JVvFAbbjl7VRGGegoeb+EDHGGy1X+O/qicuJcrwxEA==
X-Received: by 2002:a05:600c:c87:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49962472d69mr121132385e9.6.1786291636950;
        Sun, 09 Aug 2026 09:07:16 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:16 -0700 (PDT)
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
Subject: [PATCH v3 6/8] watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
Date: Sun,  9 Aug 2026 18:03:30 +0200
Message-ID: <20260809160643.33991-7-l.scorcia@gmail.com>
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

