Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED123BB134
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359083; cv=none; b=V2R9ER3X5hjQezOKQLlhxIaxSYLJMS8jULI1o8DqjtUieCXtUUXB/yYGI3IT/s5TvH3hueo26Ouk3ZsVhFVXBHGPjlsnv7u80WhlItM5tbT/fUEwimWbEQocou8Sh+JkwRR13+NDjGJA9FMPqPPGNjBAz/XZf3Rh3qpdagcukIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359083; c=relaxed/simple;
	bh=YQ61MLDivYrChA93Z1oiQfr3MErrYOCY+tdqp0c0Lf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnftqUauplv718D3z/mGYj4BJM0bLU0Hpn941gztxqmMJ8ciTmU7WgmxRvcoAklY9+8AKfQqBy3+y2ISjGhX65ngEkko5/8MQACmMWI2KRVQ2Fc2CaYLvRnmuvuAdJL1CXkZBK6xI5qpk49FZTxho4S0grBgAKdtSatJ0DpXJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBZIlvlP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBZIlvlP"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1471909a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786359081; x=1786963881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PuJ6x2zkITh7GZS5epmVnODSBm6oxe8knuYTtm1XBZ0=;
        b=iBZIlvlPVF5xpM/AK9Z8A3szgwbnhlmhTjFiUBDwLHQTy9mlT259INmD5/+G1YKzRC
         ooN+c4InJRrs+p1tSg4e6qreZRkUIY29u6uvYiezcUKiW8p6HunFBDH/GSjyuPgeROqw
         eChVnJJ9BernrEUCzjzAW15MjppfpmEmCq+J6YjEzWuXPBVBie9L+io2nRxLvPfitV1N
         z5KPGL3BNhuFkHxD1efxaF/G2I71g/mQH3e5oLbiTvVFhA0gtv+oYFRsH6lPHAisCtKB
         PXyl43wA0U98Ey+xZvsvAJn/tibUq6w4F8aKYOxAL1nM5SBG8bCwNqggYZ3y14kk3d8J
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786359081; x=1786963881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PuJ6x2zkITh7GZS5epmVnODSBm6oxe8knuYTtm1XBZ0=;
        b=IAPzbyEFKEYCZ5dBNS+loXIRJaacgWRCjtN6u51U613KdsPBUrIP6NWBXiCxzTSq5r
         sOXMg7th6gKO7OYbYRj/B3WT4ntY+9em6MUXJZ1RP2tguoJiS6Q+Bgq2StVzcMmkKt+k
         5M7LWc/BSBiyiupxV0NzZe6KGQ7eU5q1GDesKBMY/eRyqFktDxlsas4wggNYJ34exfNw
         C8COC9iD6vKplR7rZX5n9OR6Mb3tZXHlYLFxXmDbnkToURrOIlv1osNeEuQ1LjfgiMZV
         eXcxpZxlnbAzHshGPuJp6BBiwQpG5x9kpzhJ7sNJZKUdmEvl4gwfHkzAR7y7aYeEs/fV
         OVVA==
X-Forwarded-Encrypted: i=1; AHgh+RoUA50km80eZeuxFqG7I74+Qdurg5zxxrBpkI+2HbFtTnvYxa/VPnojL5KvfBPmsKWBoPywpxhp2HzkLVO+PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGifwOO5m6E6LexDtkyMPwJ6bWfJ6MK5r7HyHyhNp+cwuGAcM0
	Lc7AsJgJ2PsWeEwnXuqu02lWzTzhZFbL+r70TbmSBHIILpuXyBqQQ7RS
X-Gm-Gg: AR+sD11aJaTs5IiaXIW+vxMxYuZ7OlY0lp8IEMKt5+sadhvQyeg9JndUzTqsDXoaoOo
	GY0Fh4TO5RcDQ6GHQ/LiOvNGmVDfGwmXDnYWhg5v7ijlfCMeMa0IvY0aBJ2/BXCy0r8s8wZUWTd
	vBqRMfJiumjERIfqUFspjgGhAjkvGgH6SUWOrHxp2UigTIfyii7/tZd1ean8bHm8jhScmfKFZu8
	tDf0HS1p0hLlNgvO8ONVhKPCvRCJmKeh9PmaqcU0Ytk5An3uj3rbH6ydfKBaD3sz9K5GB1DXY9g
	Hhw+NLRxfWqZAkP0qCqRLcTL7SwAK7aNxZ3t5NYPjr01ib971Tg68pEpua2NN5Pc9H8faNDvb7T
	Vzu1Yre5AWNjpv/g4J3GnDBuVPZKqJlYdYI9XKD9LcGCanQfTsJQwf12WvroZ3C3GJHmsJEyXZs
	XGnsDPdC2UYfogSpKWA8fzK0biZ+BRSpAoEhiekgfyLfMjuu+h19bXci9XQUxXagWMw9g3SdfSN
	ftTBeumWn3Q328Pc0mA4yb7kVEjFYvTDTIuPP/E3qJAjD+zwkku4Fc+IAaB67pubdY6Ggnfn/mN
	Oqvw
X-Received: by 2002:a17:90b:2245:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-3903c542a40mr34920645a91.2.1786359081519;
        Mon, 10 Aug 2026 03:51:21 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95c40sm12240771a91.8.2026.08.10.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:51:21 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3] watchdog: qcom: Propagate errors from optional IRQ lookup
Date: Mon, 10 Aug 2026 17:51:01 +0700
Message-ID: <20260810105101.55945-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1 : 
https://lore.kernel.org/all/20260807081652.38692-1-phucduc.bui@gmail.com/
Changes in v2 : 
 - Update pretimeout handling based on Guenter's review.

Link v2 : 
https://lore.kernel.org/all/20260810102144.51663-1-phucduc.bui@gmail.com/
Changes in v3:
 - Update the handling of wdt->wdd.info based on Sashiko's review.


 drivers/watchdog/qcom-wdt.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 49bd04841f0c..74ac3c507c01 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -287,21 +287,22 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	wdt->wdd.info = &qcom_wdt_info;
+
 	/* check if there is pretimeout support */
-	irq = platform_get_irq_optional(pdev, 0);
-	if (data->pretimeout && irq > 0) {
-		ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
-				       "wdt_bark", &wdt->wdd);
-		if (ret)
-			return ret;
+	if (data->pretimeout) {
+		irq = platform_get_irq_optional(pdev, 0);
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
+		if (irq > 0) {
+			ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
+					       "wdt_bark", &wdt->wdd);
+			if (ret)
+				return ret;
 
-		wdt->wdd.info = &qcom_wdt_pt_info;
-		wdt->wdd.pretimeout = 1;
-	} else {
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		wdt->wdd.info = &qcom_wdt_info;
+			wdt->wdd.info = &qcom_wdt_pt_info;
+			wdt->wdd.pretimeout = 1;
+		}
 	}
 
 	wdt->wdd.ops = &qcom_wdt_ops;
-- 
2.43.0

