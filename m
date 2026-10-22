Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676644;
	b=sDZWyoiTAajIHE88YFRUipy6z9g7JnMQTyJjd3IPzB3fRj3cs+JN6RFaHsf8Qx7PKFor
	 JLcPE/Zng4POBMngGE/VaM7N7KQ3SCAITbFdI7TXmHfAKTm6QC3Fo9plBCnW4gtMHjWyv
	 Kx1wwXrfQZWMFMs9kPRzaRcOAZmVFE8aCI5YF6rU24Wa1BS/JrpxwhDIFUKCyG/Uwvi5n
	 x/i7V+O4bz8inTh4ObjGrpxQSY9FTr8QdNxoUG5QQ2JClWQWUBSWqpqHL9/kGpTVIx3yS
	 1SIItQOQ5Y+3kie2tN0MPGzfiwKhC31Uz81eesz9jyiUARGNddCZsj8acKK7AUYnvyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G6DVWsB7UpRsSNvVhd1CX1moWgheSuxjt5mwvETtonw=;
	b=srtxeBpwC8u1S0n8n2GTiVScmbTv4oYz2o4R+GrpuLnFl3KV8xp3O8DmR9qsFczUKSs6
	 MZS88dvo+wRYm9vYI76fIddVxRT++mnCbajYHmgFOxF7mt9MNfyMJOSrfsF4dvEEsHiEa
	 4sgRX/Cj+a/ZjaWgI7P/DA3/RTNAfQ47mrce7C3UBV1y0OLfOtIPNI6GG71Edu2e/JrZA
	 AKRq5GiqldBfpRYljODcEiTVFs6tSSYcY8c+unoGqtDF0OTqmmMRAs1o3G+Iywfikw890
	 eHT9KJps8XXP/jiyVaHbeYATuRUFnsNiytHayITv744kTE0M2DOv49N6yJ2776Bu12A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="pzYi/UGa";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C960A4AD1
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41C960A4AD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pzYi/UGa
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1070244f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676642; x=1793281442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6DVWsB7UpRsSNvVhd1CX1moWgheSuxjt5mwvETtonw=;
        b=pzYi/UGaU8T3kKbukd+jWGrSWWjGfCOP2nhjP6Ad1f3R0l+51g23VnNR9NOq0hSX0f
         Az1WKU3fPfU++kDT6YcKtnz12fnKOT7eGL0akRy3qUqmshwoMsim4rJkuj9UfqNRd/rs
         DQxKZrS4Vw3otgpYNi2GWYuThVkdbhDJS1brSSU3mycuZr/1zhIZXH4jqxz0Pcc/toNM
         q9gBhTn2/5J4aJ7NjyHjNwk8TKmMquegOYqfucj+D6RDvWCx5Hp/bEU/n6L2OwKibCwo
         p7M5qlk2bAkaETi+pK8NbMwujMg9gw0lhBOrjornxtX1LFpXU8s64u+FuG5DRf1dsGIe
         AejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676642; x=1793281442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6DVWsB7UpRsSNvVhd1CX1moWgheSuxjt5mwvETtonw=;
        b=Q+gyOh5feX8GdOXoQDhHDOCxQIDS/6i5bWH88WIgHPE/ZBAN//mFsxkQKUBYEPsnfo
         w1xzamrotPof9ZBWwJvxEqLapguIzhJEqETkgQ53vDwuj4o70oCLSO16kwrW1om120vQ
         06kv23DEokQr87cuYStB+eeKpLiFuRqJ8IDQvtzBY0LSiD6ZyHA8UBaUrVCHINCnRu4Z
         7QzWlyesokdFlasgmnuu/cWnIORTID0qY0gxi6+Gq+dwkL4HNkimigXLulik/61rDt9F
         Gg0DiaXjHRivQgFFpdHmATJIpwO9tzTU95+TR+hKRgy6x7F6b1eNSg+iGDOzhd8vndDt
         CmLg==
