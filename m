Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94B3BB9FE
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014997; cv=none; b=UHm2XNONGFxiYzI9kvu1CA5A0KLHZVArRlpMFXjcAJPPMmiNeOY+/1X+v5LZEOfvgmdQgS+mNi5noI7E5YeCbO6PuPNT+oTfblkjwy2wXABaMMvY97lxDCsF6eWsYfLC+dX2ccIKW/xiSIsHRqu53+QQVTCwl7wRDWe5IoegT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014997; c=relaxed/simple;
	bh=XYh4dlLxQVFS+YE8tsSLsU4eF6IB91lUwXiLc2lxFiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKDgAjXeHCmyLxkK7wG1XHljFUlSr+WNxc5yAk6A17E+sLSIKoUOHOI9uKadXpXiFfFNdhpuOtZkIVPc83+Tf8RvNfHzmQhwb0K26J+vaipc4H4ALBovcncNA1+NeRUw2jKPI/E6ZGuZeUdXMXzLesnEqdYlu5dujI4jmq3xHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLLByoTo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLLByoTo"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so12566711fa.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014989; x=1774619789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHz5MtC3crd2T2peCpyj9PSNU06Ml4bYxwyLtxD0kys=;
        b=HLLByoToGiS0YUCU3nmKNVre3p/RMwY9o+SssmWAdLULrFUsCWMgmOyAXfSZzvpMfy
         zLa8FGezX0QV9X9AVpIjnCIcEYWZpERg/XuRssr76OHJPoB3T2m4uk7uOnJhTv0uX8BL
         0V+Qrq+gvVEWcDevjl2xXhfQhdI8Av5ReNNQdfseX4hNSSzgyM++PMgG72oBXueZLFYV
         UcumFlzA9oGdu25C6RmtTkmPfuBqaRhRmMezOFkFSGTD4+xrg6m1MBXCAq+OuDSGKw5b
         86OymOiydeW7oamDUpM79kUewPuGTAu3neOJdJgHN34HgarEzYzc8dvwzkV0bHll2lTA
         M9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014989; x=1774619789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHz5MtC3crd2T2peCpyj9PSNU06Ml4bYxwyLtxD0kys=;
        b=m0ubb+iA6yxgWiqH2YRHDdP0Lc+6VBHv4Uf1fMvsRggiT0KgMSc1bBuMbpAMKXyAL7
         U+QjkniFTL7/harpmGTZlugCbEKpcTEDmInssuYmMtzfxOHR1eX4UHE+smwaNPbrm/ca
         pAdzBg2CdZrr8/PvmwN/cVuswCMyG2kO0rhHfBAn9rKbdZliJxt+6Gau9oFzDJh3J9q6
         cNNs3/pAgyL0c/N9LVG0sBmbr+o8SVrC0aUs9jq8OrQymHx2ISKfhOZzw4oVUd26SNGI
         yOKXIYEP/va3+W0q4zgYhYhIN5tKXz5Lt7HOXMP6+91QhD70amJZ3FMMw0ISn2j5aSj9
         sBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVYIW7qIdCcmOgK92Z0sRKszKJN4h0MH32NKCUXL+x4E6BM/bCYfRAZ1o0sx21EmVS7I7iEuwWInJdHmvnyVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFChvwsWWHP5oy9Hqz1Nt1k9vrwKN2T2IL3YvFSMFKbDar7uB
	zyZLWspLjlr7JWuMCtXDyu9o8boX0VaM2tdF8MNvdmafuNV5jieqIFHe
X-Gm-Gg: ATEYQzyNPWoVX4K67tPbojGW1430xB26x7SwkP3zFwmRk5UcXfpjYV/JTOo8hf25H1S
	Ty5MbLyUfgCgydP05AaeO624ezHIrptAprXw2KA4XQEKoDeMoWFj/ntdRp+BB32WNWwFDCgAqxR
	cOZ6W9UgWL0S6vOhPncPKAAC6VIkjZDeoZmRQpwaqpm14et67RjMejA3JTPGsj6+Xh8bKs80Wfr
	HVk0FwD+AlQWGuktX4vIXh+dyEOnWNAiZT1SSD8pg1v+9n63hvUz3Pf3I23xLT6G1r08YEM3x3B
	H1F9jLDh/P2Qcfb+IIyYw+jI/q2dXDsLl+ZnwwFMmVeIS3lSlzxC7Y5x/zvFcXdwYelhIvorcl7
	3vvlKDa/YbHPO8JfyGw7VkOOwF2a10nJC5hs+T+rRI/rhT3zpLnZKKOEDLEOYH6An8gQzFmevq6
	22S9fAJiLCq5zou7c6n8V3xvvri2ts8Ccc/vMUC1aLwg==
X-Received: by 2002:a05:651c:401b:b0:38a:4de2:85d7 with SMTP id 38308e7fff4ca-38bf96477b9mr7236551fa.3.1774014988449;
        Fri, 20 Mar 2026 06:56:28 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:28 -0700 (PDT)
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
Subject: [PATCH 1/5] watchdog: dw_wdt: move reset control deassertion before register access
Date: Fri, 20 Mar 2026 16:56:18 +0300
Message-ID: <20260320135624.223863-2-a.shimko.dev@gmail.com>
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

The watchdog controller must be taken out of reset before any register
access is attempted. Currently reset_control_deassert() is called after
dw_wdt_update_mode() which performs register read/write operations. If
the reset line is asserted, accessing registers may result in undefined
behavior or bus hangs.

Move reset_control_deassert() before dw_wdt_update_mode() to ensure the
controller is properly deasserted before the first register access. The
reset_control_assert() in the error path remains to properly revert the
reset state on probe failure.

Fixes: 46a1946314bf ("watchdog: dw_wdt: Add pre-timeouts support")
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c3fbb6068c52..3450402b7707 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -592,6 +592,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt->rst))
 		return PTR_ERR(dw_wdt->rst);
 
+	reset_control_deassert(dw_wdt->rst);
+
 	/* Enable normal reset without pre-timeout by default. */
 	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
 
@@ -617,8 +619,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 		dw_wdt->wdd.info = &dw_wdt_ident;
 	}
 
-	reset_control_deassert(dw_wdt->rst);
-
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
 		goto out_assert_rst;
-- 
2.43.0

