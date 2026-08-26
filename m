Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B43921F0
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724553; cv=none; b=Oz6jaSvIJWKEXvKnwyH+cn5Al40Tu/qA0UGrfOanG3m0Vi6Pa7JykzAIZpGsKfM1yHN2R9i+BZvEtTndFj0I0UdrWtGQbs4Fqs7AfqBiH4ViEHx2irekLwX73/rrk+pdtaqyiBszgbWFAY3NGps6zYxSpGhgROnQeesF8Hu4cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724553; c=relaxed/simple;
	bh=eDCFlBqkLmm/6vPatIeMPdaPPgd5rWsfGet8uV8+iRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5h4u1WhpSK/lc9lMziBVPUDVHWknPnSeRYqlb4fvg1W9okOdTBGkOoS2hxGfeHZPzO2ObZVky6ODUbFe1XoEn30nQc75rdrlJJrpJeBpTBwclh1FGSm3tpsNdSRpWecbS9s+t/MOf8/wOiK/QFMA+v16i2Cp/jqh+VJaNEZQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGwGBmNw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGwGBmNw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6e954afbdso4788735ad.2
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724549; x=1788329349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kTi44QDi512pfaWJlurcVRMKgR0oRp7lA2ts/nPhcZc=;
        b=nGwGBmNwa+fA7JPQYNBXGi66TLUWu78Tl8eTU8PnGkGFDSbeY117kxhRnOF9wiyOQC
         PX7ub+UXJy/5lOTkM2AojSv3D0oB9mWcWxnG+SXEkfTaQL27DrTttaGfRjbelEg+V+3m
         4dQFZ1D324MO4Jl54RGZ2NdIddEQGdqPRt+FjHKXnUp44pbqBmiXHtDUhG0ti/OR80OE
         KQ8SeuBhZm+y/Un7R9qWYnjOrhvxbBwmaoXh7lBNlrI9a1VtarJk+ogs44ciliRyy+pZ
         ReaJ2GdWTxUXkXP92j+H1+uKph5zncRtDDq2VNAeWE/vcrbH8Ap3bvCIz0eGufMUxy0/
         wOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724549; x=1788329349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kTi44QDi512pfaWJlurcVRMKgR0oRp7lA2ts/nPhcZc=;
        b=AA8H4Wla0Pzx9DQMgH9YCTFfpfQlxwk9vaFMMby4L2UK9P3eg74eYOjPiHR/a6Rxo0
         p6tBYHCUCmPudpQeGGM7he2zJfYuOzvMuwpPGlKZHdW68A7fVBwAINXTmFI0EgHVUL6A
         JF7Fav/ZzMLaR1DIU3DrlGSFfEPTMWWF1kHOjyhFGhJqvzQbIPO63XyogwnFxanR+EhY
         PPt8SxhxzePJ3u4qGAyMg6BNU7/HuCegOyqfaaIoNv+6fjnJ2QwCxOTi3+4khu9FwfGN
         Q8by690xTg/1a9NTYwG7jTrqVYPVnu+ImhVGA+rgXRdvrADDjP+SI+8woeNJyEgs/e80
         foSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1yjizXXyjPmE+wVtLayg60lq3x6sfxLP81gNEIeIwht9In0bz8iT63tuU34K1MQ8dEi9apDv8OUxl1lP4qA==@vger.kernel.org
X-Gm-Message-State: AFuF++lYHBYkRyS5xXpg5g3f7oo9HTtUJ6/PZseGB5RhUmAEir0CKIPN
	5O9HlFx2FOHb49fDV3CTou8AUNPNhPLiOMNQqMHtorOjZ9WESQ+S0PI=
X-Gm-Gg: AR+sD11nA1/YbFBJC0MMwocg2RBV9v063T1hgV0Zwv4UuYf3NfpRS4fngLaodibQnrs
	v1HAo4FEcTgLzSFYu+wdWUKmgvnHLwjJAACW0RiEYIYvMgVHiqhzHQ3x4mwKk+09geP642oIoxA
	Ntlhw/GQcWgUU3saNYNxAC35UJNm+j9ut2MYpopGPcdaZ3SxIFxitTO1swFE79x6tOT5NHjsSjM
	/bIFyCzFvsA/4o6f7p2YlCRRTEKD4nP6f5h0b7Iu94tAMBKamU/XqbEwSGA13vDexmh6Kw4u40s
	7vVazZittt101Btp0D+1t2gb7aOTzRH+okcyhhzVUgIX3Dg/izeJjlOY0im+QfY1cB44v2tZUkh
	xDHHJL5zEt8LgyQNGah8Uu53Y0x2dipJMouiWnS9GUKa/GFMeUOalvdXHwDQEUbSgrCRtnOtjhZ
	/E0jPp0FYxZOhdeqCIDm8yfiTNWSiWniKSkeuL1CgeZ9RJjtKgNgdVNJIg8w7xSGk/HDAmPNM9o
	A==
X-Received: by 2002:a17:90b:52c8:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-3966d191092mr10259453a91.5.1787724548597;
        Tue, 25 Aug 2026 23:09:08 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:08 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 2/8] watchdog: da9062: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:33 +0700
Message-ID: <20260826060839.203297-3-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/da9062_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 426962547df1..2b6946478527 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -248,7 +248,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-static int __maybe_unused da9062_wdt_suspend(struct device *dev)
+static int da9062_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -262,7 +262,7 @@ static int __maybe_unused da9062_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused da9062_wdt_resume(struct device *dev)
+static int da9062_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -276,14 +276,14 @@ static int __maybe_unused da9062_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
 			 da9062_wdt_suspend, da9062_wdt_resume);
 
 static struct platform_driver da9062_wdt_driver = {
 	.probe = da9062_wdt_probe,
 	.driver = {
 		.name = "da9062-watchdog",
-		.pm = &da9062_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&da9062_wdt_pm_ops),
 		.of_match_table = da9062_compatible_id_table,
 	},
 };
-- 
2.53.0