X-Forwarded-Encrypted: i=1; AKwUvBzQCrT2bBwC72dGvuoEieGvGtaz0T+19v5LkVFQ+Xu4d5wh8DRCTu9FTqMyV5r09tfO2bZV3u57hLLvTVQKNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKuO/cGZ9e9Pk6du6BMGmCHXJXezxs/fdIjfVf5aSLUao8BoTSY
	ZU6hImBLXxltMlBSz7zSwNGfVgr1JKZccx9pDAmwOHLkiLmV4uuVNnMlD18Lmg==
X-Gm-Gg: AYBFou1rdryzy7XsV7PdWKWw0aNayngVNYbVxofBZIdmUYIibC8WNj/C8ldqCA/gaqM
	nN1rWgRLStrQmFGzx9D+Qx3Jxebul+jB0RDwzJNHTP9Dxwi3vkmXaF/cm0EO42fAKKM5D0x5fRH
	iUkzlcDgDQ7KRvAeKbPs8BD1+XropN+A57QEjgyhDlr2pNF99wIP/QFabQzwI7roBoI8j+wfeed
	Q0BNq2G9VctwVZCvTQLAJ3iG8+r19MRzOs1bEjP/0gLpU4rQNkZjkhsQWvqFvlVkkaid8H85PVJ
	/aQf3ZMNS6u7SKxY1KhnWHK7yuJrHe+JG+D7h2EQ7jQqpjPml/6NNDGosCu/JTlznTI0T4+uK56
	idlwGTvgLnSZ7+NArH5X4Gnmni5iT+qh5h9g6qdVBkuwIS3bZl4v7rrLzDMErbcM5ELlwgD9Yaz
	7A9oV+HBTyqSEvjtWxW/psXIRGEcQa3bPi9+nqb+3cGckL+NZST0gyH/7sl5tCbK5FB4zgQcG5X
	7dsVKT+imsqXl95iBaelm9rb6u/mQerlxLwj/rhxNYPf1OC6RdQ8il1Kg==
X-Received: by 2002:a05:6000:2305:b0:48b:2a1:dfe3 with SMTP id ffacd0b85a97d-48e264cd91amr12401762f8f.41.1792676642201;
        Thu, 22 Oct 2026 06:44:02 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm13621390f8f.40.2026.10.22.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:44:01 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Thu, 22 Oct 2026 16:43:50 +0300
Message-ID: <20261022134354.534642-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134354.534642-1-a.shimko.dev@gmail.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog controller reset line is not currently managed during system
suspend/resume. This can lead to an inconsistent hardware state when
resuming from suspend, as the controller may not be properly reinitialized.

Assert the reset line before disabling clocks during suspend to ensure
the controller is held in reset while power is gated. During resume,
deassert the reset after clocks are enabled and before restoring register
state to guarantee the controller is properly initialized. Add proper
error handling for reset control operations during resume with appropriate
cleanup path on failure.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2cffe337b4ea..ec6a09673da4 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -382,6 +382,8 @@ static int dw_wdt_suspend(struct device *dev)
 	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 
+	reset_control_assert(dw_wdt->rst);
+
 	clk_disable_unprepare(dw_wdt->pclk);
 	clk_disable_unprepare(dw_wdt->clk);
 
@@ -402,12 +404,22 @@ static int dw_wdt_resume(struct device *dev)
 		return err;
 	}
 
+	err = reset_control_deassert(dw_wdt->rst);
+	if (err)
+		goto unprepare_pclk;
+
 	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 
 	dw_wdt_ping(&dw_wdt->wdd);
 
 	return 0;
+
+unprepare_pclk:
+	clk_disable_unprepare(dw_wdt->pclk);
+	clk_disable_unprepare(dw_wdt->clk);
+
+	return err;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(dw_wdt_pm_ops, dw_wdt_suspend, dw_wdt_resume);
-- 
2.43.0

