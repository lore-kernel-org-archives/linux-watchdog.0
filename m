Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADC3812EA
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218804; cv=none; b=aZz1v8AxEa2mfUbimvvLXjCO+hP+/hIlSPH6NN5CmWJqugTMsmjC5QFoPpjbGEo4fuMrTWp0C9owhEBQ0gJtaVFs0Cy3DhmnCTFD0kjnIyB2OLprQbYiqIHRFNYn1zBRT0ghrxi3IiLGNYf8a1NWG1LRcsYhP7aK8NR4mGkHM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218804; c=relaxed/simple;
	bh=n9kNRyaRLW6qazOq++7deREiI3P8wgaDeM/WQyENGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn54IPE6MrMCxomAyynF9Lwwj4pqJdal15U8JqLl2Zaj/sv0uMDogigGknWnKD2hIcykU8kp4hI7drujM5oa2lL8O5wDqjQ6xPBgIIYnzK/WZT9z1MycwWP9ocpHWG0p/Ge30lpkqQyZGvsl8/lMPWEEMuzgnC+vjMB8gZDse3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtoeLUIK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtoeLUIK"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84864086bfeso7281807b3a.1
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218795; x=1784823595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbVIpIkuseKM9YQeH51Wa+r2dL8obTD2M1N0wW92ZT0=;
        b=ZtoeLUIKXJQ8FvcGxBHyLf8xZAMe0N/U8W+c6k7WtKjmZe06AcKzo292/5wyytu5kd
         7X1FHdCZky/iZkgQUN/ap9wqVYdEZ2P6GjbnHmAMfUXNORfHFT16yQjc6Th0X4wuusZs
         ueNfepCwturt+fSvRchzabXAZyllcIHgeMV+S6NumexncP32E/Woa5Yrj8EN0CIgYLXX
         qHH1Yxqmuv4Fhwt5BpxnBceaNEP2ITlWPJ1p7JKL0vu6AiMVjLo0i/zpuMvDeMvfvLah
         rEqkmhQv6Td4jSJmLaEmLTXuKAPxPM6KROorGTTSuU/Fm4Up4YYDTgXaUDuYeu4pnncl
         ZzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218795; x=1784823595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DbVIpIkuseKM9YQeH51Wa+r2dL8obTD2M1N0wW92ZT0=;
        b=c5AC30BlVacuPFel6kB1oUVc6NP5LyfF+kBNP/C9jbL9Gt5sR9cih8i2xUP208SyKK
         oAwCV75pyD09os2YV/FanYgbsBQBpA7RYv35USOhhiUH0N2S6NDly/DqquVc+n3/PHDN
         B+NqkW9mZL8lrhTttqMKiwv4Prb8RLA0d2Z628jIp1vlbo4ekjJRcVUtkZJHg0xk1ADP
         9Ec8PDNSxHU7m4oOn5gzxjtKO4ooccblzfpwge01SczvEOlVBq3suOzqc3rzoCbhkXdP
         fVxox2FcapqgtDgXwM8iBPZYA/SzSwuRSWAfvWk3c03n5BpxhrTax80zpf6Utr5HitK7
         O/KA==
X-Gm-Message-State: AOJu0YxbPP+p9zsFVQ7EX9urMzZZHXkxZgevNuDdPUrlvvo2klUuE6Fv
	YnrcC5cdWYPUtAgNVqpYftz0Odp9NJVnn+JT3ScUVG1XqI3YVF4Mj17m
X-Gm-Gg: AfdE7cls+5ilSydlcvikhN0SdD7eX8fBmxFX7M5VLfqGQFcgkmnYoJzE5NimQ6p1plw
	vA6xbezT1hqzaIFMZnSdnuQcCt2nEYBDyH3FCwRFpBYe6dJZhMOhkqMfVYTTZZ2QkLYawzD+whH
	8JQfOQR+P2oKWe3GvtTEnyRqd77N2euMScaICIyTFABA4MVcpP0qRswnpD5fLV8Q2Rprs90PJ7O
	a689pSFWBc3SI54kWeN1HicJm97th8B5nq3nRDRA9FmIH11eeGGionpSAEs4mFkX4/84TeMbKUC
	B1wmJw6sBy4arG11VzSgGhvOqu83/q04ZmUdNZxNVsSxIeueZLcn3p1yIMx+hKVD1ixx2Rjstuv
	KJHxXKjNSuOYNo0hcU8cZd1hTCHczhn/dXEA1JuQCRbpJzHLEVjF2NSiLWM5hY4zn8mI8L4Aoiu
	ww4ZzMTme7IwfOg9ghXCl6fuDnWtilHedU0g==
X-Received: by 2002:a05:6a00:22c8:b0:848:2f84:733 with SMTP id d2e1a72fcca58-84a559dd085mr10999832b3a.70.1784218794877;
        Thu, 16 Jul 2026 09:19:54 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:19:54 -0700 (PDT)
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
Subject: [PATCH 4/7] dt-bindings: watchdog: mediatek,mtk-wdt: remove mt6589 fallback items
Date: Fri, 17 Jul 2026 01:19:20 +0900
Message-ID: <20260716161923.266315-5-akkun11.open@gmail.com>
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

All DTS have been converted to standalone compatibles.
Remove the items block that allowed the "mediatek,mt6589-wdt" fallback,
keeping only the flat enum.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml       | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f4eaa5f7c5bc..2411c02f1cb0 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -42,21 +42,6 @@ properties:
           - mediatek,mt8195-wdt
           - mediatek,mt8365-wdt
           - mediatek,mt8516-wdt
-      - items:
-          - enum:
-              - mediatek,mt2701-wdt
-              - mediatek,mt6572-wdt
-              - mediatek,mt6582-wdt
-              - mediatek,mt6797-wdt
-              - mediatek,mt7622-wdt
-              - mediatek,mt7623-wdt
-              - mediatek,mt7629-wdt
-              - mediatek,mt8173-wdt
-              - mediatek,mt8188-wdt
-              - mediatek,mt8189-wdt
-              - mediatek,mt8365-wdt
-              - mediatek,mt8516-wdt
-          - const: mediatek,mt6589-wdt
 
   reg:
     maxItems: 1
-- 
2.54.0

