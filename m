Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53933BE644
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090644; cv=none; b=TBjlEoRy2mi7u1qnqK7ZH9q9x6qexXbvjttKmYULwWvUVJeBdxG8ooZ8LIqr1k8eCGpriy+3c5xjdL7o1qh93ineSSR5S0Vh1g2qpoaNoN0co4ENz+JMKRdtuKrSSil/gEqxNs1UNcJWWssqoDHYSanfd3HUrUxy7Rrm8NcGqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090644; c=relaxed/simple;
	bh=TLaM4ipt2XvrvL65uL1X15EPNsDhuS4EXrTa53tDWfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOOjoha8cBRhgQVbmV607w3HDhc7W6Xrcn3fTCmuhC1ySsgZFF+fMRFKTXM39bAy40FhTUiO72FRlX5n+LrFvpREPBJIRb6u+DQkDUxGjQWo7vKT41ddyijsXaa0D0WyCapPophdR1sCaP1MG+hqylHKURz5mXDQCTZ6QtmALNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/f/CngN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/f/CngN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3041942a91.0
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090642; x=1786695442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhHhQhUh884edb2pkrtgwkkFMcH6OBy0eevlqyMXflE=;
        b=D/f/CngNp4w4TMyfTleHZflZQMtHsWXHqYMGkzcaZ9anqk/6kbo1RFVNyrE6YKT+ZD
         qAGKlw+jlbAULGK7xx07Q3zYqyNOJi4hImdkClRjJ2MzydMm96t22ktHgHjjxc8jCTip
         3nWm98Sqsl9vLewjaJYdxZ8tvzgehaL06soIZ9+YYvTpbg1iQB39tSCOZBjvT/D0ydf8
         NyWwyKBl0LwWB4GIJLX1fMVeGo9LB4nqLD0jEhCCKQfQTLZMxI4nqYOFhHPkJ5XOlMts
         5EyLGislUYIZg1qeO82okaI+pOPOY2eghjMBjKRkKMb5DywvaRZedj/6D+iqZJpJs3Rk
         VjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090642; x=1786695442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhHhQhUh884edb2pkrtgwkkFMcH6OBy0eevlqyMXflE=;
        b=XJYZ6VF0dkYQ+9p0FTxZxx+QMfslpEWrR4WrSqkwtlHFDGf1ajFIYW9eDkXU+6/ZtD
         vJklzMjG1sxHZaAL+19q1St7dz5Rq3FdhOyRkUTU43VhvNteDbA/YGVapsJdYHjGzPE4
         342ZC6mlyBsI7mixSZy4QQcBG5dwJ8dcRhxecf4hpcOFW048IzOxBqZl2H/Gpah8sfuF
         FdJMsbcknrU2YvOEaOSgBxD/loPfNdA+YTiJa7GzPIdmX17/LKMDQooG7++2RN2ku/g2
         HsHmDNnYOB8bYTBHnRgODgqRVxV5uCCmaguRyNAfcqsvUXCiXJyumZIR7YHG8w5CvGxD
         oE8w==
X-Forwarded-Encrypted: i=1; AHgh+Rodc+xc/CKvGWeOvbaLXpo08/9tEvRI0JYknnRFMp0oIC5FmD6fayo4v73xsg7poZajiHfMD+6gicGdbCrbYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cyVikILyc9wzJD0Sj8GQS4TpkThz0FL12MLv7fXtUcmXY1EH
	VUAQjhHHiy9C4uCKYBgRnAH07QNAOnNuUoMx1OWbljfWa65NS3eR2FDj
X-Gm-Gg: AR+sD12YKe2RBrZ3ViiBIablbQ6ws3hV7svgMix1XWzthSLJDkMC+kkgpRS4EDdXjLW
	tu5sGvYUAbryWpN+dI5LaSRTSYT0pZDr768dFNq4ZqCS7rd3auq6E1Ac5aEWFw2oMCgRMS3ksg/
	sddJl0EoiVyabwQyw72/ZgQBQ5P0KCBFLqiII7zKBsXLARPAvC23MYeJXvgRbU702sP8z7IVIQO
	KQyvF32mv4x9oN3nkOX3WsJLg84LfBciONzPgwLnUa8BGXDr/ajpkE2GrQ65jfe3CCcg4N6xdKm
	YapUHoR+84/dfbkhu/fhAdQb1XGadF71J6Gm8WAqbe7grS03ngWqqBQ1o4EPnMjc9cHDdJU51Wh
	Xeg8EMj0IUB8zbRnkdbzptP8VFYY09vC+CzJq7fNuXSE0u+xBuY2McwU2Gp3cvtP2DbG8kj44D2
	mxCWi4fyho4TocIPsl7V0YjlusMQV6KK2luAGQSzM0T2NPTwVgqpXCaqI0LkRFYh7J449Sx+wWm
	49E8UBq31hmmL5YYjzkxoDlf8Jmaaw9vhbigQHnGpR6ENT5eWcHoPsYY6A0jHPg3q3h5I6cpsVj
	MkA+
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr22557442a91.13.1786090642107;
        Fri, 07 Aug 2026 01:17:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:21 -0700 (PDT)
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
Subject: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:52 +0700
Message-ID: <20260807081652.38692-4-phucduc.bui@gmail.com>
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

Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
probe without the IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index c9e79851504c..48454ac86074 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -429,6 +429,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (wdt->cfg->irq_mask) {
 		int irq = platform_get_irq_optional(pdev, 0);
 
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
 		if (irq > 0) {
 			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
 					       IRQF_SHARED, dev_name(dev),
-- 
2.43.0

