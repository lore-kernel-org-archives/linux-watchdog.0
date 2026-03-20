Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8003AC0E7
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015004; cv=none; b=Z6gs2L0LdTz6/IkeHDwyLgNdhjJO9M+Qh/84CwlYAoQouTvhyxm9vO3gkCANKlPjCvvbKrAVY2Dnd8hLxAkkxXjwEPuFE885vM6GWuqHhrkMqEcODRi0GVMfzX0raspobJuALVz8NucNItQ3zX/9kz3lsi5sZq5zdJ+dUDpbO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015004; c=relaxed/simple;
	bh=DJqR/GuGiyjFacMfnO65zKo7aAil9mPZDEMDYiKQFnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbHrkef1XK7LOr1p8+yAkJn9PFp7siIm7lMfQVKki8rK5bghotPG3fILcHDyslyfg/eCIk+pAspjWu4mjTeHVGJavX/6pzF6p42FTUzB3xjOZnVyBUgkjs5ZC28PI5zrBMarlNZFDEumbIF1RRBHCVd9hYg/P/YcA6WXQp79QTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlcjXwoQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlcjXwoQ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38b3ee785a5so18537921fa.1
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014994; x=1774619794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHTbck32azNpAhgT1Zm/ogIs8OYnc3TttHl66QfiMdA=;
        b=IlcjXwoQEW0x3H1bSZcbJHdDTF6h7z5E/KCN8fsgYqS6+YGFi1u1gb0mb2YauMUMW4
         5HYXCtvREyAHQXkXZgbTOxyIbYjHERylRgxRCuFcqKM/zh9Wcp09TLNbSFb4V48x6P9c
         LQIlvdGHkhMVu8+WgTS97067mUUyYaQl6AyJkLzMP7j1+QAwdA1mXy0wS/FPzRgEXgI0
         Ddhxo/dq8vKvs9xzVmFdHSsY4qaoxOeceOYmdl69RNGEguh0ZWt02okgaiLZRNzeK8wh
         7F+gzjMZCODhpzxMBBTJdwC84lGSp83X0yRU5dEVzFAfIPbCbcxMX+CCE3KZBB6dKpC8
         1JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014994; x=1774619794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHTbck32azNpAhgT1Zm/ogIs8OYnc3TttHl66QfiMdA=;
        b=FbOjQaQYiEWLkX+kyCPFtUi7XopEcLvS8wKUhtgdeXnuHdEEm4ReDHQurqnpTxFFh+
         PCjwJU7cRvZuyhhS1gTr+qPZQrJLAVeFOu//X6imyI1XunYkuaq/GVY8IN8ZD/UwGzly
         luhCJjIbq42N66EbcSaPwfzmH14Om0TC4syptYnPSbTvhNwmZXB/wDOYKO3zVRtwqVZT
         sNqhhRHOWh9Room+D3SCJgWfR3cq8ZT54MOGy1MohmD0aTS00qrE+a/Vzk3oG7xwSzS7
         8pKrVpG+c7WYdxbsvbCogGqCZtrXr3S5uivPQ/33DfBaT4V2PlQLXXu75fqjR7IoEhH4
         KHoA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXsK1NCmw7Ub4vtAm7ymMZbIeHHjb7s2m1CZBBbGerI6uFvGrJ4EVjUTz1WpZQQ9wqJoasjWP6wZ7V8R3hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoAAcH0CDweYD3sLjkLPjGpJINBrzaqgswNY8UUrw8yfHX0nc
	ML2J8WLDzfsbwumhMjweug5RCmRhks5YVVzAnn+1CbIsUMwloJBcm1bnKP93Hw==
X-Gm-Gg: ATEYQzz5VxsHD4R8/SxXkaVBUi+XuVyXaf1pGBdVrB0owig2ZZaLql7zhu/JK7G/ho3
	c1UbGMjTdBsJw6FNYETNVS+CoIRzqALVAr5KZ4VOk2fDHu9a+g057rLUt7aQpIk/8x+uOGwfLbm
	Vfo+st/hXReevePvmF2xxscx3RpCKJDtDXxEZ3GFHOxcaWpfMC/onq0UstgOB0h4i5vcYRaX8Ki
	eLj/n3bhgE1ulCiO8Mgb45TwXmYHtmK44RvuD7zHuNPcOZ3mM3ODQAYXqAdQaeTITYTNNJ+4V8y
	Zp7gXe9IrgeKm/29lu9OfArKcotcfo9UiSYlUyWUtE/BNtjbIGMBEJWMaH5yyJrUxVTSbo8irm+
	anqj+Yu55U+e0+KYLR8XHARVjrihHNPvaWXI8kVrw9/md5QYWLPx4XACj/CF36WsTH5ktCjsUrd
	Oq9fJbMssNj91n+1nkEV5cuGWBqdM3TEMVwNqMZwc7/g==
X-Received: by 2002:a05:651c:4209:b0:38a:4e8d:747 with SMTP id 38308e7fff4ca-38bf9c9d8d6mr8871791fa.1.1774014994190;
        Fri, 20 Mar 2026 06:56:34 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:33 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] watchdog: dw_wdt: clean up error paths in resume function
Date: Fri, 20 Mar 2026 16:56:22 +0300
Message-ID: <20260320135624.223863-6-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320135624.223863-1-a.shimko.dev@gmail.com>
References: <20260320135624.223863-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up of dw_wdt_resume() function.

Rework the error handling to use properly named labels that match the
cleanup order. Use unprepare_clk for clock disable and unprepare_pclk
for pclk disable path.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c2c5dc6e54e7..c89e1fb91b1f 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -393,16 +393,15 @@ static int dw_wdt_suspend(struct device *dev)
 static int dw_wdt_resume(struct device *dev)
 {
 	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
-	int err = clk_prepare_enable(dw_wdt->clk);
+	int err;
 
+	err = clk_prepare_enable(dw_wdt->clk);
 	if (err)
 		return err;
 
 	err = clk_prepare_enable(dw_wdt->pclk);
-	if (err) {
-		clk_disable_unprepare(dw_wdt->clk);
-		return err;
-	}
+	if (err)
+		goto unprepare_clk;
 
 	err = reset_control_deassert(dw_wdt->rst);
 	if (err)
@@ -415,8 +414,9 @@ static int dw_wdt_resume(struct device *dev)
 
 	return 0;
 
-unprepare_clk:
+unprepare_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
+unprepare_clk:
 	clk_disable_unprepare(dw_wdt->clk);
 
 	return err;
-- 
2.43.0

