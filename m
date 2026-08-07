Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF33128B8
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090635; cv=none; b=A0c38OwPMF0ZTAf1UUzRd4Zt9E+kr3vPZ1MzpsOmMu41eiyEMyHe7FiNUdhhzNjKi/ffGhdUcB81Xf2sKbJNoWxvkJKZDIn7oAEX0T/WnEdsa5bNQ+gvPgu4WtkYm3JqmmPmrPAwlc7EMVLPurPjyZI6axuW2iee7wF3Gq9zA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090635; c=relaxed/simple;
	bh=+d8U7eo3FoYEPxetwZLkQt58z/uMXVsRhfj2qvDre70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGT0kq+4dSRb8qLOG2l3Vmvh/XB02imQvCKJbnDXJhFln82ftmPdpaRTqeHSwvHYT2aJkvirPz8w23SmCIszZLPBH8SyOZc5vlOKGQaIM84XRO3YRighbD8OtPuI45+Kz8MbsdqTf66qz8hzx/4EcIKbqRsgJyES6ijFr+RBKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoALIiez; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoALIiez"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2920494a91.2
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090633; x=1786695433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRPg2fF5zW2ebng5FORfud2q4xXOQdkBJ5AC1S3iOZQ=;
        b=aoALIiezL/4a8A2aKz5Q4KrHqVbssmMP5mnvQT7fBPv63nLtUF+lo+1k2M5fxLFYac
         OgBnKbywba+1PZv4CMjb1BdJ4JmfQYaNs8TBhP2vXxO05S9pZc27DgTtDapPIQocpJGB
         WXNiQm0w2B9T19DalhDBMsx0piSs7gHwmYQwFMohDJqJlWuHQkE66sMEVhn/D6k8zjWK
         DvaRwIZWYYPoUuG73kwIu+EP4JFXB/yjaI3dMELbjUVuqf55Y1RSXHNlgLNEbydMw7a1
         QTbzr0qmDtyf2eGdw1yAxPxuuZETsmx09UvEoL8EhSIyOsMFU5vOlkH5yLw6aVdrZi6d
         Rt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090633; x=1786695433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRPg2fF5zW2ebng5FORfud2q4xXOQdkBJ5AC1S3iOZQ=;
        b=HRl8/P8mxJSW2TnlQMNIytvNfa75yGzGMup7qk+VIXIbRt8qyVe2sDrdzl+kT5bhfG
         zegHiKl2G0vq5rfTCBXCvLwulkmg3hqnJHb38I6XHDtSr9xPmG9/dt2RzA21AUhNcv+x
         mbwzxwc7nocr7nE1IDFoG2NcIsyvGwv6sLIro0dYLwF9oVM4tUGvzmvj/WjrcwMmAzKg
         mgNmwX7wooy4hIv3X9ca8Y6hCgUx42Fa93ALJQ2tBEaND7sQGCo+mPZ2UlmoUPjPLIDD
         sfOcXmDDSRr3zzFDjz04B0t0/qqPFkI8jq3nmozzz6iw7rUUW07kaJWa50OAtb5DQvSt
         VCGw==
X-Forwarded-Encrypted: i=1; AHgh+RodDDIifloB2+e3bYzrANMSf6zTF8Mt2x0v+n73sVzV3MH4HI0YyfmwVq8SCaMG6yDjOwVID15n+Q6vQVECig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVzlzLk35KShNHSbsKOSLt/W4/L15sh40xbBUHDDn7K1Y4c/L
	6IXw0bbhtsIJQtcfJCYCOdbVdsxtVifkhFpl75yadzymaDIi+f4MzZXMcuiKTw==
X-Gm-Gg: AR+sD13p2tW29XMZV8nnAo0Z9Y7hs0MgASy33/kStcWBo13/uG3BLIwvO7GdlicIGVV
	8ZStAahkgLnmKRDLt/grUVNA09RDbrE9w/kVwPfhgTDwGvjlBuEOLn4MghbJlWbECxho32zkE69
	A8fi9PKWF3Oz01Qx93bgi7AWFdCVdSgkFU+F84Bet8o+cWdfDS/BDSa7wN+vPZ5IrmGrKwRfWIx
	sAq5PzmvMI16XS0R43JEfh3I0qRpFQzX71+LVT3s/n+fNHTJNHiMNJ8ZnlRtpNyLJzWJtIV3TjS
	no6/DHdNtFLvXSrkd9yuleWSJ22oiOiysSnO/auVAsYNn0xDSw3M6Dr7v6qjU2+NKNYYZmHNvSk
	RaY4MNcH3ZNE6AGTBzax4WdVKzMyvBOyqsZYedxtK9JQhH1j3pzxy3JOuF8j1p+ZN7UxfwzviTe
	2WOzNf27Sr3HVb0mJzpvpXR59V5rqBosZ3owWqHcLQ0hB/qzgUeoEwrWaNLXCTyiRwR1PoHyPem
	JZs1FB2mXnmXpPVy5EvaCLZ3/mcYC7iwWSqYBtzNdTd8XFqXi6XZ1enSKlH1k85+3OKhC18ty6w
	P4CZ
X-Received: by 2002:a17:90b:274d:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3903c534d46mr24091471a91.4.1786090633235;
        Fri, 07 Aug 2026 01:17:13 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:12 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/4] watchdog: mediatek: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:50 +0700
Message-ID: <20260807081652.38692-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
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
 drivers/watchdog/mtk_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 91d110646e16..d9c30e4c80e3 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -422,8 +422,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 		mtk_wdt->wdt_dev.info = &mtk_wdt_pt_info;
 		mtk_wdt->wdt_dev.pretimeout = WDT_MAX_TIMEOUT / 2;
 	} else {
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (irq != -ENXIO)
+			return irq;
 
 		mtk_wdt->wdt_dev.info = &mtk_wdt_info;
 	}
-- 
2.43.0

